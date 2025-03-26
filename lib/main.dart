import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/screens/welcome_screen.dart';
import 'package:pursenal/utils/services/notification_servie.dart';
import 'package:pursenal/providers/theme_provider.dart';
import 'package:pursenal/screens/main_screen.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/screens/profile_selection_screen.dart';
import 'package:pursenal/utils/app_logger.dart';
import 'package:path/path.dart' as p;
import 'package:pursenal/viewmodels/app_viewmodel.dart';
import 'package:pursenal/widgets/shared/loading_body.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;

Future<String> _getDatabasePath() async {
  final appDir = await getApplicationSupportDirectory();
  return p.join(appDir.path, 'db', 'app_database.sqlite');
}

DatabaseConnection _backgroundConnection(String path) {
  final database = NativeDatabase(File(path));
  return DatabaseConnection(database);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.instance.info("Application started");

  tz.initializeTimeZones();

  await NotificationService.init((String? payload) {
    if (payload != null) {
      navigatorKey.currentState?.pushNamed(payload).then((_) {});
    }
  });

  // Precompute the database path
  final dbPath = await _getDatabasePath();

  // Pass a synchronous function to spawn
  final isolate = await DriftIsolate.spawn(() => _backgroundConnection(dbPath));

  final connection = await isolate.connect();
  final themeProvider = ThemeProvider();
  await themeProvider.init();

  runApp(MultiProvider(
    providers: [
      Provider<MyDatabase>(
        create: (context) => MyDatabase(connection, "b"),
        dispose: (context, db) => db.close(),
      ),
      ChangeNotifierProvider<AppViewmodel>(
        create: (context) =>
            AppViewmodel(db: context.read<MyDatabase>())..init(),
      ),
      ChangeNotifierProvider<ThemeProvider>.value(
        value: themeProvider,
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Provider.of<AppViewmodel>(context);
    final ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return AdaptiveTheme(
      light: themeProvider.getLightTheme(),
      dark: themeProvider.getDarkTheme(),
      initial: AdaptiveThemeMode.light,
      builder: (light, dark) => MaterialApp(
        debugShowCheckedModeBanner: false,
        navigatorKey: navigatorKey,
        localizationsDelegates: const [
          AppLocalizations.delegate, // Add this line
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale('en'), // English
        ],
        routes: {"/profiles": (context) => const ProfileSelectionScreen()},
        theme: light,
        darkTheme: dark,
        title: AppLocalizations.of(context)?.pursenal ?? "Pursenal",
        home: Consumer<AppViewmodel>(
          builder: (context, viewmodel, child) => LoadingBody(
            loadingStatus: viewmodel.loadingStatus,
            errorText: viewmodel.errorText,
            widget: viewmodel.selectedProfile == null
                ? const WelcomeScreen()
                : MainScreen(
                    profile: viewmodel.selectedProfile!,
                  ),
            resetErrorTextFn: () {
              viewmodel.resetErrorText();
            },
          ),
        ),
      ),
    );
  }
}

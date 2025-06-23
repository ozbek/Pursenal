import 'dart:io';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:drift/drift.dart';
import 'package:drift/isolate.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/app/global/values.dart';
import 'package:pursenal/core/repositories/drift/account_types_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/accounts_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/balances_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/banks_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/budgets_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/ccards_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/file_paths_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/loans_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/payment_reminders_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/people_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/profiles_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/projects_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/receivables_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/transactions_drift_repository.dart';
import 'package:pursenal/core/repositories/drift/wallets_drift_repository.dart';
import 'package:pursenal/screens/welcome_screen.dart';
import 'package:pursenal/utils/services/notification_service.dart';
import 'package:pursenal/providers/theme_provider.dart';
import 'package:pursenal/screens/main_screen.dart';
import 'package:pursenal/core/db/app_drift_database.dart';
import 'package:pursenal/screens/profile_selection_screen.dart';
import 'package:pursenal/utils/app_logger.dart';
import 'package:path/path.dart' as p;
import 'package:pursenal/viewmodels/app_viewmodel.dart';
import 'package:pursenal/widgets/shared/loading_body.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:timezone/data/latest.dart' as tz;

// Get the database path for Drift
Future<String> _getDatabasePath() async {
  final appDir = await getApplicationSupportDirectory();
  return p.join(appDir.path, 'db', 'app_drift_database.sqlite');
}

// Opens a Drift database connection
DatabaseConnection _backgroundConnection(String path) {
  final database = NativeDatabase(File(path));
  return DatabaseConnection(database);
}

// Intended to use for navigating to transaction entry screen on clicking reminder notification
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppLogger.instance.info("Application started");

  await requestNotificationPermission();

  tz.initializeTimeZones();

  // Function to divert user to a certain page when clicked on the notification. Currently the ProfileSelectionScreen. Not working if app is closed.
  await NotificationService.init((String? payload) {
    if (payload != null) {
      navigatorKey.currentState?.pushNamed(payload).then((_) {});
    }
  });

  // Precompute the database path
  final dbPath = await _getDatabasePath();

  // Pass a synchronous function to spawn Drift database in a separate isolate
  final isolate = await DriftIsolate.spawn(() => _backgroundConnection(dbPath));
  final connection = await isolate.connect();

  // The ThemeProvider for the App.
  final themeProvider = ThemeProvider();
  await themeProvider.init();

  runApp(MultiProvider(
    // The repositories as per the MVVM architecture used are initialised here as providers and then passed on to viewmodels to commmunicate with the database.
    providers: [
      Provider<AppDriftDatabase>(
        create: (context) => AppDriftDatabase(connection, "b"),
        dispose: (context, db) => db.close(),
      ),
      Provider<ProfilesDriftRepository>(
        create: (context) =>
            ProfilesDriftRepository(context.read<AppDriftDatabase>()),
      ),
      ChangeNotifierProvider<AppViewmodel>(
        create: (context) =>
            AppViewmodel(context.read<ProfilesDriftRepository>())..init(),
      ),
      Provider<AccountTypesDriftRepository>(
        create: (context) =>
            AccountTypesDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<AccountsDriftRepository>(
        create: (context) =>
            AccountsDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<BalancesDriftRepository>(
        create: (context) =>
            BalancesDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<BanksDriftRepository>(
        create: (context) =>
            BanksDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<BudgetsDriftRepository>(
        create: (context) =>
            BudgetsDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<CCardsDriftRepository>(
        create: (context) =>
            CCardsDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<LoansDriftRepository>(
        create: (context) =>
            LoansDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<PeopleDriftRepository>(
        create: (context) =>
            PeopleDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<ReceivablesDriftRepository>(
        create: (context) =>
            ReceivablesDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<WalletsDriftRepository>(
        create: (context) =>
            WalletsDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<TransactionsDriftRepository>(
        create: (context) =>
            TransactionsDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<ProjectsDriftRepository>(
        create: (context) =>
            ProjectsDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<PaymentRemindersDriftRepository>(
        create: (context) =>
            PaymentRemindersDriftRepository(context.read<AppDriftDatabase>()),
      ),
      Provider<FilePathsDriftRepository>(
        create: (context) =>
            FilePathsDriftRepository(context.read<AppDriftDatabase>()),
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
          AppLocalizations.delegate,
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
        title: AppLocalizations.of(context)?.pursenal ?? appName,
        home: Consumer<AppViewmodel>(
          builder: (context, viewmodel, child) => LoadingBody(
            loadingStatus: viewmodel.loadingStatus,
            errorText: viewmodel.errorText,
            widget: viewmodel.selectedProfile == null
                // If the user hasn't yet created a profile, they are forwarded to WelcomeScreen
                ? const WelcomeScreen()
                : MainScreen(
                    profile: viewmodel.selectedProfile!,
                  ),
            resetErrorTextFn: () {
              viewmodel.resetErrorText();
            },
            isFirstScreen: true,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/screens/project_entry_screen.dart';
import 'package:pursenal/screens/project_screen.dart';
import 'package:pursenal/viewmodels/projects_viewmodel.dart';
import 'package:pursenal/widgets/shared/loading_body.dart';
import 'package:pursenal/widgets/shared/search_field.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pursenal/widgets/shared/the_divider.dart';

class ProjectsScreen extends StatelessWidget {
  const ProjectsScreen({super.key, required this.profile});
  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context);
    return ChangeNotifierProvider<ProjectsViewmodel>(
      create: (context) => ProjectsViewmodel(
        db: db,
        profile: profile,
      )..init(),
      builder: (context, child) => Consumer<ProjectsViewmodel>(
        builder: (context, viewmodel, child) => Scaffold(
          appBar: AppBar(),
          body: LoadingBody(
            loadingStatus: viewmodel.loadingStatus,
            errorText: viewmodel.errorText,
            resetErrorTextFn: () {
              viewmodel.resetErrorText();
            },
            widget: LayoutBuilder(
              builder: (context, constraints) {
                bool isWide = constraints.maxWidth > 800;

                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: ProjectsList(
                        viewmodel: viewmodel,
                        isWide: isWide,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProjectEntryScreen(profile: profile),
                  )).then((_) {
                viewmodel.init();
              });
            },
            heroTag: "addProject",
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

class ProjectsList extends StatelessWidget {
  const ProjectsList({
    super.key,
    required this.viewmodel,
    required this.isWide,
  });

  final ProjectsViewmodel viewmodel;
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: smallWidth),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Text(
                  AppLocalizations.of(context)!.myProjects,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
            SearchField(searchFn: (term) {
              viewmodel.searchTerm = term;
            }),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...viewmodel.statusCriterias.map((s) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2),
                        child: FilterChip(
                          showCheckmark: false,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          label: Text(s.label),
                          onSelected: (v) {
                            viewmodel.addToFilter(status: s);
                          },
                          selected: !viewmodel.statusFilters.contains(s),
                        ),
                      ))
                ],
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const TheDivider(
              indent: 0,
            ),
            Expanded(child: Builder(builder: (_) {
              if (viewmodel.searchLoadingStatus == LoadingStatus.completed) {
                return ListView.builder(
                  itemCount: viewmodel.fProjects.length,
                  padding: const EdgeInsets.only(bottom: 50),
                  itemBuilder: (context, index) {
                    final p = viewmodel.fProjects[index];

                    return ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProjectScreen(
                                profile: viewmodel.profile,
                                projectID: p.id,
                              ),
                            )).then((_) {
                          viewmodel.init();
                        });
                      },
                      shape: Border(
                          bottom: BorderSide(
                              color: Theme.of(context).shadowColor,
                              width: 0.10)),
                      title: Text(p.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      trailing: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            p.status.label,
                            overflow: TextOverflow.ellipsis,
                          )),
                      subtitle: Text(p.description ?? ""),
                    );
                  },
                )
                    .animate(delay: 100.ms)
                    .scale(begin: const Offset(1.02, 1.02), duration: 100.ms)
                    .fade(curve: Curves.easeInOut, duration: 100.ms);
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }))
          ],
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:pursenal/app/global/dimensions.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/project_status.dart';
import 'package:pursenal/core/models/project_plan.dart';
import 'package:pursenal/screens/project_entry_screen.dart';
import 'package:pursenal/viewmodels/app_viewmodel.dart';
import 'package:pursenal/viewmodels/project_viewmodel.dart';
import 'package:pursenal/widgets/shared/loading_body.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:pursenal/widgets/shared/transactions_list.dart';
import 'package:pursenal/widgets/shared/transactions_list_wide.dart';

class ProjectScreen extends StatelessWidget {
  const ProjectScreen({
    super.key,
    required this.profile,
    required this.projectID,
  });
  final Profile profile;
  final int projectID;

  @override
  Widget build(BuildContext context) {
    final db = Provider.of<MyDatabase>(context);
    final appViewmodel = Provider.of<AppViewmodel>(context);
    return ChangeNotifierProvider<ProjectViewmodel>(
      create: (context) =>
          ProjectViewmodel(profile: profile, db: db, projectID: projectID)
            ..init(),
      child: Consumer<ProjectViewmodel>(
        builder: (context, viewmodel, child) {
          return Scaffold(
            appBar: AppBar(
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProjectEntryScreen(
                                profile: profile,
                                projectPlan: viewmodel.projectPlan),
                          )).then((v) {
                        viewmodel.refetchProject();
                      });
                    },
                    icon: const Icon(Icons.edit)),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: IconButton(
                      color: Colors.red,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState) {
                                return AlertDialog(
                                  title: Text(AppLocalizations.of(context)!
                                      .deleteThisProjectQn),
                                  content: CheckboxListTile(
                                    shape: const Border(
                                      bottom: BorderSide(
                                          color: Colors.transparent, width: 0),
                                    ),
                                    value:
                                        viewmodel.deleteTransactionsWithProject,
                                    title: const Text(
                                        "Delete related transactions also?"),
                                    onChanged: (v) {
                                      if (v != null) {
                                        setState(() {
                                          viewmodel
                                              .deleteTransactionsWithProject = v;
                                        });
                                      }
                                    },
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () async {
                                        final hasDeleted =
                                            await viewmodel.deleteProject();
                                        if (hasDeleted && context.mounted) {
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        }
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.delete,
                                        style: const TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        viewmodel
                                                .deleteTransactionsWithProject =
                                            false;
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                          AppLocalizations.of(context)!.cancel),
                                    )
                                  ],
                                );
                              },
                            );
                          },
                        );
                      },
                      icon: const Icon(Icons.delete)),
                ),
                const SizedBox(
                  width: 12,
                )
              ],
            ),
            body: LoadingBody(
                loadingStatus: viewmodel.loadingStatus,
                errorText: viewmodel.errorText,
                widget: LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWide = constraints.maxWidth > 800;
                    if (viewmodel.projectPlan != null) {
                      ProjectPlan projectPlan = viewmodel.projectPlan!;
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            height: viewmodel.headerHeight,
                            curve: Curves.easeInOut,
                            child: Center(
                              child: SizedBox(
                                width: smallWidth,
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 16),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                viewmodel
                                                    .projectPlan!.project.name,
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .headlineMedium,
                                              ),
                                            ),
                                          )
                                              .animate()
                                              .scale(
                                                  begin:
                                                      const Offset(1.02, 1.02),
                                                  duration: 100.ms)
                                              .fade(
                                                  curve: Curves.easeInOut,
                                                  duration: 100.ms),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 2, horizontal: 16),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                viewmodel.projectPlan!.project
                                                        .description ??
                                                    "",
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium,
                                              ),
                                            ),
                                          )
                                              .animate(delay: 50.ms)
                                              .scale(
                                                  begin:
                                                      const Offset(1.02, 1.02),
                                                  duration: 100.ms)
                                              .fade(
                                                  curve: Curves.easeInOut,
                                                  duration: 100.ms),
                                          Visibility(
                                            visible:
                                                projectPlan.project.startDate !=
                                                    null,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 16),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.startDate} ${appViewmodel.dateFormat.format(projectPlan.project.startDate ?? DateTime.now())}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                          )
                                              .animate(delay: 100.ms)
                                              .scale(
                                                  begin:
                                                      const Offset(1.02, 1.02),
                                                  duration: 100.ms)
                                              .fade(
                                                  curve: Curves.easeInOut,
                                                  duration: 100.ms),
                                          Visibility(
                                            visible:
                                                projectPlan.project.endDate !=
                                                    null,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 2,
                                                      horizontal: 16),
                                              child: Align(
                                                alignment: Alignment.centerLeft,
                                                child: Text(
                                                  "${AppLocalizations.of(context)!.endDate} ${appViewmodel.dateFormat.format(projectPlan.project.endDate ?? DateTime.now())}",
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .labelMedium,
                                                ),
                                              ),
                                            ),
                                          )
                                              .animate(delay: 150.ms)
                                              .scale(
                                                  begin:
                                                      const Offset(1.02, 1.02),
                                                  duration: 100.ms)
                                              .fade(
                                                  curve: Curves.easeInOut,
                                                  duration: 100.ms),
                                          Visibility(
                                            visible:
                                                viewmodel.projectPlan != null,
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: ActionChip(
                                                    avatar: const Icon(
                                                      Icons.edit,
                                                      color: Colors.white,
                                                    ),
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (context) =>
                                                            SimpleDialog(
                                                          title: Text(AppLocalizations
                                                                  .of(context)!
                                                              .select(AppLocalizations
                                                                      .of(context)!
                                                                  .projectStatus)),
                                                          children: [
                                                            ...ProjectStatus
                                                                .values
                                                                .map((p) =>
                                                                    ListTile(
                                                                      title: Text(
                                                                          p.label),
                                                                      onTap:
                                                                          () async {
                                                                        final bool
                                                                            ss =
                                                                            await viewmodel.changeProjectStatus(p);
                                                                        if (ss) {
                                                                          viewmodel
                                                                              .refetchProject();
                                                                        }
                                                                        if (context
                                                                            .mounted) {
                                                                          Navigator.pop(
                                                                              context);
                                                                        }
                                                                      },
                                                                    )),
                                                            const SizedBox(
                                                              height: 12,
                                                            )
                                                          ],
                                                        ),
                                                      );
                                                    },
                                                    color:
                                                        WidgetStatePropertyAll(
                                                            Theme.of(context)
                                                                .primaryColor),
                                                    label: Text(
                                                      viewmodel.projectPlan!
                                                          .project.status.label,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                    )),
                                              ),
                                            ),
                                          )
                                              .animate(delay: 250.ms)
                                              .scale(
                                                  begin:
                                                      const Offset(1.02, 1.02),
                                                  duration: 100.ms)
                                              .fade(
                                                  curve: Curves.easeInOut,
                                                  duration: 100.ms),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                            visible: projectPlan.photos.isNotEmpty,
                                            child: Container(
                                              height: 150,
                                              padding:
                                                  const EdgeInsets.all(14.0),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  spacing: 8,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: projectPlan.photos
                                                      .mapIndexed(
                                                          (index, filePath) {
                                                    return Material(
                                                      elevation: 3,
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(0),
                                                        child: GestureDetector(
                                                          onTap: () {
                                                            showDialog(
                                                              context: context,
                                                              builder:
                                                                  (context) =>
                                                                      Stack(
                                                                children: [
                                                                  Dialog(
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    shape: Border
                                                                        .all(),
                                                                    child:
                                                                        SizedBox(
                                                                      child: Image
                                                                          .file(
                                                                        errorBuilder: (context,
                                                                                error,
                                                                                stackTrace) =>
                                                                            const Center(
                                                                          child:
                                                                              Padding(
                                                                            padding:
                                                                                EdgeInsets.all(8.0),
                                                                            child:
                                                                                Text("Media error"),
                                                                          ),
                                                                        ),
                                                                        File(filePath
                                                                            .path),
                                                                        fit: BoxFit
                                                                            .fitWidth,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Positioned(
                                                                    top: -5,
                                                                    right: -5,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                          .all(
                                                                          24.0),
                                                                      child:
                                                                          IconButton(
                                                                        onPressed:
                                                                            () {
                                                                          Navigator.pop(
                                                                              context);
                                                                        },
                                                                        icon:
                                                                            const Icon(
                                                                          Icons
                                                                              .close,
                                                                          color:
                                                                              Colors.red,
                                                                          size:
                                                                              30,
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          },
                                                          child: ConstrainedBox(
                                                            constraints:
                                                                const BoxConstraints(
                                                                    maxWidth:
                                                                        50,
                                                                    maxHeight:
                                                                        50),
                                                            child: Image.file(
                                                              errorBuilder: (context,
                                                                      error,
                                                                      stackTrace) =>
                                                                  const Center(
                                                                child: Padding(
                                                                  padding:
                                                                      EdgeInsets
                                                                          .all(
                                                                              8.0),
                                                                  child: Text(
                                                                      "Media error"),
                                                                ),
                                                              ),
                                                              File(filePath
                                                                  .path),
                                                              width: 50,
                                                              fit: BoxFit.fill,
                                                            ),
                                                          )
                                                              .animate(
                                                                  delay: (index *
                                                                          50)
                                                                      .ms)
                                                              .fade(
                                                                  duration:
                                                                      250.ms),
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ))
                                        .animate(delay: 200.ms)
                                        .scale(
                                            begin: const Offset(1.02, 1.02),
                                            duration: 100.ms)
                                        .fade(
                                            curve: Curves.easeInOut,
                                            duration: 100.ms),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: viewmodel.transactions.isNotEmpty,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 16),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  AppLocalizations.of(context)!.transactions,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                              ),
                            ),
                          ),
                          Visibility(
                            visible: viewmodel.transactions.isNotEmpty,
                            child: Expanded(
                              child: TransactionsSection(
                                  viewmodel: viewmodel,
                                  isWide: isWide,
                                  constraints: constraints),
                            ),
                          ),
                          Visibility(
                              visible: viewmodel.transactions.isEmpty,
                              child: const SizedBox(
                                height: 200,
                                child: Center(
                                  child: Text("No transactions"),
                                ),
                              ))
                        ],
                      );
                    }

                    return const Center(
                      child: Text("Project not found"),
                    );
                  },
                ),
                resetErrorTextFn: () {
                  viewmodel.resetErrorText();
                }),
          );
        },
      ),
    );
  }
}

class TransactionsSection extends StatelessWidget {
  const TransactionsSection(
      {super.key,
      required this.viewmodel,
      required this.isWide,
      required this.constraints});

  final ProjectViewmodel viewmodel;
  final bool isWide;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final appViewmodel = Provider.of<AppViewmodel>(context);
    if (!appViewmodel.isPhone) {
      return TransactionsListWide(
          scrollController: viewmodel.scrollController,
          fTransactions: viewmodel.transactions,
          profile: viewmodel.profile,
          initFn: () {
            viewmodel.init();
          });
    }
    return TransactionsList(
        scrollController: viewmodel.scrollController,
        fDates: viewmodel.fDates,
        fTransactions: viewmodel.transactions,
        profile: viewmodel.profile,
        initFn: () {
          viewmodel.init();
        });
  }
}

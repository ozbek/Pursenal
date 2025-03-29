import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/enums/project_status.dart';
import 'package:pursenal/core/models/double_entry.dart';
import 'package:pursenal/core/models/project_plan.dart';
import 'package:pursenal/core/repositories/projects_drift_repository.dart';
import 'package:pursenal/core/repositories/transactions_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';

class ProjectViewmodel extends ChangeNotifier {
  final ProjectsDriftRepository _projectsDriftRepository;
  final TransactionsDriftRepository _transactionsDriftRepository;

  final int projectID;

  ProjectPlan? _projectPlan;

  // ignore: unnecessary_getters_setters
  ProjectPlan? get projectPlan => _projectPlan;

  set projectPlan(ProjectPlan? value) => _projectPlan = value;

  final Profile _profile;
  Profile get profile => _profile;

  LoadingStatus loadingStatus = LoadingStatus.idle;
  String errorText = "";

  List<DoubleEntry> transactions = [];
  Set<DateTime> fDates = {};

  double? headerHeight;
  bool isHidden = false;
  final ScrollController scrollController = ScrollController();
  bool _deleteTransactionsWithProject = false;

  ProjectViewmodel(
      {required this.projectID,
      required Profile profile,
      required MyDatabase db})
      : _profile = profile,
        _projectsDriftRepository = ProjectsDriftRepository(db),
        _transactionsDriftRepository = TransactionsDriftRepository(db);

  init() async {
    try {
      loadingStatus = LoadingStatus.loading;
      scrollController.addListener(updateHeaderVisibility);
      notifyListeners();
      try {
        await refetchProject();
        await _getTransactions();
        loadingStatus = LoadingStatus.completed;
      } catch (e) {
        loadingStatus = LoadingStatus.error;
        errorText = "Cannot load Project";
      }
      notifyListeners();
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: Failed to initialise Project';
      loadingStatus = LoadingStatus.error;
      notifyListeners();
    }
  }

  Future<void> _getTransactions() async {
    try {
      if (projectPlan != null) {
        transactions =
            await _transactionsDriftRepository.getDoubleEntriesbyProject(
                profileID: _profile.id, projectID: projectPlan!.project.id);
        fDates = transactions.map((t) {
          return t.transaction.vchDate.copyWith(
              hour: 0, minute: 0, second: 0, microsecond: 0, millisecond: 0);
        }).toSet();
      }
    } catch (e) {
      AppLogger.instance.error('Failed to get transactions ${e.toString()}');
      errorText = 'Error: Failed to get transactions';
    }
    notifyListeners();
  }

  bool get deleteTransactionsWithProject => _deleteTransactionsWithProject;

  set deleteTransactionsWithProject(bool value) {
    _deleteTransactionsWithProject = value;
    notifyListeners();
  }

  deleteProject({deleteTransactions = false}) async {
    try {
      if (_projectPlan != null) {
        _projectsDriftRepository.deleteProject(_projectPlan!.project.id,
            deleteTransactions: _deleteTransactionsWithProject);
        return true;
      }
      return false;
    } catch (e) {
      loadingStatus = LoadingStatus.error;
      errorText = "Couldn't delete project";
      return false;
    }
  }

  Future<bool> changeProjectStatus(ProjectStatus status) async {
    try {
      if (_projectPlan != null) {
        final p = _projectPlan!.project;
        _projectsDriftRepository.updateProjectStatus(
            id: p.id,
            name: p.name,
            profile: _profile.id,
            projectStatus: status);
        return true;
      }
      return false;
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: ';
      return false;
    }
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }

  Future<void> refetchProject() async {
    try {
      loadingStatus = LoadingStatus.loading;
      _projectPlan =
          await _projectsDriftRepository.getProjectPlanById(projectID);
      if (_projectPlan != null && _projectPlan?.project.budget != null) {}

      loadingStatus = LoadingStatus.completed;
    } catch (e) {
      errorText = "Failed to fetch project";
      loadingStatus = LoadingStatus.error;
    }
    notifyListeners();
  }

  void updateHeaderVisibility() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!isHidden && transactions.length > 8) {
        isHidden = true;
        headerHeight = 0;
        notifyListeners();
      }
    } else if (scrollController.position.userScrollDirection ==
        ScrollDirection.forward) {
      if (isHidden) {
        isHidden = false;
        headerHeight = null;
        notifyListeners();
      }
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}

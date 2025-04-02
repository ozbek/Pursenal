import 'package:flutter/foundation.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/enums/project_status.dart';
import 'package:pursenal/core/repositories/acc_types_drift_repository.dart';
import 'package:pursenal/core/repositories/projects_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';

class ProjectsViewmodel extends ChangeNotifier {
  final ProjectsDriftRepository _projectsDriftRepository;
  final AccTypesDriftRepository _accTypesDriftRepository;

  ProjectsViewmodel(
      {required MyDatabase db, required Profile profile, int accTypeID = 4})
      : _profile = profile,
        _accTypeID = accTypeID,
        _projectsDriftRepository = ProjectsDriftRepository(db),
        _accTypesDriftRepository = AccTypesDriftRepository(db);

  int _accTypeID;

  get accTypeID => _accTypeID;

  bool isPayment = false;

  final Profile _profile;
  Profile get profile => _profile;

  List<Project> _projects = [];
  List<Project> _fProjects = [];

  AccType? _accType;
  get accType => _accType;

  List<AccType> accTypes = [];

  set accType(value) => _accType = value;

  LoadingStatus loadingStatus = LoadingStatus.idle;
  LoadingStatus searchLoadingStatus = LoadingStatus.idle;

  String _searchTerm = "";

  String get searchTerm => _searchTerm;
  List<Project> get fProjects => _fProjects;

  Set<ProjectStatus> statusCriterias = {};
  Set<ProjectStatus> statusFilters = {};

  Future<void> init() async {
    loadingStatus = LoadingStatus.loading;
    try {
      await setAccType(_accTypeID);
      loadingStatus = LoadingStatus.completed;
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      loadingStatus = LoadingStatus.error;
      errorText = 'Error: Failed to initialise projects';
    }
    notifyListeners();
  }

  set searchTerm(String value) {
    _searchTerm = value.toLowerCase();
    _filterProjects();
  }

  String errorText = "";

  set accTypeID(final value) {
    _accTypeID = value;
    setAccType(_accTypeID);
    notifyListeners();
  }

  Future<void> getProjects() async {
    try {
      _projects = await _projectsDriftRepository.getAllProjects(profile.id);
      _projects.sort(
        (a, b) => a.status.index.compareTo(b.status.index),
      );
      statusCriterias = _projects.map((a) => a.status).toSet();
      AppLogger.instance.info("Projects loaded from database");
    } catch (e) {
      AppLogger.instance.error("Error loading projects ${e.toString()}");
    }
    notifyListeners();
  }

  _filterProjects() {
    searchLoadingStatus = LoadingStatus.loading;
    notifyListeners();
    try {
      _fProjects = List.from(_projects);
      _fProjects = _fProjects
          .where((a) => a.toString().contains(_searchTerm))
          .where((aa) => !statusFilters.contains(aa.status))
          .toList();

      searchLoadingStatus = LoadingStatus.completed;
    } catch (e) {
      searchLoadingStatus = LoadingStatus.error;
      AppLogger.instance.error("Failed to filter Projects. ${e.toString()}");
    }

    notifyListeners();
  }

  addToFilter({ProjectStatus? status}) async {
    if (status != null) {
      if (statusFilters.contains(status)) {
        statusFilters.remove(status);
      } else {
        statusFilters.add(status);
      }
    }

    notifyListeners();
    _filterProjects();
  }

  setAccType(int id) async {
    _accType = await _accTypesDriftRepository.getById(id);
    notifyListeners();
    await getProjects();
    _filterProjects();
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }
}

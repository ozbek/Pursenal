import 'package:flutter/foundation.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/enums/project_status.dart';
import 'package:pursenal/core/models/project_plan.dart';
import 'package:pursenal/core/repositories/projects_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';

class ProjectEntryViewmodel extends ChangeNotifier {
  final ProjectsDriftRepository _projectsDriftRepository;

  ProjectEntryViewmodel({
    required MyDatabase db,
    required Profile profile,
    Project? project,
    ProjectPlan? projectPlan,
  })  : _projectsDriftRepository = ProjectsDriftRepository(db),
        _project = project,
        _projectPlan = projectPlan,
        _profile = profile;
  LoadingStatus loadingStatus = LoadingStatus.idle;
  final Profile _profile;
  Project? _project;

  Project? get project => _project;
  // ignore: prefer_final_fields
  ProjectPlan? _projectPlan;

  final List<Project> _projects = [];
  String _projectName = "";
  String? _description;
  DateTime? _startDate;
  DateTime? _endDate;
  ProjectStatus _projectStatus = ProjectStatus.pending;
  Budget? _budget;
  String get projectName => _projectName;
  List<String> mediaPaths = [];

  set projectName(String value) {
    _projectName = value;
    notifyListeners();
  }

  String? get description => _description;

  set description(String? value) {
    _description = value;
    notifyListeners();
  }

  DateTime? get startDate => _startDate;

  set startDate(DateTime? value) {
    _startDate = value;
    notifyListeners();
  }

  DateTime? get endDate => _endDate;

  set endDate(DateTime? value) {
    _endDate = value;
    notifyListeners();
  }

  ProjectStatus get projectStatus => _projectStatus;

  set projectStatus(ProjectStatus value) {
    _projectStatus = value;
    notifyListeners();
  }

  Budget? get getBudget => _budget;

  set setBudget(Budget? budget) {
    _budget = budget;
    notifyListeners();
  }

  Future<void> getProjects() async {
    // _projects = await _projectsDriftRepository.getAll();
    notifyListeners();
  }

  set project(Project? project) {
    if (_projectPlan != null) {
      loadingStatus = LoadingStatus.loading;

      _projectName = _projectPlan!.project.name;
      _description = _projectPlan!.project.description;
      _startDate = _projectPlan!.project.startDate;
      _endDate = _projectPlan!.project.endDate;
      _projectStatus = _projectPlan!.project.status;
      mediaPaths = _projectPlan!.photos.map((p) => p.path).toList();

      loadingStatus = LoadingStatus.completed;
      notifyListeners();
    }
  }

  // Error text variables
  String nameError = "";
  String descriptionError = "";

  String errorText = "";

  void init() async {
    try {
      loadingStatus = LoadingStatus.loading;
      notifyListeners();
      project = _project;
      getProjects();
      loadingStatus = LoadingStatus.completed;

      notifyListeners();
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: Failed to initialise project form';
      loadingStatus = LoadingStatus.error;
      notifyListeners();
    }
  }

  void addImage(String path) async {
    if (!mediaPaths.contains(path)) {
      mediaPaths.add(path);
      notifyListeners();
    }
  }

  void removeImage(String path) async {
    if (mediaPaths.contains(path)) {
      mediaPaths.remove(path);
      notifyListeners();
    }
  }

  bool _validate() {
    bool isValid = true;
    nameError = "";

    notifyListeners();

    if (projectName.isEmpty) {
      nameError = "Name cannot be empty";
      isValid = false;
    }
    if (_project == null &&
        _projects.where((p) => p.name == _projectName).isNotEmpty) {
      nameError = "Project name already exist";
      isValid = false;
    }
    notifyListeners();
    return isValid;
  }

  Future<bool> save() async {
    if (_validate()) {
      loadingStatus = LoadingStatus.submitting;
      notifyListeners();
      if (_projectPlan == null) {
        int newPro = await _projectsDriftRepository.insertProject(
            name: _projectName,
            budget: _budget?.id,
            profile: _profile.id,
            description: _description,
            startDate: _startDate,
            endDate: _endDate,
            filePaths: mediaPaths,
            projectStatus: _projectStatus);
        _project = await _projectsDriftRepository.getById(newPro);
      } else {
        await _projectsDriftRepository.updateProject(
            profile: _profile.id,
            id: _projectPlan!.project.id,
            name: _projectName,
            budget: _budget?.id,
            description: _description,
            startDate: _startDate,
            endDate: _endDate,
            filePaths: mediaPaths,
            projectStatus: _projectStatus);
      }

      loadingStatus = LoadingStatus.submitted;
      notifyListeners();
      return true;
    }

    notifyListeners();
    return false;
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }
}

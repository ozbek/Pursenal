import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/models/budget_plan.dart';
import 'package:pursenal/core/repositories/budgets_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';

class BudgetsViewmodel extends ChangeNotifier {
  final BudgetsDriftRepository _budgetsDriftRepository;

  BudgetsViewmodel(
      {required MyDatabase db, required Profile profile, int accTypeID = 4})
      : _profile = profile,
        _budgetsDriftRepository = BudgetsDriftRepository(db);

  final Profile _profile;
  Profile get profile => _profile;

  List<BudgetPlan> _budgetPlans = [];
  List<BudgetPlan> _fBudgetPlans = [];

  LoadingStatus loadingStatus = LoadingStatus.idle;
  LoadingStatus searchLoadingStatus = LoadingStatus.idle;

  String _searchTerm = "";

  String get searchTerm => _searchTerm;
  List<BudgetPlan> get fBudgetPlans => _fBudgetPlans;

  Future<void> init() async {
    try {
      loadingStatus = LoadingStatus.loading;
      scrollController.addListener(updateHeaderVisibility);
      await _getBudgets();
      _filterBudgets();
      loadingStatus = LoadingStatus.completed;
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
      errorText = 'Error: Failed to initialise Budgets';
      loadingStatus = LoadingStatus.error;
      notifyListeners();
    }
  }

  set searchTerm(String value) {
    _searchTerm = value.toLowerCase();
    _filterBudgets();
  }

  String errorText = "";

  Future<void> _getBudgets() async {
    try {
      _budgetPlans =
          await _budgetsDriftRepository.getAllBudgetPlans(profile.id);

      AppLogger.instance.info("BudgetPlans loaded from database");
    } catch (e) {
      AppLogger.instance.error("Error loading budgetPlans ${e.toString()}");
    }
    notifyListeners();
  }

  _filterBudgets() {
    searchLoadingStatus = LoadingStatus.loading;
    notifyListeners();
    try {
      _fBudgetPlans = List.from(_budgetPlans);
      _fBudgetPlans = _fBudgetPlans
          .where((a) => a.toString().contains(_searchTerm))
          .toList();

      searchLoadingStatus = LoadingStatus.completed;
    } catch (e) {
      searchLoadingStatus = LoadingStatus.error;
      AppLogger.instance.error("Failed to filter Budgets. ${e.toString()}");
    }

    notifyListeners();
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }

  final ScrollController scrollController = ScrollController();

  double? headerHeight;
  bool isHidden = false;

  void updateHeaderVisibility() {
    if (scrollController.position.userScrollDirection ==
        ScrollDirection.reverse) {
      if (!isHidden && _fBudgetPlans.length > 3) {
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

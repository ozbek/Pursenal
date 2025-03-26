import 'package:drift/drift.dart';
import 'package:pursenal/core/abstracts/base_repository.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/budget_interval.dart';
import 'package:pursenal/core/models/budget_plan.dart';
import 'package:pursenal/utils/app_logger.dart';

class BudgetsDriftRepository
    implements BaseRepository<Budget, BudgetsCompanion> {
  BudgetsDriftRepository(this.db);
  final MyDatabase db;

  @override
  Future<int> delete(int id) async {
    try {
      return await db.deleteBudget(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete Budget. ${e.toString()}");
      rethrow;
    }
  }

  @override
  Future<Budget> getById(int id) async {
    try {
      return await db.getBudgetbyId(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get Budget. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<Budget>> getAllBudgets(int profile) async {
    try {
      return await db.getBudgetsByProfile(profile);
    } catch (e) {
      AppLogger.instance.error("Failed to get Budget list. ${e.toString()}");
      rethrow;
    }
  }

  Future<int> insertBudget(String name, String details, List<int> funds,
      Map<int, int> accounts, BudgetInterval interval, int profile) async {
    try {
      BudgetsCompanion b = BudgetsCompanion.insert(
          name: name, interval: interval, details: details, profile: profile);

      final bId = await db.insertBudget(b);

      for (var i in funds) {
        await db.insertBudgetFund(
            BudgetFundsCompanion.insert(account: i, budget: bId));
      }

      accounts.forEach((k, v) async {
        if (v != 0) {
          await db.insertBudgetAccount(BudgetAccountsCompanion.insert(
              account: k, budget: bId, amount: Value(v)));
        }
      });

      return bId;
    } catch (e) {
      AppLogger.instance.error("Failed to insert Budget. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateBudget(
      int id,
      String name,
      String details,
      List<int> funds,
      Map<int, int> accounts,
      BudgetInterval interval,
      int profile) async {
    try {
      BudgetsCompanion b = BudgetsCompanion.insert(
          id: Value(id),
          name: name,
          interval: interval,
          details: details,
          profile: profile);

      await db.updateBudget(b);

      await db.deleteBudgetAccountByBudget(id);
      await db.deleteBudgetFundByBudget(id);

      for (var i in funds) {
        await db.insertBudgetFund(
            BudgetFundsCompanion.insert(account: i, budget: id));
      }

      accounts.forEach((k, v) async {
        if (v != 0) {
          await db.insertBudgetAccount(BudgetAccountsCompanion.insert(
              account: k, budget: id, amount: Value(v)));
        }
      });

      return true;
    } catch (e) {
      AppLogger.instance.error("Failed to update Budget. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<BudgetFund>> getAllBudgetFunds() async {
    try {
      return await db.getBudgetFunds();
    } catch (e) {
      AppLogger.instance.error("Failed to get Budget list. ${e.toString()}");
      rethrow;
    }
  }

  Future<int> insertBudgetFund(BudgetFundsCompanion b) async {
    try {
      return await db.insertBudgetFund(b);
    } catch (e) {
      AppLogger.instance.error("Failed to insert Budget. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateBudgetFund(BudgetFundsCompanion b) async {
    try {
      return await db.updateBudgetFund(b);
    } catch (e) {
      AppLogger.instance.error("Failed to update Budget fund. ${e.toString()}");
      rethrow;
    }
  }

  Future<int> deleteBudgetFund(int id) async {
    try {
      return await db.deleteBudgetFund(id);
    } catch (e) {
      AppLogger.instance.error("Failed to delete Budget fund. ${e.toString()}");
      rethrow;
    }
  }

  Future<BudgetFund> getBudgetFundById(int id) async {
    try {
      return await db.getBudgetFundbyId(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get Budget fund. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<BudgetPlan>> getAllBudgetPlans(int profileID) async {
    try {
      return await db.getAllBudgetPlans(profileID);
    } catch (e) {
      AppLogger.instance.error("Failed to get Budget plans. ${e.toString()}");
      rethrow;
    }
  }

  Future<List<BudgetAccount>> getAllBudgetAccounts() async {
    try {
      return await db.getBudgetAccounts();
    } catch (e) {
      AppLogger.instance
          .error("Failed to get Budget Accounts. ${e.toString()}");
      rethrow;
    }
  }

  Future<int> insertBudgetAccount(BudgetAccountsCompanion b) async {
    try {
      return await db.insertBudgetAccount(b);
    } catch (e) {
      AppLogger.instance
          .error("Failed to insert Budget Account. ${e.toString()}");
      rethrow;
    }
  }

  Future<bool> updateBudgetAccount(BudgetAccountsCompanion b) async {
    try {
      return await db.updateBudgetAccount(b);
    } catch (e) {
      AppLogger.instance
          .error("Failed to update Budget Account. ${e.toString()}");
      rethrow;
    }
  }

  Future<int> deleteBudgetAccount(int id) async {
    try {
      return await db.deleteBudgetAccount(id);
    } catch (e) {
      AppLogger.instance
          .error("Failed to delete Budget Account. ${e.toString()}");
      rethrow;
    }
  }

  Future<BudgetAccount> getBudgetAccountById(int id) async {
    try {
      return await db.getBudgetAccountbyId(id);
    } catch (e) {
      AppLogger.instance.error("Failed to get Budget Account. ${e.toString()}");
      rethrow;
    }
  }
}

import 'package:pursenal/app/global/values.dart';

class DBUtils {
  static bool isAssetOrExpense(int accType) {
    return [cashTypeID, bankTypeID, expenseTypeID, advanceTypeID, peopleTypeID]
        .contains(accType);
  }

  static bool isLiabilityOrIncome(int accType) {
    return [cCardTypeID, loanTypeID, incomeTypeID].contains(accType);
  }
}

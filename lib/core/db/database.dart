import 'dart:io';
import 'package:drift/drift.dart';
import 'package:pursenal/app/global/values.dart';
import 'package:pursenal/core/enums/budget_interval.dart';
import 'package:pursenal/core/enums/currency.dart';
import 'package:pursenal/core/enums/primary_type.dart';
import 'package:pursenal/core/enums/voucher_type.dart';
import 'package:pursenal/core/models/budget_plan.dart';
import 'package:pursenal/core/models/double_entry.dart';
import 'package:pursenal/core/models/drift_models.dart';
import 'package:pursenal/core/models/ledger.dart';
import 'package:pursenal/utils/app_logger.dart';
import 'package:pursenal/utils/db_utils.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  AccTypes,
  Accounts,
  Transactions,
  Users,
  Banks,
  Wallets,
  Loans,
  CCards,
  Balances,
  FilePaths,
  Profiles,
  Budgets,
  BudgetAccounts,
  BudgetFunds,
])
class MyDatabase extends _$MyDatabase {
  // we tell the database where to store the data with this constructor
  MyDatabase(DatabaseConnection super.connection, this.dbName);

  final String dbName;
  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(beforeOpen: (details) async {
      await customStatement('PRAGMA foreign_keys = ON');
    }, onCreate: (Migrator m) async {
      await m.createAll();
      await insertAccType(const AccTypesCompanion(
          id: Value(cashTypeID),
          name: Value("Wallets"),
          primary: Value(PrimaryType.asset)));
      await insertAccType(const AccTypesCompanion(
          id: Value(bankTypeID),
          name: Value("Banks"),
          primary: Value(PrimaryType.asset)));
      await insertAccType(const AccTypesCompanion(
          id: Value(cCardTypeID),
          name: Value("Credit Cards"),
          primary: Value(PrimaryType.liability)));
      await insertAccType(const AccTypesCompanion(
          id: Value(loanTypeID),
          name: Value("Loans"),
          primary: Value(PrimaryType.liability)));
      await insertAccType(const AccTypesCompanion(
          id: Value(incomeTypeID),
          name: Value("Incomes"),
          primary: Value(PrimaryType.income)));
      await insertAccType(const AccTypesCompanion(
          id: Value(expenseTypeID),
          name: Value("Expenses"),
          primary: Value(PrimaryType.expense)));
      await insertAccType(const AccTypesCompanion(
          id: Value(advanceTypeID),
          name: Value("Receivables"),
          primary: Value(PrimaryType.asset)));
      await insertAccType(const AccTypesCompanion(
          id: Value(peopleTypeID),
          name: Value("People"),
          primary: Value(PrimaryType.asset)));
    }, onUpgrade: (Migrator m, int from, int to) async {
      if (from < 3) {
        // we added the dueDate property in the change from version 1 to
        // version 2
      }
      if (from < 3) {
        // we added the priority property in the change from version 1 or 2
        // to version 3
      }
    });
  }

  Future<void> deleteAll(int id) async {
    await (delete(transactions)).go();
    await (delete(accounts)).go();
    await (delete(accTypes)).go();
  }

  Future<List<AccType>> getAccTypes() async {
    return await select(accTypes).get();
  }

  Future<AccType> getAccTypeById(int id) async {
    return await (select(accTypes)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<AccType> getAccTypeByType(int type) async {
    return await (select(accTypes)..where((tbl) => tbl.primary.equals(type)))
        .getSingle();
  }

  // Future<bool> updateAccType(AccTypesCompanion companion) async {
  //   return await update(accTypes).replace(companion);
  // }

  Future<int> insertAccType(AccTypesCompanion companion) async {
    return await into(accTypes).insert(companion);
  }

  // Future<int> deleteAccType(int id) async {
  //   return await (delete(accTypes)..where((tbl) => tbl.id.equals(id))).go();
  // }

  Future<Account> getAccountbyId(int id) async {
    return await (select(accounts)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<void> insertAccounts(List<AccountsCompanion> accountsList) async {
    await transaction(() async {
      final insertedIds = <int>[];

      for (final account in accountsList) {
        // Check if the account already exists for the profile
        final existingAccount = await (select(accounts)
              ..where((a) => a.name.equals(account.name.value))
              ..where((a) => a.profile.equals(account.profile.value)))
            .getSingleOrNull();

        if (existingAccount == null) {
          // Insert if no duplicate exists
          final id = await into(accounts).insert(account);
          insertedIds.add(id);
        }
      }

      // Insert balances for newly added accounts
      if (insertedIds.isNotEmpty) {
        final balancesList = insertedIds.map((accountId) {
          return BalancesCompanion(
            account: Value(accountId),
            amount: const Value(0),
          );
        }).toList();

        await batch((batch) {
          batch.insertAll(balances, balancesList);
        });
      }
    });
  }

  Future<List<Account>> getAccountsByProfile(int id) async {
    return await (select(accounts)
          ..where((tbl) => tbl.profile.equals(id))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<List<Account>> getAccountsByAccType(int id, int accType) async {
    return await (select(accounts)
          ..where((tbl) => tbl.profile.equals(id) & tbl.accType.equals(accType))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<List<Account>> getFundingAccounts(int profile) async {
    return await (select(accounts)
          ..where((tbl) =>
              tbl.profile.equals(profile) & tbl.accType.isIn(fundingAccountIDs))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<List<Account>> getFundAccounts(int profile) async {
    return await (select(accounts)
          ..where(
              (tbl) => tbl.profile.equals(profile) & tbl.accType.isIn(fundIDs))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<List<Account>> getCreditAccounts(int profile) async {
    return await (select(accounts)
          ..where((tbl) =>
              tbl.profile.equals(profile) & tbl.accType.isIn(creditIDs))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<bool> updateAccount(AccountsCompanion companion) async {
    return await update(accounts).replace(companion);
  }

  Future<int> insertAccount(AccountsCompanion companion) async {
    return await into(accounts).insert(companion);
  }

  Future<int> deleteAccount(int id) async {
    return await (delete(accounts)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<Transaction> getTransactionById(int id) async {
    return await (select(transactions)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<bool> updateTransaction(TransactionsCompanion companion) async {
    return await update(transactions).replace(companion);
  }

  Future<int> insertTransaction(TransactionsCompanion companion) async {
    return await into(transactions).insert(companion);
  }

  Future<int> deleteTransaction(int id) async {
    final fps = await (select(filePaths)
          ..where((tbl) => tbl.transaction.equals(id)))
        .get();

    // Delete files from FilePaths before deleting the transaction
    for (final filePath in fps) {
      try {
        final file = File(filePath.path!);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        AppLogger.instance.error("Cannot delete transaction image");
      }
    }

    return await (delete(transactions)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<Transaction>> getTransactionsByProfile(int id) async {
    return await (select(transactions)..where((tbl) => tbl.profile.equals(id)))
        .get();
  }

  Future<List<Profile>> getProfiles() async => select(profiles).get();

  Future<int> insertProfile(ProfilesCompanion business) =>
      into(profiles).insert(business);

  Future<bool> updateProfile(ProfilesCompanion business) =>
      update(profiles).replace(business);

  Future<int> deleteProfile(int id) =>
      (delete(profiles)..where((tbl) => tbl.id.equals(id))).go();

  Future<Profile> getProfileById(int id) =>
      (select(profiles)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<Profile?> getSelectedProfile() async {
    final selectedProfile = await (select(profiles)
          ..where((tbl) => tbl.isSelected.equals(true)))
        .getSingleOrNull();
    if (selectedProfile != null) {
      return selectedProfile;
    }
    final firstProfile = await (select(profiles)..limit(1)).getSingleOrNull();
    return firstProfile;
  }

  Future<void> setSelectedProfile(int id) async {
    await (update(profiles)..where((tbl) => tbl.isSelected.equals(true)))
        .write(const ProfilesCompanion(isSelected: Value(false)));
    await (update(profiles)..where((tbl) => tbl.id.equals(id)))
        .write(const ProfilesCompanion(isSelected: Value(true)));
  }

  Future<int> insertBank(BanksCompanion bank) => into(banks).insert(bank);
  Future<bool> updateBank(BanksCompanion bank) => update(banks).replace(bank);
  Future<int> deleteBank(int id) =>
      (delete(banks)..where((t) => t.id.equals(id))).go();
  Future<Bank> getBankById(int id) =>
      (select(banks)..where((t) => t.id.equals(id))).getSingle();

  Future<Bank> getBankByAccount(int id) =>
      (select(banks)..where((t) => t.account.equals(id))).getSingle();

  Future<int> insertCCard(CCardsCompanion card) => into(cCards).insert(card);
  Future<bool> updateCCard(CCardsCompanion card) =>
      update(cCards).replace(card);
  Future<int> deleteCCard(int id) =>
      (delete(cCards)..where((t) => t.id.equals(id))).go();
  Future<CCard> getCCardById(int id) =>
      (select(cCards)..where((t) => t.id.equals(id))).getSingle();
  Future<CCard> getCCardByAccount(int id) =>
      (select(cCards)..where((t) => t.account.equals(id))).getSingle();

  Future<int> insertLoan(LoansCompanion loan) => into(loans).insert(loan);
  Future<bool> updateLoan(LoansCompanion loan) => update(loans).replace(loan);
  Future<int> deleteLoan(int id) =>
      (delete(loans)..where((t) => t.id.equals(id))).go();
  Future<Loan> getLoanById(int id) =>
      (select(loans)..where((t) => t.id.equals(id))).getSingle();
  Future<Loan> getLoanByAccount(int id) =>
      (select(loans)..where((t) => t.account.equals(id))).getSingle();

  Future<int> insertWallet(WalletsCompanion wallet) =>
      into(wallets).insert(wallet);
  Future<bool> updateWallet(WalletsCompanion wallet) =>
      update(wallets).replace(wallet);
  Future<int> deleteWallet(int id) =>
      (delete(wallets)..where((t) => t.id.equals(id))).go();
  Future<Wallet> getWalletById(int id) =>
      (select(wallets)..where((t) => t.id.equals(id))).getSingle();
  Future<Wallet> getWalletByAccount(int id) =>
      (select(wallets)..where((t) => t.account.equals(id))).getSingle();

  Future<int> insertBalance(BalancesCompanion balance) =>
      into(balances).insert(balance);
  Future<bool> updateBalance(BalancesCompanion balance) =>
      update(balances).replace(balance);
  Future<int> deleteBalance(int id) =>
      (delete(balances)..where((t) => t.id.equals(id))).go();
  Future<Balance> getBalanceById(int id) =>
      (select(balances)..where((t) => t.id.equals(id))).getSingle();
  Future<Balance> getBalanceByAccount(int id) =>
      (select(balances)..where((t) => t.account.equals(id))).getSingle();

  Future<int> insertFilePath(FilePathsCompanion filePath) =>
      into(filePaths).insert(filePath);
  Future<bool> updateFilePath(FilePathsCompanion filePath) =>
      update(filePaths).replace(filePath);
  Future<int> deleteFilePath(int id) =>
      (delete(filePaths)..where((t) => t.id.equals(id))).go();
  Future<int> deletePath(String path) =>
      (delete(filePaths)..where((t) => t.path.equals(path))).go();
  Future<FilePath> getFilePathById(int id) =>
      (select(filePaths)..where((t) => t.id.equals(id))).getSingle();

  Future<List<DoubleEntry>> getDoubleEntries(
      {required DateTime startDate,
      required DateTime endDate,
      required int profileId}) async {
    // Define aliases for accounts table to handle 'dr' and 'cr'
    final drAccounts = alias(accounts, 'drAccounts');
    final crAccounts = alias(accounts, 'crAccounts');

    // Query to fetch transactions and their related accounts
    final query = select(transactions).join([
      leftOuterJoin(drAccounts, drAccounts.id.equalsExp(transactions.dr)),
      leftOuterJoin(crAccounts, crAccounts.id.equalsExp(transactions.cr)),
    ])
      ..where(
        transactions.vchDate.isBetweenValues(startDate, endDate) &
            transactions.profile.equals(profileId),
      )
      ..orderBy([OrderingTerm.desc(transactions.vchDate)]);

    // Get transaction results
    final transactionResults = await query.get();

    // Extract transaction IDs to fetch related file paths
    final transactionIds = transactionResults.map((row) {
      final transaction = row.readTable(transactions);
      return transaction.id;
    }).toList();

    // Query to fetch all file paths related to the transaction IDs
    final filePathResults = await (select(filePaths)
          ..where((filePath) => filePath.transaction.isIn(transactionIds)))
        .get();

    // Map transaction ID to its related file paths
    final filePathMap = <int, List<FilePath>>{};
    for (final filePath in filePathResults) {
      filePathMap.putIfAbsent(filePath.transaction, () => []).add(filePath);
    }

    // Map the results to the DoubleEntry model
    return transactionResults.map((row) {
      final transaction = row.readTable(transactions);
      final drAccount = row.readTable(drAccounts);
      final crAccount = row.readTable(crAccounts);

      return DoubleEntry(
        transaction: transaction,
        drAccount: drAccount,
        crAccount: crAccount,
        filePaths: filePathMap[transaction.id] ?? [],
      );
    }).toList();
  }

  Future<DoubleEntry> getDoubleEntryById(int transactionId) async {
    // Define aliases for accounts table to handle 'dr' and 'cr'
    final drAccounts = alias(accounts, 'drAccounts');
    final crAccounts = alias(accounts, 'crAccounts');

    // Query to fetch the transaction and its related accounts
    final query = select(transactions).join([
      leftOuterJoin(drAccounts, drAccounts.id.equalsExp(transactions.dr)),
      leftOuterJoin(crAccounts, crAccounts.id.equalsExp(transactions.cr)),
    ])
      ..where(transactions.id.equals(transactionId));

    // Get the transaction result
    final row = await query.getSingle();

    // Query to fetch all file paths related to the transaction ID
    final filePathResults = await (select(filePaths)
          ..where((filePath) => filePath.transaction.equals(transactionId)))
        .get();

    // Map the result to the DoubleEntry model
    final transaction = row.readTable(transactions);
    final drAccount = row.readTable(drAccounts);
    final crAccount = row.readTable(crAccounts);

    return DoubleEntry(
      transaction: transaction,
      drAccount: drAccount,
      crAccount: crAccount,
      filePaths: filePathResults,
    );
  }

  Future<List<DoubleEntry>> getNDoubleEntries(int n, int profileId) async {
    // Define aliases for accounts table to handle 'dr' and 'cr'
    final drAccounts = alias(accounts, 'drAccounts');
    final crAccounts = alias(accounts, 'crAccounts');

    // Query to fetch transactions and their related accounts
    final query = select(transactions).join([
      leftOuterJoin(drAccounts, drAccounts.id.equalsExp(transactions.dr)),
      leftOuterJoin(crAccounts, crAccounts.id.equalsExp(transactions.cr)),
    ])
      ..where(
        transactions.profile.equals(profileId),
      )
      ..orderBy([OrderingTerm.desc(transactions.vchDate)])
      ..limit(n);

    // Get transaction results
    final transactionResults = await query.get();

    // Extract transaction IDs to fetch related file paths
    final transactionIds = transactionResults.map((row) {
      final transaction = row.readTable(transactions);
      return transaction.id;
    }).toList();

    // Query to fetch all file paths related to the transaction IDs
    final filePathResults = await (select(filePaths)
          ..where((filePath) => filePath.transaction.isIn(transactionIds)))
        .get();

    // Map transaction ID to its related file paths
    final filePathMap = <int, List<FilePath>>{};
    for (final filePath in filePathResults) {
      filePathMap.putIfAbsent(filePath.transaction, () => []).add(filePath);
    }

    // Map the results to the DoubleEntry model
    return transactionResults.map((row) {
      final transaction = row.readTable(transactions);
      final drAccount = row.readTable(drAccounts);
      final crAccount = row.readTable(crAccounts);

      return DoubleEntry(
        transaction: transaction,
        drAccount: drAccount,
        crAccount: crAccount,
        filePaths: filePathMap[transaction.id] ?? [],
      );
    }).toList();
  }

  Future<List<DoubleEntry>> getDoubleEntriesbyAccount(
      {required DateTime startDate,
      required DateTime endDate,
      required int profileId,
      required int accountId,
      reversed = true}) async {
    // Define aliases for accounts table to handle 'dr' and 'cr'
    final drAccounts = alias(accounts, 'drAccounts');
    final crAccounts = alias(accounts, 'crAccounts');

    // Query to fetch transactions and their related accounts
    final query = select(transactions).join([
      leftOuterJoin(drAccounts, drAccounts.id.equalsExp(transactions.dr)),
      leftOuterJoin(crAccounts, crAccounts.id.equalsExp(transactions.cr)),
    ])
      ..where(transactions.vchDate.isBetweenValues(startDate, endDate) &
          transactions.profile.equals(profileId) &
          (transactions.dr.equals(accountId) |
              transactions.cr.equals(accountId)))
      ..orderBy([
        reversed
            ? OrderingTerm.desc(transactions.vchDate)
            : OrderingTerm.asc(transactions.vchDate)
      ]);

    // Get transaction results
    final transactionResults = await query.get();

    // Extract transaction IDs to fetch related file paths
    final transactionIds = transactionResults.map((row) {
      final transaction = row.readTable(transactions);
      return transaction.id;
    }).toList();

    // Query to fetch all file paths related to the transaction IDs
    final filePathResults = await (select(filePaths)
          ..where((filePath) => filePath.transaction.isIn(transactionIds)))
        .get();

    // Map transaction ID to its related file paths
    final filePathMap = <int, List<FilePath>>{};
    for (final filePath in filePathResults) {
      filePathMap.putIfAbsent(filePath.transaction, () => []).add(filePath);
    }

    // Map the results to the DoubleEntry model
    return transactionResults.map((row) {
      final transaction = row.readTable(transactions);
      final drAccount = row.readTable(drAccounts);
      final crAccount = row.readTable(crAccounts);

      return DoubleEntry(
        transaction: transaction,
        drAccount: drAccount,
        crAccount: crAccount,
        filePaths: filePathMap[transaction.id] ?? [],
      );
    }).toList();
  }

  Future<List<Ledger>> getLedgers({required int profileId}) async {
    final query = select(accounts).join([
      innerJoin(accTypes, accTypes.id.equalsExp(accounts.accType)),
      leftOuterJoin(balances, balances.account.equalsExp(accounts.id)),
    ])
      ..where(accounts.profile.equals(profileId));

    final results = await query.get();

    return results.map((row) {
      final account = row.readTable(accounts);
      final accType = row.readTable(accTypes);
      final balance = row.readTable(balances);

      return Ledger(
        account: account,
        accType: accType,
        balance: balance,
      );
    }).toList();
  }

  Future<List<Ledger>> getLedgersByAccType(
      {required int profileId, required int accTypeID}) async {
    final query = select(accounts).join([
      innerJoin(accTypes, accTypes.id.equalsExp(accounts.accType)),
      leftOuterJoin(balances, balances.account.equalsExp(accounts.id)),
    ])
      ..where(accounts.profile.equals(profileId) &
          accounts.accType.equals(accTypeID));

    final results = await query.get();

    return results.map((row) {
      final account = row.readTable(accounts);
      final accType = row.readTable(accTypes);
      final balance = row.readTable(balances);

      return Ledger(
        account: account,
        accType: accType,
        balance: balance,
      );
    }).toList();
  }

  Future<List<Ledger>> getFunds({required int profileId}) async {
    final query = select(accounts).join([
      innerJoin(accTypes, accTypes.id.equalsExp(accounts.accType)),
      leftOuterJoin(balances, balances.account.equalsExp(accounts.id)),
    ])
      ..where(
          accounts.profile.equals(profileId) & accounts.accType.isIn(fundIDs));

    final results = await query.get();

    return results.map((row) {
      final account = row.readTable(accounts);
      final accType = row.readTable(accTypes);
      final balance = row.readTable(balances);

      return Ledger(
        account: account,
        accType: accType,
        balance: balance,
      );
    }).toList();
  }

  Future<List<Ledger>> getCredits({required int profileId}) async {
    final query = select(accounts).join([
      innerJoin(accTypes, accTypes.id.equalsExp(accounts.accType)),
      leftOuterJoin(balances, balances.account.equalsExp(accounts.id)),
    ])
      ..where(accounts.profile.equals(profileId) &
          accounts.accType.isIn(creditIDs));

    final results = await query.get();

    return results.map((row) {
      final account = row.readTable(accounts);
      final accType = row.readTable(accTypes);
      final balance = row.readTable(balances);

      return Ledger(
        account: account,
        accType: accType,
        balance: balance,
      );
    }).toList();
  }

  Future<List<Ledger>> getFundingLedgers({required int profileId}) async {
    final query = select(accounts).join([
      innerJoin(accTypes, accTypes.id.equalsExp(accounts.accType)),
      leftOuterJoin(balances, balances.account.equalsExp(accounts.id)),
    ])
      ..where(accounts.profile.equals(profileId) &
          accounts.accType.isIn(fundingAccountIDs));

    final results = await query.get();

    return results.map((row) {
      final account = row.readTable(accounts);
      final accType = row.readTable(accTypes);
      final balance = row.readTable(balances);

      return Ledger(
        account: account,
        accType: accType,
        balance: balance,
      );
    }).toList();
  }

  Future<List<AccType>> getFundAccTypes() async {
    return await (select(accTypes)..where((a) => a.id.isIn(fundIDs))).get();
  }

  Future<List<AccType>> getCreditAccTypes() async {
    return await (select(accTypes)..where((a) => a.id.isIn(creditIDs))).get();
  }

  Future<List<AccType>> getFundingAccTypes() async {
    return await (select(accTypes)..where((a) => a.id.isIn(fundingAccountIDs)))
        .get();
  }

  Future<List<AccType>> getBalanceAccTypes() async {
    return await (select(accTypes)..where((a) => a.id.isNotIn(incExpIDs)))
        .get();
  }

  Future<int?> getLastTransactionID() async {
    // Query to get the maximum value of the id column
    final query = select(transactions)
      ..orderBy([(t) => OrderingTerm.desc(t.id)])
      ..limit(1);

    final result = await query.getSingleOrNull();
    return result?.id;
  }

  Future<Map<E, Account>>
      getTableWithAccounts<E extends DataClass, T extends Table>(
    TableInfo<T, E> table,
    Column<int> accountColumn,
  ) async {
    final query = select(table).join([
      innerJoin(accounts, accounts.id.equalsExp(accountColumn)),
    ]);

    final results = await query.get();

    final map = <E, Account>{};
    for (final row in results) {
      final tableEntry = row.readTable(table);
      final accountEntry = row.readTable(accounts);
      map[tableEntry] = accountEntry;
    }
    return map;
  }

  Future<Map<Bank, Account>> getBanksWithAccounts() {
    return getTableWithAccounts(banks, banks.account);
  }

  Future<Map<Wallet, Account>> getWalletsWithAccounts() {
    return getTableWithAccounts(wallets, wallets.account);
  }

  Future<Map<Loan, Account>> getLoansWithAccounts() {
    return getTableWithAccounts(loans, loans.account);
  }

  Future<Map<CCard, Account>> getCCardsWithAccounts() {
    return getTableWithAccounts(cCards, cCards.account);
  }

  Future<int> calculateBalance(int accountId) async {
    // Fetch the opening balance from the account table
    final account = await (select(accounts)
          ..where((a) => a.id.equals(accountId)))
        .getSingleOrNull();

    if (account == null) {
      throw Exception("Account not found");
    }

    final query = customSelect(
      'SELECT '
      'SUM(CASE WHEN dr = ? THEN amount ELSE 0 END) AS totalDebit, '
      'SUM(CASE WHEN cr = ? THEN amount ELSE 0 END) AS totalCredit '
      'FROM transactions',
      variables: [
        Variable.withInt(accountId),
        Variable.withInt(accountId),
      ],
      readsFrom: {transactions},
    );

    final row = await query.getSingle();
    final totalDebit = row.data['totalDebit'] as int? ?? 0;
    final totalCredit = row.data['totalCredit'] as int? ?? 0;

    final openingBalance = account.openBal;
    int closingBalance;

    // Determine account type
    final accountType = account.accType;
    // Adjust closing balance calculation based on account type
    if (DBUtils.isAssetOrExpense(accountType)) {
      // Asset and Expense accounts: Debit increases, Credit decreases
      closingBalance = openingBalance + totalDebit - totalCredit;
    } else if (DBUtils.isLiabilityOrIncome(accountType)) {
      // Liability and Income accounts: Credit increases, Debit decreases
      closingBalance = openingBalance + totalCredit - totalDebit;
    } else {
      throw Exception("Unknown account type");
    }
    return closingBalance;
  }

  Future<int> getFundClosingBalance(DateTime closingDate, int profileID) async {
    // Fetch accounts where accType < 4
    final acc = await (select(accounts)
          ..where((a) => a.accType.isIn(fundIDs) & a.profile.equals(profileID)))
        .get();

    // If no accounts match, return 0
    if (acc.isEmpty) {
      return 0;
    }

    int totalBalance = 0;

    for (var account in acc) {
      // For each account, calculate the closing balance using the previous method
      final closingBalance = await getClosingBalance(account.id, closingDate);
      totalBalance += closingBalance;
    }

    return totalBalance;
  }

  Future<int> getClosingBalance(int accountId, DateTime closingDate) async {
    // Fetch account details
    final account = await (select(accounts)
          ..where((a) => a.id.equals(accountId)))
        .getSingleOrNull();

    if (account == null) {
      throw Exception("Account not found");
    }

    // If the account was opened after the closing date, just return the opening balance.
    if (account.openDate.isAfter(closingDate)) {
      return account.openBal;
    }

    // Adjust closing date to cover the entire day
    final closingDateLimit =
        closingDate.copyWith(hour: 23, minute: 59, second: 59);

    // Use a single SQL query to sum both debit and credit transactions
    final query = customSelect(
      'SELECT '
      'SUM(CASE WHEN dr = ? THEN amount ELSE 0 END) AS totalDebit, '
      'SUM(CASE WHEN cr = ? THEN amount ELSE 0 END) AS totalCredit '
      'FROM transactions '
      'WHERE vch_date <= ?',
      variables: [
        Variable.withInt(accountId),
        Variable.withInt(accountId),
        Variable.withDateTime(closingDateLimit),
      ],
      readsFrom: {transactions},
    );

    final row = await query.getSingle();
    final totalDebit = row.data['totalDebit'] as int? ?? 0;
    final totalCredit = row.data['totalCredit'] as int? ?? 0;

    final openingBalance = account.openBal;
    int closingBalance;

    // Determine account type
    final accountType = account.accType;
    // Adjust closing balance calculation based on account type
    if (DBUtils.isAssetOrExpense(accountType)) {
      // Asset and Expense accounts: Debit increases, Credit decreases
      closingBalance = openingBalance + totalDebit - totalCredit;
    } else if (DBUtils.isLiabilityOrIncome(accountType)) {
      // Liability and Income accounts: Credit increases, Debit decreases
      closingBalance = openingBalance + totalCredit - totalDebit;
    } else {
      throw Exception("Unknown account type");
    }
    return closingBalance;
  }

  Future<List<Transaction>> getLastNTransactions(int n) async {
    return await (select(transactions)
          ..orderBy(
              [(t) => OrderingTerm.desc(t.vchDate)]) // Order by latest date
          ..limit(n)) // Get last 8 entries
        .get();
  }

  Future<List<Budget>> getBudgets() async {
    return await select(budgets).get();
  }

  Future<Budget> getBudgetbyId(int id) async {
    return await (select(budgets)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<List<Budget>> getBudgetsByProfile(int id) async {
    return await (select(budgets)
          ..where((tbl) => tbl.profile.equals(id))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<bool> updateBudget(BudgetsCompanion companion) async {
    return await update(budgets).replace(companion);
  }

  Future<int> insertBudget(BudgetsCompanion companion) async {
    return await into(budgets).insert(companion);
  }

  Future<int> deleteBudget(int id) async {
    return await (delete(budgets)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<BudgetFund>> getBudgetFunds() async {
    return await select(budgetFunds).get();
  }

  Future<BudgetFund> getBudgetFundbyId(int id) async {
    return await (select(budgetFunds)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<List<BudgetFund>> getBudgetFundsByBudget(int id) async {
    return await (select(budgetFunds)
          ..where((tbl) => tbl.budget.equals(id))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.budget)]))
        .get();
  }

  Future<bool> updateBudgetFund(BudgetFundsCompanion companion) async {
    return await update(budgetFunds).replace(companion);
  }

  Future<int> insertBudgetFund(BudgetFundsCompanion companion) async {
    return await into(budgetFunds).insert(companion);
  }

  Future<int> deleteBudgetFund(int id) async {
    return await (delete(budgetFunds)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<int> deleteBudgetFundByBudget(int id) async {
    return await (delete(budgetFunds)..where((tbl) => tbl.budget.equals(id)))
        .go();
  }

  Future<List<BudgetAccount>> getBudgetAccounts() async {
    return await select(budgetAccounts).get();
  }

  Future<BudgetAccount> getBudgetAccountbyId(int id) async {
    return await (select(budgetAccounts)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<List<BudgetAccount>> getBudgetAccountsByBudget(int id) async {
    return await (select(budgetAccounts)
          ..where((tbl) => tbl.budget.equals(id))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.budget)]))
        .get();
  }

  Future<bool> updateBudgetAccount(BudgetAccountsCompanion companion) async {
    return await update(budgetAccounts).replace(companion);
  }

  Future<int> insertBudgetAccount(BudgetAccountsCompanion companion) async {
    return await into(budgetAccounts).insert(companion);
  }

  Future<int> deleteBudgetAccount(int id) async {
    return await (delete(budgetAccounts)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<int> deleteBudgetAccountByBudget(int id) async {
    return await (delete(budgetAccounts)..where((tbl) => tbl.budget.equals(id)))
        .go();
  }

  Future<Map<Account, int>> getAccountBalances(
      DateTime startDate, DateTime endDate) async {
    // Fetch all transactions within the date range
    final trx = await (select(transactions)
          ..where((t) => t.vchDate.isBiggerOrEqualValue(startDate))
          ..where((t) => t.vchDate.isSmallerOrEqualValue(endDate)))
        .get();

    // Map to store account balances
    final Map<int, int> accountBalances = {};

    for (var txn in trx) {
      // Add to dr account balance
      accountBalances[txn.dr] = (accountBalances[txn.dr] ?? 0) + txn.amount;
      // Subtract from cr account balance
      accountBalances[txn.cr] = (accountBalances[txn.cr] ?? 0) - txn.amount;
    }

    // Fetch account details for all involved accounts
    final accx = await (select(accounts)
          ..where((a) => a.id.isIn(accountBalances.keys.toList())))
        .get();

    // Convert to Map<Account, int>
    return {for (var acc in accx) acc: accountBalances[acc.id] ?? 0};
  }

  Future<List<BudgetPlan>> getAllBudgetPlans(int profileID) async {
    final budgetList = await (select(budgets)
          ..where((b) => b.profile.equals(profileID)))
        .get(); // Get all budgets
    List<BudgetPlan> plans = [];

    for (var budget in budgetList) {
      final funds = await (select(accounts)
            ..where((a) => a.id.isInQuery(selectOnly(budgetFunds)
              ..addColumns([budgetFunds.account])
              ..where(budgetFunds.budget.equals(budget.id)))))
          .get();

      final budgetAccountsList = await (select(budgetAccounts)
            ..where((ba) => ba.budget.equals(budget.id)))
          .get();

      Map<Account, int> incomes = {};
      Map<Account, int> expenses = {};

      for (var ba in budgetAccountsList) {
        final account = await (select(accounts)
              ..where((a) => a.id.equals(ba.account)))
            .getSingleOrNull();
        if (account != null) {
          if (ba.amount > 0) {
            incomes[account] = ba.amount;
          } else {
            expenses[account] = ba.amount;
          }
        }
      }

      plans.add(BudgetPlan(
        incomes,
        expenses,
        budget: budget,
        funds: funds,
      ));
    }

    return plans;
  }
}

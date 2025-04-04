import 'dart:io';
import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:pursenal/app/global/values.dart';
import 'package:pursenal/core/enums/budget_interval.dart';
import 'package:pursenal/core/enums/currency.dart';
import 'package:pursenal/core/enums/primary_type.dart';
import 'package:pursenal/core/enums/project_status.dart';
import 'package:pursenal/core/enums/voucher_type.dart';
import 'package:pursenal/core/models/drift/models.dart';
import 'package:pursenal/utils/app_logger.dart';
import 'package:pursenal/utils/db_utils.dart';
import 'package:tuple/tuple.dart';
import 'package:uuid/uuid.dart';

part 'database.g.dart';

@DriftDatabase(tables: [
  DriftAccTypes,
  DriftAccounts,
  DriftTransactions,
  DriftUsers,
  DriftBanks,
  DriftWallets,
  DriftLoans,
  DriftCCards,
  DriftBalances,
  DriftTransactionPhotos,
  DriftProfiles,
  DriftBudgets,
  DriftBudgetAccounts,
  DriftBudgetFunds,
  DriftProjects,
  DriftProjectPhotos,
  DriftSubscriptions,
  DriftReceivables,
  DriftPeople
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
      await insertAccType(const DriftAccTypesCompanion(
          id: Value(walletTypeID),
          name: Value("Wallets"),
          primary: Value(PrimaryType.asset)));
      await insertAccType(const DriftAccTypesCompanion(
          id: Value(bankTypeID),
          name: Value("Banks"),
          primary: Value(PrimaryType.asset)));
      await insertAccType(const DriftAccTypesCompanion(
          id: Value(cCardTypeID),
          name: Value("Credit Cards"),
          primary: Value(PrimaryType.liability)));
      await insertAccType(const DriftAccTypesCompanion(
          id: Value(loanTypeID),
          name: Value("Loans"),
          primary: Value(PrimaryType.liability)));
      await insertAccType(const DriftAccTypesCompanion(
          id: Value(incomeTypeID),
          name: Value("Incomes"),
          primary: Value(PrimaryType.income)));
      await insertAccType(const DriftAccTypesCompanion(
          id: Value(expenseTypeID),
          name: Value("Expenses"),
          primary: Value(PrimaryType.expense)));
      await insertAccType(const DriftAccTypesCompanion(
          id: Value(advanceTypeID),
          name: Value("Receivables"),
          primary: Value(PrimaryType.asset)));
      await insertAccType(const DriftAccTypesCompanion(
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
    await (delete(driftTransactions)).go();
    await (delete(driftAccounts)).go();
    await (delete(driftAccTypes)).go();
  }

  Future<List<DriftAccType>> getAccTypes() async {
    return await select(driftAccTypes).get();
  }

  Future<DriftAccType> getAccTypeById(int id) async {
    return await (select(driftAccTypes)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<DriftAccType> getAccTypeByType(int type) async {
    return await (select(driftAccTypes)
          ..where((tbl) => tbl.primary.equals(type)))
        .getSingle();
  }

  // Future<bool> updateAccType(DriftAccTypesCompanion companion) async {
  //   return await update(driftAccTypes).replace(companion);
  // }

  Future<int> insertAccType(DriftAccTypesCompanion companion) async {
    return await into(driftAccTypes).insert(companion);
  }

  // Future<int> deleteAccType(int id) async {
  //   return await (delete(driftAccTypes)..where((tbl) => tbl.id.equals(id))).go();
  // }

  Future<DriftAccount> getAccountbyId(int id) async {
    return await (select(driftAccounts)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<void> insertAccounts(List<DriftAccountsCompanion> accountsList) async {
    await transaction(() async {
      final insertedIds = <int>[];

      for (final account in accountsList) {
        // Check if the account already exists for the profile
        final existingAccount = await (select(driftAccounts)
              ..where((a) => a.name.equals(account.name.value))
              ..where((a) => a.profile.equals(account.profile.value)))
            .getSingleOrNull();

        if (existingAccount == null) {
          // Insert if no duplicate exists
          final id = await into(driftAccounts).insert(account);
          insertedIds.add(id);
        }
      }

      // Insert driftBalances for newly added driftAccounts
      if (insertedIds.isNotEmpty) {
        final balancesList = insertedIds.map((accountId) {
          return DriftBalancesCompanion(
            account: Value(accountId),
            amount: const Value(0),
          );
        }).toList();

        await batch((batch) {
          batch.insertAll(driftBalances, balancesList);
        });
      }
    });
  }

  Future<List<DriftAccount>> getAccountsByProfile(int id) async {
    return await (select(driftAccounts)
          ..where((tbl) => tbl.profile.equals(id))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<List<DriftAccount>> getAccountsByAccType(int id, int accType) async {
    return await (select(driftAccounts)
          ..where((tbl) => tbl.profile.equals(id) & tbl.accType.equals(accType))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<List<DriftAccount>> getFundingAccounts(int profile) async {
    return await (select(driftAccounts)
          ..where((tbl) =>
              tbl.profile.equals(profile) & tbl.accType.isIn(fundingAccountIDs))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<List<DriftAccount>> getAccountsByCategory(
      {required int profileID, required List<int> accTypeIDs}) async {
    return await (select(driftAccounts)
          ..where((tbl) =>
              tbl.profile.equals(profileID) & tbl.accType.isIn(accTypeIDs))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<List<DriftAccount>> getFundAccounts(int profile) async {
    return await (select(driftAccounts)
          ..where(
              (tbl) => tbl.profile.equals(profile) & tbl.accType.isIn(fundIDs))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<List<DriftAccount>> getCreditAccounts(int profile) async {
    return await (select(driftAccounts)
          ..where((tbl) =>
              tbl.profile.equals(profile) & tbl.accType.isIn(creditIDs))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<bool> updateAccount(DriftAccountsCompanion companion) async {
    return await update(driftAccounts).replace(companion);
  }

  Future<int> insertAccount(DriftAccountsCompanion companion) async {
    return await into(driftAccounts).insert(companion);
  }

  Future<int> deleteAccount(int id) async {
    return await (delete(driftAccounts)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  // Future<DriftTransaction> getTransactionById(int id) async {
  //   return await (select(driftTransactions)..where((tbl) => tbl.id.equals(id)))
  //       .getSingle();
  // }

  Future<bool> updateTransaction(DriftTransactionsCompanion companion) async {
    return await update(driftTransactions).replace(companion);
  }

  Future<int> insertTransaction(DriftTransactionsCompanion companion) async {
    return await into(driftTransactions).insert(companion);
  }

  Future<int> deleteTransaction(int id) async {
    final fps = await (select(driftTransactionPhotos)
          ..where((tbl) => tbl.transaction.equals(id)))
        .get();

    // Delete files from DriftTransactionPhotos before deleting the transaction
    for (final filePath in fps) {
      try {
        final file = File(filePath.path);
        if (await file.exists()) {
          await file.delete();
        }
      } catch (e) {
        AppLogger.instance.error("Cannot delete transaction image");
      }
    }

    return await (delete(driftTransactions)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<int> deleteTransactionsByProject(int id) async {
    return await (delete(driftTransactions)
          ..where((tbl) => tbl.project.equals(id)))
        .go();
  }

  Future<List<DriftTransaction>> getTransactionsByProfile(int id) async {
    return await (select(driftTransactions)
          ..where((tbl) => tbl.profile.equals(id)))
        .get();
  }

  Future<List<DriftProfile>> getProfiles() async => select(driftProfiles).get();

  Future<int> insertProfile(DriftProfilesCompanion business) =>
      into(driftProfiles).insert(business);

  Future<bool> updateProfile(DriftProfilesCompanion business) =>
      update(driftProfiles).replace(business);

  Future<int> deleteProfile(int id) =>
      (delete(driftProfiles)..where((tbl) => tbl.id.equals(id))).go();

  Future<DriftProfile> getProfileById(int id) =>
      (select(driftProfiles)..where((tbl) => tbl.id.equals(id))).getSingle();

  Future<DriftProfile?> getSelectedProfile() async {
    final selectedProfile = await (select(driftProfiles)
          ..where((tbl) => tbl.isSelected.equals(true)))
        .getSingleOrNull();
    if (selectedProfile != null) {
      return selectedProfile;
    }
    final firstProfile =
        await (select(driftProfiles)..limit(1)).getSingleOrNull();
    return firstProfile;
  }

  Future<void> setSelectedProfile(int id) async {
    await (update(driftProfiles)..where((tbl) => tbl.isSelected.equals(true)))
        .write(const DriftProfilesCompanion(isSelected: Value(false)));
    await (update(driftProfiles)..where((tbl) => tbl.id.equals(id)))
        .write(const DriftProfilesCompanion(isSelected: Value(true)));
  }

  Future<int> insertBank(DriftBanksCompanion bank) =>
      into(driftBanks).insert(bank);
  Future<bool> updateBank(DriftBanksCompanion bank) =>
      update(driftBanks).replace(bank);
  Future<int> deleteBank(int id) =>
      (delete(driftBanks)..where((t) => t.id.equals(id))).go();
  Future<DriftBank> getBankById(int id) =>
      (select(driftBanks)..where((t) => t.id.equals(id))).getSingle();

  Future<DriftBank> getBankByAccount(int id) =>
      (select(driftBanks)..where((t) => t.account.equals(id))).getSingle();

  Future<int> insertCCard(DriftCCardsCompanion card) =>
      into(driftCCards).insert(card);
  Future<bool> updateCCard(DriftCCardsCompanion card) =>
      update(driftCCards).replace(card);
  Future<int> deleteCCard(int id) =>
      (delete(driftCCards)..where((t) => t.id.equals(id))).go();
  Future<DriftCCard> getCCardById(int id) =>
      (select(driftCCards)..where((t) => t.id.equals(id))).getSingle();
  Future<DriftCCard> getCCardByAccount(int id) =>
      (select(driftCCards)..where((t) => t.account.equals(id))).getSingle();

  Future<int> insertLoan(DriftLoansCompanion loan) =>
      into(driftLoans).insert(loan);
  Future<bool> updateLoan(DriftLoansCompanion loan) =>
      update(driftLoans).replace(loan);
  Future<int> deleteLoan(int id) =>
      (delete(driftLoans)..where((t) => t.id.equals(id))).go();
  Future<DriftLoan> getLoanById(int id) =>
      (select(driftLoans)..where((t) => t.id.equals(id))).getSingle();
  Future<DriftLoan> getLoanByAccount(int id) =>
      (select(driftLoans)..where((t) => t.account.equals(id))).getSingle();

  Future<int> insertWallet(DriftWalletsCompanion wallet) =>
      into(driftWallets).insert(wallet);
  Future<bool> updateWallet(DriftWalletsCompanion wallet) =>
      update(driftWallets).replace(wallet);
  Future<int> deleteWallet(int id) =>
      (delete(driftWallets)..where((t) => t.id.equals(id))).go();
  Future<DriftWallet> getWalletById(int id) =>
      (select(driftWallets)..where((t) => t.id.equals(id))).getSingle();
  Future<DriftWallet> getWalletByAccount(int id) =>
      (select(driftWallets)..where((t) => t.account.equals(id))).getSingle();

  Future<int> insertBalance(DriftBalancesCompanion balance) =>
      into(driftBalances).insert(balance);
  Future<bool> updateBalance(DriftBalancesCompanion balance) =>
      update(driftBalances).replace(balance);
  Future<int> deleteBalance(int id) =>
      (delete(driftBalances)..where((t) => t.id.equals(id))).go();
  Future<DriftBalance> getBalanceById(int id) =>
      (select(driftBalances)..where((t) => t.id.equals(id))).getSingle();
  Future<DriftBalance> getBalanceByAccount(int id) =>
      (select(driftBalances)..where((t) => t.account.equals(id))).getSingle();

  Future<int> insertDriftTransactionPhoto(
          DriftTransactionPhotosCompanion filePath) =>
      into(driftTransactionPhotos).insert(filePath);
  Future<bool> updateDriftTransactionPhoto(
          DriftTransactionPhotosCompanion filePath) =>
      update(driftTransactionPhotos).replace(filePath);
  Future<int> deleteDriftTransactionPhoto(int id) =>
      (delete(driftTransactionPhotos)..where((t) => t.id.equals(id))).go();
  Future<int> deletePath(String path) =>
      (delete(driftTransactionPhotos)..where((t) => t.path.equals(path))).go();
  Future<DriftTransactionPhoto> getDriftTransactionPhotoById(int id) =>
      (select(driftTransactionPhotos)..where((t) => t.id.equals(id)))
          .getSingle();

  Future<
      List<
          Tuple5<DriftTransaction, DriftAccount, DriftAccount,
              List<DriftTransactionPhoto>, DriftProject?>>> getTransactions(
      {required DateTime startDate,
      required DateTime endDate,
      required int profileId}) async {
    // Define aliases for driftAccounts table to handle 'dr' and 'cr'
    final drAccounts = alias(driftAccounts, 'drAccounts');
    final crAccounts = alias(driftAccounts, 'crAccounts');

    // Query to fetch driftTransactions and their related driftAccounts
    final query = select(driftTransactions).join([
      leftOuterJoin(drAccounts, drAccounts.id.equalsExp(driftTransactions.dr)),
      leftOuterJoin(crAccounts, crAccounts.id.equalsExp(driftTransactions.cr)),
    ])
      ..where(
        driftTransactions.vchDate.isBetweenValues(startDate, endDate) &
            driftTransactions.profile.equals(profileId),
      )
      ..orderBy([OrderingTerm.desc(driftTransactions.vchDate)]);

    // Get transaction results
    final transactionResults = await query.get();

    // Extract transaction IDs to fetch related file paths
    final transactionIds = transactionResults.map((row) {
      final transaction = row.readTable(driftTransactions);
      return transaction.id;
    }).toList();

    // Query to fetch all file paths related to the transaction IDs
    final filePathResults = await (select(driftTransactionPhotos)
          ..where((filePath) => filePath.transaction.isIn(transactionIds)))
        .get();

    // Map transaction ID to its related file paths
    final filePathMap = <int, List<DriftTransactionPhoto>>{};
    for (final filePath in filePathResults) {
      filePathMap.putIfAbsent(filePath.transaction, () => []).add(filePath);
    }
    final allProjects = await getProjectsByProfile(profileId);
    // Map the results to the DoubleEntry model
    return transactionResults.map((row) {
      final transaction = row.readTable(driftTransactions);
      final drAccount = row.readTable(drAccounts);
      final crAccount = row.readTable(crAccounts);

      return Tuple5(
          transaction,
          drAccount,
          crAccount,
          filePathMap[transaction.id] ?? [],
          allProjects.firstWhereOrNull((p) => p.id == transaction.project));
    }).toList();
  }

  Future<
      Tuple5<
          DriftTransaction,
          DriftAccount,
          DriftAccount,
          List<DriftTransactionPhoto>,
          DriftProject?>> getTransactionById(int transactionId) async {
    // Define aliases for driftAccounts table to handle 'dr' and 'cr'
    final drAccounts = alias(driftAccounts, 'drAccounts');
    final crAccounts = alias(driftAccounts, 'crAccounts');

    // Query to fetch the transaction and its related driftAccounts
    final query = select(driftTransactions).join([
      leftOuterJoin(drAccounts, drAccounts.id.equalsExp(driftTransactions.dr)),
      leftOuterJoin(crAccounts, crAccounts.id.equalsExp(driftTransactions.cr)),
    ])
      ..where(driftTransactions.id.equals(transactionId));

    // Get the transaction result
    final row = await query.getSingle();

    // Query to fetch all file paths related to the transaction ID
    final filePathResults = await (select(driftTransactionPhotos)
          ..where((filePath) => filePath.transaction.equals(transactionId)))
        .get();

    // Map the result to the DoubleEntry model
    final transaction = row.readTable(driftTransactions);
    final drAccount = row.readTable(drAccounts);
    final crAccount = row.readTable(crAccounts);
    final project = transaction.project != null
        ? await (select(driftProjects)
              ..where((tbl) => tbl.id.equals(transaction.project!)))
            .getSingleOrNull()
        : null;

    return Tuple5(transaction, drAccount, crAccount, filePathResults, project);
  }

  Future<
      List<
          Tuple5<
              DriftTransaction,
              DriftAccount,
              DriftAccount,
              List<DriftTransactionPhoto>,
              DriftProject?>>> getNTransactions(int n, int profileId) async {
    // Define aliases for driftAccounts table to handle 'dr' and 'cr'
    final drAccounts = alias(driftAccounts, 'drAccounts');
    final crAccounts = alias(driftAccounts, 'crAccounts');

    // Query to fetch driftTransactions and their related driftAccounts
    final query = select(driftTransactions).join([
      leftOuterJoin(drAccounts, drAccounts.id.equalsExp(driftTransactions.dr)),
      leftOuterJoin(crAccounts, crAccounts.id.equalsExp(driftTransactions.cr)),
    ])
      ..where(
        driftTransactions.profile.equals(profileId),
      )
      ..orderBy([OrderingTerm.desc(driftTransactions.vchDate)])
      ..limit(n);

    // Get transaction results
    final transactionResults = await query.get();

    // Extract transaction IDs to fetch related file paths
    final transactionIds = transactionResults.map((row) {
      final transaction = row.readTable(driftTransactions);
      return transaction.id;
    }).toList();

    // Query to fetch all file paths related to the transaction IDs
    final filePathResults = await (select(driftTransactionPhotos)
          ..where((filePath) => filePath.transaction.isIn(transactionIds)))
        .get();

    // Map transaction ID to its related file paths
    final filePathMap = <int, List<DriftTransactionPhoto>>{};
    for (final filePath in filePathResults) {
      filePathMap.putIfAbsent(filePath.transaction, () => []).add(filePath);
    }
    final allProjects = await getProjectsByProfile(profileId);
    // Map the results to the DoubleEntry model
    return transactionResults.map((row) {
      final transaction = row.readTable(driftTransactions);
      final drAccount = row.readTable(drAccounts);
      final crAccount = row.readTable(crAccounts);

      return Tuple5(
          transaction,
          drAccount,
          crAccount,
          filePathMap[transaction.id] ?? [],
          allProjects.firstWhereOrNull((p) => p.id == transaction.project));
    }).toList();
  }

  Future<
      List<
          Tuple5<
              DriftTransaction,
              DriftAccount,
              DriftAccount,
              List<DriftTransactionPhoto>,
              DriftProject?>>> getTransactionsbyAccount(
      {required DateTime startDate,
      required DateTime endDate,
      required int profileId,
      required int accountId,
      reversed = true}) async {
    // Define aliases for driftAccounts table to handle 'dr' and 'cr'
    final drAccounts = alias(driftAccounts, 'drAccounts');
    final crAccounts = alias(driftAccounts, 'crAccounts');

    // Query to fetch driftTransactions and their related driftAccounts
    final query = select(driftTransactions).join([
      leftOuterJoin(drAccounts, drAccounts.id.equalsExp(driftTransactions.dr)),
      leftOuterJoin(crAccounts, crAccounts.id.equalsExp(driftTransactions.cr)),
    ])
      ..where(driftTransactions.vchDate.isBetweenValues(startDate, endDate) &
          driftTransactions.profile.equals(profileId) &
          (driftTransactions.dr.equals(accountId) |
              driftTransactions.cr.equals(accountId)))
      ..orderBy([
        reversed
            ? OrderingTerm.desc(driftTransactions.vchDate)
            : OrderingTerm.asc(driftTransactions.vchDate)
      ]);

    // Get transaction results
    final transactionResults = await query.get();

    // Extract transaction IDs to fetch related file paths
    final transactionIds = transactionResults.map((row) {
      final transaction = row.readTable(driftTransactions);
      return transaction.id;
    }).toList();

    // Query to fetch all file paths related to the transaction IDs
    final filePathResults = await (select(driftTransactionPhotos)
          ..where((filePath) => filePath.transaction.isIn(transactionIds)))
        .get();

    // Map transaction ID to its related file paths
    final filePathMap = <int, List<DriftTransactionPhoto>>{};
    for (final filePath in filePathResults) {
      filePathMap.putIfAbsent(filePath.transaction, () => []).add(filePath);
    }
    final allProjects = await getProjectsByProfile(profileId);
    // Map the results to the DoubleEntry model
    return transactionResults.map((row) {
      final transaction = row.readTable(driftTransactions);
      final drAccount = row.readTable(drAccounts);
      final crAccount = row.readTable(crAccounts);

      return Tuple5(
          transaction,
          drAccount,
          crAccount,
          filePathMap[transaction.id] ?? [],
          allProjects.firstWhereOrNull((p) => p.id == transaction.project));
    }).toList();
  }

  Future<List<Tuple3<DriftAccount, DriftAccType, DriftBalance>>> getLedgers(
      {required int profileId}) async {
    final query = select(driftAccounts).join([
      innerJoin(
          driftAccTypes, driftAccTypes.id.equalsExp(driftAccounts.accType)),
      leftOuterJoin(
          driftBalances, driftBalances.account.equalsExp(driftAccounts.id)),
    ])
      ..where(driftAccounts.profile.equals(profileId));

    final results = await query.get();

    return results.map((row) {
      final account = row.readTable(driftAccounts);
      final accType = row.readTable(driftAccTypes);
      final balance = row.readTable(driftBalances);

      return Tuple3(
        account,
        accType,
        balance,
      );
    }).toList();
  }

  Future<List<Tuple3<DriftAccount, DriftAccType, DriftBalance>>>
      getLedgersByAccType(
          {required int profileId, required int accTypeID}) async {
    final query = select(driftAccounts).join([
      innerJoin(
          driftAccTypes, driftAccTypes.id.equalsExp(driftAccounts.accType)),
      leftOuterJoin(
          driftBalances, driftBalances.account.equalsExp(driftAccounts.id)),
    ])
      ..where(driftAccounts.profile.equals(profileId) &
          driftAccounts.accType.equals(accTypeID));

    final results = await query.get();

    return results.map((row) {
      final account = row.readTable(driftAccounts);
      final accType = row.readTable(driftAccTypes);
      final balance = row.readTable(driftBalances);

      return Tuple3(
        account,
        accType,
        balance,
      );
    }).toList();
  }

  Future<List<Tuple3<DriftAccount, DriftAccType, DriftBalance>>>
      getLedgersByCategory(
          {required int profileId, required List<int> accTypeIDs}) async {
    final query = select(driftAccounts).join([
      innerJoin(
          driftAccTypes, driftAccTypes.id.equalsExp(driftAccounts.accType)),
      leftOuterJoin(
          driftBalances, driftBalances.account.equalsExp(driftAccounts.id)),
    ])
      ..where(driftAccounts.profile.equals(profileId) &
          driftAccounts.accType.isIn(accTypeIDs));

    final results = await query.get();

    return results.map((row) {
      final account = row.readTable(driftAccounts);
      final accType = row.readTable(driftAccTypes);
      final balance = row.readTable(driftBalances);

      return Tuple3(
        account,
        accType,
        balance,
      );
    }).toList();
  }

  // Future<List<Ledger>> getCredits({required int profileId}) async {
  //   final query = select(driftAccounts).join([
  //     innerJoin(
  //         driftAccTypes, driftAccTypes.id.equalsExp(driftAccounts.accType)),
  //     leftOuterJoin(
  //         driftBalances, driftBalances.account.equalsExp(driftAccounts.id)),
  //   ])
  //     ..where(driftAccounts.profile.equals(profileId) &
  //         driftAccounts.accType.isIn(creditIDs));

  //   final results = await query.get();

  //   return results.map((row) {
  //     final account = row.readTable(driftAccounts);
  //     final accType = row.readTable(driftAccTypes);
  //     final balance = row.readTable(driftBalances);

  //     return Ledger(
  //       account: account,
  //       accType: accType,
  //       balance: balance,
  //     );
  //   }).toList();
  // }

  // Future<List<Ledger>> getFundingLedgers({required int profileId}) async {
  //   final query = select(driftAccounts).join([
  //     innerJoin(
  //         driftAccTypes, driftAccTypes.id.equalsExp(driftAccounts.accType)),
  //     leftOuterJoin(
  //         driftBalances, driftBalances.account.equalsExp(driftAccounts.id)),
  //   ])
  //     ..where(driftAccounts.profile.equals(profileId) &
  //         driftAccounts.accType.isIn(fundingAccountIDs));

  //   final results = await query.get();

  //   return results.map((row) {
  //     final account = row.readTable(driftAccounts);
  //     final accType = row.readTable(driftAccTypes);
  //     final balance = row.readTable(driftBalances);

  //     return Ledger(
  //       account: account,
  //       accType: accType,
  //       balance: balance,
  //     );
  //   }).toList();
  // }

  Future<List<DriftAccType>> getFundAccTypes() async {
    return await (select(driftAccTypes)..where((a) => a.id.isIn(fundIDs)))
        .get();
  }

  Future<List<DriftAccType>> getCreditAccTypes() async {
    return await (select(driftAccTypes)..where((a) => a.id.isIn(creditIDs)))
        .get();
  }

  Future<List<DriftAccType>> getFundingAccTypes() async {
    return await (select(driftAccTypes)
          ..where((a) => a.id.isIn(fundingAccountIDs)))
        .get();
  }

  Future<List<DriftAccType>> getAccTypesByCategory(List<int> accTypeIDs) async {
    return await (select(driftAccTypes)..where((a) => a.id.isIn(accTypeIDs)))
        .get();
  }

  Future<List<DriftAccType>> getBalanceAccTypes() async {
    return await (select(driftAccTypes)..where((a) => a.id.isNotIn(incExpIDs)))
        .get();
  }

  Future<int?> getLastTransactionID() async {
    // Query to get the maximum value of the id column
    final query = select(driftTransactions)
      ..orderBy([(t) => OrderingTerm.desc(t.id)])
      ..limit(1);

    final result = await query.getSingleOrNull();
    return result?.id;
  }

  Future<Map<E, DriftAccount>>
      getTableWithAccounts<E extends DataClass, T extends Table>(
    TableInfo<T, E> table,
    Column<int> accountColumn,
  ) async {
    final query = select(table).join([
      innerJoin(driftAccounts, driftAccounts.id.equalsExp(accountColumn)),
    ]);

    final results = await query.get();

    final map = <E, DriftAccount>{};
    for (final row in results) {
      final tableEntry = row.readTable(table);
      final accountEntry = row.readTable(driftAccounts);
      map[tableEntry] = accountEntry;
    }
    return map;
  }

  Future<Map<DriftBank, DriftAccount>> getBanksWithAccounts() {
    return getTableWithAccounts(driftBanks, driftBanks.account);
  }

  Future<Map<DriftWallet, DriftAccount>> getWalletsWithAccounts() {
    return getTableWithAccounts(driftWallets, driftWallets.account);
  }

  Future<Map<DriftLoan, DriftAccount>> getLoansWithAccounts() {
    return getTableWithAccounts(driftLoans, driftLoans.account);
  }

  Future<Map<DriftCCard, DriftAccount>> getCCardsWithAccounts() {
    return getTableWithAccounts(driftCCards, driftCCards.account);
  }

  Future<int> calculateBalance(int accountId) async {
    // Fetch the opening balance from the account table
    final account = await (select(driftAccounts)
          ..where((a) => a.id.equals(accountId)))
        .getSingleOrNull();

    if (account == null) {
      throw Exception("DriftAccount not found");
    }

    final query = customSelect(
      'SELECT '
      'SUM(CASE WHEN dr = ? THEN amount ELSE 0 END) AS totalDebit, '
      'SUM(CASE WHEN cr = ? THEN amount ELSE 0 END) AS totalCredit '
      'FROM drift_transactions',
      variables: [
        Variable.withInt(accountId),
        Variable.withInt(accountId),
      ],
      readsFrom: {driftTransactions},
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
      // Asset and Expense driftAccounts: Debit increases, Credit decreases
      closingBalance = openingBalance + totalDebit - totalCredit;
    } else if (DBUtils.isLiabilityOrIncome(accountType)) {
      // Liability and Income driftAccounts: Credit increases, Debit decreases
      closingBalance = openingBalance + totalCredit - totalDebit;
    } else {
      throw Exception("Unknown account type");
    }
    return closingBalance;
  }

  Future<int> getFundClosingBalance(DateTime closingDate, int profileID) async {
    // Fetch driftAccounts where accType < 4
    final acc = await (select(driftAccounts)
          ..where((a) => a.accType.isIn(fundIDs) & a.profile.equals(profileID)))
        .get();

    // If no driftAccounts match, return 0
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
    final account = await (select(driftAccounts)
          ..where((a) => a.id.equals(accountId)))
        .getSingleOrNull();

    if (account == null) {
      throw Exception("DriftAccount not found");
    }

    // If the account was opened after the closing date, just return the opening balance.
    if (account.openDate.isAfter(closingDate)) {
      return account.openBal;
    }

    // Adjust closing date to cover the entire day
    final closingDateLimit =
        closingDate.copyWith(hour: 23, minute: 59, second: 59);

    // Use a single SQL query to sum both debit and credit driftTransactions
    final query = customSelect(
      'SELECT '
      'SUM(CASE WHEN dr = ? THEN amount ELSE 0 END) AS totalDebit, '
      'SUM(CASE WHEN cr = ? THEN amount ELSE 0 END) AS totalCredit '
      'FROM drift_transactions '
      'WHERE vch_date <= ?',
      variables: [
        Variable.withInt(accountId),
        Variable.withInt(accountId),
        Variable.withDateTime(closingDateLimit),
      ],
      readsFrom: {driftTransactions},
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
      // Asset and Expense driftAccounts: Debit increases, Credit decreases
      closingBalance = openingBalance + totalDebit - totalCredit;
    } else if (DBUtils.isLiabilityOrIncome(accountType)) {
      // Liability and Income driftAccounts: Credit increases, Debit decreases
      closingBalance = openingBalance + totalCredit - totalDebit;
    } else {
      throw Exception("Unknown account type");
    }
    return closingBalance;
  }

  Future<List<DriftTransaction>> getLastNTransactions(int n) async {
    return await (select(driftTransactions)
          ..orderBy(
              [(t) => OrderingTerm.desc(t.vchDate)]) // Order by latest date
          ..limit(n)) // Get last 8 entries
        .get();
  }

  Future<List<DriftBudget>> getBudgets() async {
    return await select(driftBudgets).get();
  }

  Future<DriftBudget> getBudgetbyId(int id) async {
    return await (select(driftBudgets)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<List<DriftBudget>> getBudgetsByProfile(int id) async {
    return await (select(driftBudgets)
          ..where((tbl) => tbl.profile.equals(id))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.name)]))
        .get();
  }

  Future<bool> updateBudget(DriftBudgetsCompanion companion) async {
    return await update(driftBudgets).replace(companion);
  }

  Future<int> insertBudget(DriftBudgetsCompanion companion) async {
    return await into(driftBudgets).insert(companion);
  }

  Future<int> deleteBudget(int id) async {
    return await (delete(driftBudgets)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<List<DriftBudgetFund>> getBudgetFunds() async {
    return await select(driftBudgetFunds).get();
  }

  Future<DriftBudgetFund> getBudgetFundbyId(int id) async {
    return await (select(driftBudgetFunds)..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<List<DriftAccount>> getBudgetFundAccountsByBudget(int id) async {
    final funds = await (select(driftBudgetFunds)
          ..where((tbl) => tbl.budget.equals(id))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.budget)]))
        .get();

    return await (select(driftAccounts)
          ..where((a) => a.id.isIn(funds.map((f) => f.account))))
        .get();
  }

  Future<bool> updateBudgetFund(DriftBudgetFundsCompanion companion) async {
    return await update(driftBudgetFunds).replace(companion);
  }

  Future<int> insertBudgetFund(DriftBudgetFundsCompanion companion) async {
    return await into(driftBudgetFunds).insert(companion);
  }

  Future<int> deleteBudgetFund(int id) async {
    return await (delete(driftBudgetFunds)..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<int> deleteBudgetFundByBudget(int id) async {
    return await (delete(driftBudgetFunds)
          ..where((tbl) => tbl.budget.equals(id)))
        .go();
  }

  Future<List<DriftBudgetAccount>> getBudgetAccounts() async {
    return await select(driftBudgetAccounts).get();
  }

  Future<DriftBudgetAccount> getBudgetAccountbyId(int id) async {
    return await (select(driftBudgetAccounts)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingle();
  }

  Future<List<DriftBudgetAccount>> getBudgetAccountsByBudget(int id) async {
    return await (select(driftBudgetAccounts)
          ..where((tbl) => tbl.budget.equals(id))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.budget)]))
        .get();
  }

  Future<bool> updateBudgetAccount(
      DriftBudgetAccountsCompanion companion) async {
    return await update(driftBudgetAccounts).replace(companion);
  }

  Future<int> insertBudgetAccount(
      DriftBudgetAccountsCompanion companion) async {
    return await into(driftBudgetAccounts).insert(companion);
  }

  Future<int> deleteBudgetAccount(int id) async {
    return await (delete(driftBudgetAccounts)
          ..where((tbl) => tbl.id.equals(id)))
        .go();
  }

  Future<int> deleteBudgetAccountByBudget(int id) async {
    return await (delete(driftBudgetAccounts)
          ..where((tbl) => tbl.budget.equals(id)))
        .go();
  }

  Future<Map<DriftAccount, int>> getAccountBalances(
      DateTime startDate, DateTime endDate) async {
    // Fetch all driftTransactions within the date range
    final trx = await (select(driftTransactions)
          ..where((t) => t.vchDate.isBiggerOrEqualValue(startDate))
          ..where((t) => t.vchDate.isSmallerOrEqualValue(endDate)))
        .get();

    // Map to store account driftBalances
    final Map<int, int> accountBalances = {};

    for (var txn in trx) {
      // Add to dr account balance
      accountBalances[txn.dr] = (accountBalances[txn.dr] ?? 0) + txn.amount;
      // Subtract from cr account balance
      accountBalances[txn.cr] = (accountBalances[txn.cr] ?? 0) - txn.amount;
    }

    // Fetch account details for all involved driftAccounts
    final accx = await (select(driftAccounts)
          ..where((a) => a.id.isIn(accountBalances.keys.toList())))
        .get();

    // Convert to Map<DriftAccount, int>
    return {for (var acc in accx) acc: accountBalances[acc.id] ?? 0};
  }

  Future<
      List<
          Tuple4<DriftBudget, List<DriftAccount>, Map<DriftAccount, int>,
              Map<DriftAccount, int>>>> getAllBudgets(int profileID) async {
    final budgetList = await (select(driftBudgets)
          ..where((b) => b.profile.equals(profileID)))
        .get(); // Get all driftBudgets
    List<
        Tuple4<DriftBudget, List<DriftAccount>, Map<DriftAccount, int>,
            Map<DriftAccount, int>>> plans = [];

    for (var budget in budgetList) {
      final funds = await (select(driftAccounts)
            ..where((a) => a.id.isInQuery(selectOnly(driftBudgetFunds)
              ..addColumns([driftBudgetFunds.account])
              ..where(driftBudgetFunds.budget.equals(budget.id)))))
          .get();

      final budgetAccountsList = await (select(driftBudgetAccounts)
            ..where((ba) => ba.budget.equals(budget.id)))
          .get();

      Map<DriftAccount, int> incomes = {};
      Map<DriftAccount, int> expenses = {};

      for (var ba in budgetAccountsList) {
        final account = await (select(driftAccounts)
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

      plans.add(Tuple4(
        budget,
        funds,
        incomes,
        expenses,
      ));
    }

    return plans;
  }

  Future<
      Tuple4<DriftBudget, List<DriftAccount>, Map<DriftAccount, int>,
          Map<DriftAccount, int>>> getBudgetByID(int id) async {
    final budget =
        await (select(driftBudgets)..where((b) => b.id.equals(id))).getSingle();

    final funds = await (select(driftAccounts)
          ..where((a) => a.id.isInQuery(selectOnly(driftBudgetFunds)
            ..addColumns([driftBudgetFunds.account])
            ..where(driftBudgetFunds.budget.equals(budget.id)))))
        .get();

    final budgetAccountsList = await (select(driftBudgetAccounts)
          ..where((ba) => ba.budget.equals(budget.id)))
        .get();

    Map<DriftAccount, int> incomes = {};
    Map<DriftAccount, int> expenses = {};

    for (var ba in budgetAccountsList) {
      final account = await (select(driftAccounts)
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

    return Tuple4(
      budget,
      funds,
      incomes,
      expenses,
    );
  }

  Future<int> insertProject(DriftProjectsCompanion project) =>
      into(driftProjects).insert(project);
  Future<bool> updateProject(DriftProjectsCompanion project) =>
      update(driftProjects).replace(project);
  Future<int> deleteProject(int id, {bool deleteTransactions = false}) async {
    if (deleteTransactions) {
      final fps = await (select(driftProjectPhotos)
            ..where((tbl) => tbl.project.equals(id)))
          .get();

      // Delete files from DriftTransactionPhotos before deleting the project
      for (final filePath in fps) {
        try {
          final file = File(filePath.path);
          if (await file.exists()) {
            await file.delete();
          }
        } catch (e) {
          AppLogger.instance.error("Cannot delete project image");
        }
      }
    }
    return (delete(driftProjects)..where((t) => t.id.equals(id))).go();
  }

  Future<DriftProject> getProjectById(int id) =>
      (select(driftProjects)..where((t) => t.id.equals(id))).getSingle();
  Future<List<DriftProject>> getProjectsByProfile(int id) =>
      (select(driftProjects)..where((t) => t.profile.equals(id))).get();

  Future<int> insertProjectPhoto(DriftProjectPhotosCompanion projectPhoto) =>
      into(driftProjectPhotos).insert(projectPhoto);
  Future<bool> updateProjectPhoto(DriftProjectPhotosCompanion projectPhoto) =>
      update(driftProjectPhotos).replace(projectPhoto);
  Future<int> deleteProjectPhoto(int id) =>
      (delete(driftProjectPhotos)..where((t) => t.id.equals(id))).go();
  Future<DriftProjectPhoto> getProjectPhotoById(int id) =>
      (select(driftProjectPhotos)..where((t) => t.id.equals(id))).getSingle();

  Future<int> deleteProjectPhotobyProject(int id) =>
      (delete(driftProjectPhotos)..where((t) => t.project.equals(id))).go();
  Future<List<DriftProjectPhoto>> getProjectPhotosByProject(int id) =>
      (select(driftProjectPhotos)..where((t) => t.project.equals(id))).get();

  Future<int> insertSubscription(DriftSubscriptionsCompanion subscription) =>
      into(driftSubscriptions).insert(subscription);
  Future<bool> updateSubscription(DriftSubscriptionsCompanion subscription) =>
      update(driftSubscriptions).replace(subscription);
  Future<int> deleteSubscription(int id) =>
      (delete(driftSubscriptions)..where((t) => t.id.equals(id))).go();
  Future<DriftSubscription> getSubscriptionById(int id) =>
      (select(driftSubscriptions)..where((t) => t.id.equals(id))).getSingle();

  Future<Tuple2<DriftProject, List<String>>?> getProjectByID(
      int projectId) async {
    // Fetch the project
    final project = await (select(driftProjects)
          ..where((tbl) => tbl.id.equals(projectId)))
        .getSingleOrNull();

    if (project == null) {
      return null; // DriftProject not found
    }

    // Fetch all related photos
    final photos = await (select(driftProjectPhotos)
          ..where((tbl) => tbl.project.equals(projectId)))
        .get();

    // Fetch the associated budget (if exists)

    // Construct and return the Project
    return Tuple2(
      project,
      photos.map((p) => p.path).toList(),
    );
  }

  Future<
      List<
          Tuple5<
              DriftTransaction,
              DriftAccount,
              DriftAccount,
              List<DriftTransactionPhoto>,
              DriftProject?>>> getTransactionsbyProject(
      {required int profileID, required int projectID, reversed = true}) async {
    // Define aliases for driftAccounts table to handle 'dr' and 'cr'
    final drAccounts = alias(driftAccounts, 'drAccounts');
    final crAccounts = alias(driftAccounts, 'crAccounts');

    // Query to fetch driftTransactions and their related driftAccounts
    final query = select(driftTransactions).join([
      leftOuterJoin(drAccounts, drAccounts.id.equalsExp(driftTransactions.dr)),
      leftOuterJoin(crAccounts, crAccounts.id.equalsExp(driftTransactions.cr)),
    ])
      ..where(driftTransactions.profile.equals(profileID) &
          driftTransactions.project.equals(projectID))
      ..orderBy([
        reversed
            ? OrderingTerm.desc(driftTransactions.vchDate)
            : OrderingTerm.asc(driftTransactions.vchDate)
      ]);

    // Get transaction results
    final transactionResults = await query.get();

    // Extract transaction IDs to fetch related file paths
    final transactionIds = transactionResults.map((row) {
      final transaction = row.readTable(driftTransactions);
      return transaction.id;
    }).toList();

    // Query to fetch all file paths related to the transaction IDs
    final filePathResults = await (select(driftTransactionPhotos)
          ..where((filePath) => filePath.transaction.isIn(transactionIds)))
        .get();

    // Map transaction ID to its related file paths
    final filePathMap = <int, List<DriftTransactionPhoto>>{};
    for (final filePath in filePathResults) {
      filePathMap.putIfAbsent(filePath.transaction, () => []).add(filePath);
    }
    final allProjects = await getProjectsByProfile(profileID);

    // Map the results to the DoubleEntry model
    return transactionResults.map((row) {
      final transaction = row.readTable(driftTransactions);
      final drAccount = row.readTable(drAccounts);
      final crAccount = row.readTable(crAccounts);

      return Tuple5(
          transaction,
          drAccount,
          crAccount,
          filePathMap[transaction.id] ?? [],
          allProjects.firstWhereOrNull((p) => p.id == transaction.project));
    }).toList();
  }

  Future<int> insertReceivable(DriftReceivablesCompanion receivable) =>
      into(driftReceivables).insert(receivable);
  Future<bool> updateReceivable(DriftReceivablesCompanion receivable) =>
      update(driftReceivables).replace(receivable);
  Future<int> deleteReceivable(int id) =>
      (delete(driftReceivables)..where((t) => t.id.equals(id))).go();
  Future<DriftReceivable> getReceivableById(int id) =>
      (select(driftReceivables)..where((t) => t.id.equals(id))).getSingle();
  Future<DriftReceivable> getReceivableByAccount(int id) =>
      (select(driftReceivables)..where((t) => t.accountId.equals(id)))
          .getSingle();

  Future<int> insertPeople(DriftPeopleCompanion people) =>
      into(driftPeople).insert(people);
  Future<bool> updatePeople(DriftPeopleCompanion people) =>
      update(driftPeople).replace(people);
  Future<int> deletePeople(int id) =>
      (delete(driftPeople)..where((t) => t.id.equals(id))).go();
  Future<DriftPeopleData> getPeopleById(int id) =>
      (select(driftPeople)..where((t) => t.id.equals(id))).getSingle();
  Future<DriftPeopleData> getPeopleByAccount(int id) =>
      (select(driftPeople)..where((t) => t.accountId.equals(id))).getSingle();
}

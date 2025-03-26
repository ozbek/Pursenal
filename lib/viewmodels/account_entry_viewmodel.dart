import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:pursenal/app/global/date_formats.dart';
import 'package:pursenal/app/global/values.dart';
import 'package:pursenal/core/db/database.dart';
import 'package:pursenal/core/enums/loading_status.dart';
import 'package:pursenal/core/repositories/acc_types_drift_repository.dart';
import 'package:pursenal/core/repositories/accounts_drift_repository.dart';
import 'package:pursenal/core/repositories/balances_drift_repository.dart';
import 'package:pursenal/core/repositories/banks_drift_repository.dart';
import 'package:pursenal/core/repositories/ccards_drift_repository.dart';
import 'package:pursenal/core/repositories/loans_drift_repository.dart';
import 'package:pursenal/core/repositories/wallets_drift_repository.dart';
import 'package:pursenal/utils/app_logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountEntryViewModel extends ChangeNotifier {
  final WalletsDriftRepository _walletsDriftRepository;
  final AccountsDriftRepository _accountsDriftRepository;
  final AccTypesDriftRepository _accTypesDriftRepository;
  final BalancesDriftRepository _balancesDriftRepository;
  final LoansDriftRepository _loansDriftRepository;
  final CCardsDriftRepository _cCardsDriftRepository;
  final BanksDriftRepository _banksDriftRepository;

  AccountEntryViewModel({
    required MyDatabase db,
    required Profile profile,
    AccType? accType,
    Account? account,
  })  : _profile = profile,
        _walletsDriftRepository = WalletsDriftRepository(db),
        _accountsDriftRepository = AccountsDriftRepository(db),
        _accTypesDriftRepository = AccTypesDriftRepository(db),
        _balancesDriftRepository = BalancesDriftRepository(db),
        _loansDriftRepository = LoansDriftRepository(db),
        _cCardsDriftRepository = CCardsDriftRepository(db),
        _banksDriftRepository = BanksDriftRepository(db),
        _accountType = accType,
        _account = account;

  int? _accountId;
  String _accountName = "";
  AccType? _accountType;
  int _openBal = 0;
  DateTime _openDate = DateTime.now();
  bool _isEditable = true;
  final Profile _profile;

  Profile get profile => _profile;

  String? _holderName;
  String? _institution;
  String? _branch;
  String? _branchCode;

  String? _cardNetwork;
  String? _cardNo;
  int? _statementDate;
  String? _accountNo;
  String? _agreementNo;
  double? _interestRate;
  DateTime? _startDate;
  DateTime? _endDate;

  Account? _account;
  Loan? _loan;
  Wallet? _wallet;
  Bank? _bank;
  CCard? _card;

  String _accountNameError = "";
  String _accountTypeError = "";
  String _amountError = "";
  String _openDateError = "";
  String _statementDateError = "";
  String _interestRateError = "";

  String get accountNameError => _accountNameError;
  String get accountTypeError => _accountTypeError;
  String get amountError => _amountError;
  String get openDateError => _openDateError;
  String get statementDateError => _statementDateError;
  String get interestRateError => _interestRateError;

  LoadingStatus loadingStatus = LoadingStatus.idle;
  String errorText = "";

  List<AccType> _accTypes = [];

  List<AccType> get accTypes => _accTypes;

  List<Account> _accounts = [];

  SharedPreferences? _prefs;

  String? amountHelperText;

  Future<void> init() async {
    loadingStatus = LoadingStatus.loading;
    _prefs = await SharedPreferences.getInstance();

    await _getAccount();

    _openDate = DateTime(_openDate.year);

    if (_account != null) {
      _accountName = _account!.name;
      _openBal = _account!.openBal;
      _openDate = _account!.openDate;
    }

    if (_wallet != null) {
    } else if (_bank != null) {
      _holderName = _bank!.holderName;
      _accountNo = _bank!.accountNo;
      _branch = _bank!.branch;
      _institution = _bank!.institution;
      _branchCode = _bank!.branchCode;
    } else if (_card != null) {
      _cardNetwork = _card!.cardNetwork;
      _cardNo = _card!.cardNo;
      _statementDate = _card!.statementDate;
      _institution = _card!.institution;
    } else if (_loan != null) {
      _institution = _loan!.institution;
      _accountNo = _loan!.accountNo;
      _agreementNo = _loan!.agreementNo;
      _interestRate = _loan!.interestRate;
      _startDate = _loan!.startDate;
      _endDate = _loan!.endDate;
    }

    await _getAccTypes();
    _accountType ??=
        _accTypes.firstWhereOrNull((a) => a.id == _account?.accType) ??
            _accTypes.first;

    _setHelperText();

    loadingStatus = LoadingStatus.completed;
    notifyListeners();
    await _getAccounts();
  }

  Future<void> _getAccount() async {
    try {
      if (_account != null) {
        _account = await _accountsDriftRepository.getById(_account!.id);

        switch (_account?.accType) {
          case 0:
            _wallet =
                await _accountsDriftRepository.getWalletByAccount(_account!.id);
            break;
          case 1:
            _bank =
                await _accountsDriftRepository.getBankByAccount(_account!.id);
            break;
          case 2:
            _card =
                await _accountsDriftRepository.getCCardByAccount(_account!.id);
            break;
          case 3:
            _loan =
                await _accountsDriftRepository.getLoanByAccount(_account!.id);
            break;
          default:
            break;
        }
      }

      AppLogger.instance.info("Account loaded from database");
    } catch (e) {
      AppLogger.instance.error("Error loading account ${e.toString()}");
    }
    notifyListeners();
  }

  Future<void> _getAccounts() async {
    try {
      _accounts = await _accountsDriftRepository.getAccountsByProfile(
          profileId: _profile.id);

      if (_account != null) {
        _accounts.removeWhere((a) {
          return a.id == _account!.id;
        });
      }

      AppLogger.instance.info("Accounts loaded from database");
    } catch (e) {
      AppLogger.instance.error("Error loading ledgers ${e.toString()}");
    }
    notifyListeners();
  }

  // Getters and Setters for Account-related fields
  int? get accountId => _accountId;
  set accountId(int? value) {
    _accountId = value;
    notifyListeners();
  }

  String get accountName => _accountName;
  set accountName(String value) {
    _accountName = value;
    notifyListeners();
  }

  AccType? get accountType => _accountType;
  set accountType(AccType? value) {
    _accountType = value;
    if (value != null && fundingAccountIDs.contains(value.id)) {
      openBal = 0;
    }
    _setHelperText();
    notifyListeners();
  }

  int get openBal => _openBal;
  set openBal(int value) {
    _openBal = value;
    if (_openBal == 0) {
      _setHelperText();
    }
    notifyListeners();
  }

  DateTime get openDate => _openDate;
  set openDate(DateTime value) {
    _openDate = value;
    _setHelperText();
    notifyListeners();
  }

  bool get isEditable => _isEditable;
  set isEditable(bool value) {
    _isEditable = value;
    notifyListeners();
  }

  // Getters and Setters for Bank-related fields

  String? get holderName => _holderName;
  set holderName(String? value) {
    _holderName = value;
    notifyListeners();
  }

  String? get institution => _institution;
  set institution(String? value) {
    _institution = value;
    notifyListeners();
  }

  String? get branch => _branch;
  set branch(String? value) {
    _branch = value;
    notifyListeners();
  }

  String? get branchCode => _branchCode;
  set branchCode(String? value) {
    _branchCode = value;
    notifyListeners();
  }

  // Getters and Setters for Card-related fields

  String? get cardNetwork => _cardNetwork;
  set cardNetwork(String? value) {
    _cardNetwork = value;
    notifyListeners();
  }

  String? get cardNo => _cardNo;
  set cardNo(String? value) {
    _cardNo = value;
    notifyListeners();
  }

  int? get statementDate => _statementDate;
  set statementDate(int? value) {
    _statementDate = value;
    notifyListeners();
  }

  // Getters and Setters for Loan-related fields

  String? get accountNo => _accountNo;
  set accountNo(String? value) {
    _accountNo = value;
    notifyListeners();
  }

  String? get agreementNo => _agreementNo;
  set agreementNo(String? value) {
    _agreementNo = value;
    notifyListeners();
  }

  double? get interestRate => _interestRate;
  set interestRate(double? value) {
    _interestRate = value;
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

  // Setters for related objects

  // Loan setter

  set loan(Loan? value) {
    _loan = value;
    if (value != null) {
      _getAccountbyId(value.account);
      _accountNo = value.accountNo;
      _agreementNo = value.agreementNo;
      _interestRate = value.interestRate;
      _startDate = value.startDate;
      _endDate = value.endDate;
    }
    notifyListeners();
  }

  set wallet(Wallet? value) {
    _wallet = value;
    if (value != null) {
      _getAccountbyId(value.account);

      _accountId = value.account;
    }
    notifyListeners();
  }

  set bank(Bank? value) {
    _bank = value;
    if (value != null) {
      _getAccountbyId(value.account);

      _holderName = value.holderName;
      _institution = value.institution;
      _branch = value.branch;
      _branchCode = value.branchCode;
    }
    notifyListeners();
  }

  // Card setter
  set card(CCard? value) {
    _card = value;
    if (value != null) {
      _getAccountbyId(value.account);

      _cardNetwork = value.cardNetwork;
      _cardNo = value.cardNo;
      _statementDate = value.statementDate;
    }
    notifyListeners();
  }

  Future<void> _getAccTypes() async {
    try {
      _accTypes = await _accTypesDriftRepository.getAll();
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
    }
    notifyListeners();
  }

  Future<void> _getAccountbyId(int id) async {
    try {
      _account = await _accountsDriftRepository.getById(id);
      if (_account != null) {
        _accountName = _account!.name;
        _accountId = _account!.id;
        _openBal = _account!.openBal;
      }
    } catch (e) {
      AppLogger.instance.error(' ${e.toString()}');
    }
    notifyListeners();
  }

  // Validate Fields
  bool _validate() {
    bool isValid = true;

    // Clear all error texts
    _accountNameError = "";
    _accountTypeError = "";
    _amountError = "";
    _statementDateError = "";
    _interestRateError = "";
    _openDateError = "";
    notifyListeners();

    // Validation logic
    if (_accountName.trim().isEmpty) {
      _accountNameError = "Account name must be valid.";
      isValid = false;
    }

    if (_accounts.where((a) => a.name == _accountName).isNotEmpty) {
      _accountNameError = "Account name already exist.";
      isValid = false;
    }
    if (_accountType == null) {
      _accountTypeError = "Account type is required.";
      isValid = false;
    }
    if (_accountType != null &&
        _accountType!.id == cCardTypeID &&
        _statementDate != null &&
        (_statementDate! < 1 || _statementDate! > 31)) {
      _statementDateError = "Statement date must be between 1 and 31.";
      isValid = false;
    }
    if (_interestRate != null && (_interestRate! < 0 || _interestRate! > 100)) {
      _interestRateError = "Interest rate must be between 0 and 100.";
      isValid = false;
    }
    if (_openBal < 0) {
      _amountError = "Enter a valid amount.";
      isValid = false;
    }
    if (_openDate.isAfter(DateTime.now())) {
      _openDateError = "Date cannot be in the future.";
      isValid = false;
    }
    notifyListeners();

    return isValid;
  }

  Future<bool> deleteAccount() async {
    if (_account != null) {
      try {
        await _accountsDriftRepository.delete(_account!.id);
        return true;
      } catch (e) {
        AppLogger.instance.error(' ${e.toString()}');
        errorText = 'Error: Failed to delete account ';
        return false;
      }
    }
    notifyListeners();
    return false;
  }

  Future<bool> save() async {
    try {
      if (_validate()) {
        loadingStatus = LoadingStatus.submitting;
        notifyListeners();
        int? accId = _account == null
            ? await _accountsDriftRepository.insertAccount(
                name: _accountName,
                accType: _accountType!.id,
                openBal: _openBal,
                openDate: _openDate,
                profile: _profile.id,
              )
            : await _accountsDriftRepository.updateAccount(
                    name: _accountName,
                    accType: _accountType!.id,
                    openBal: _openBal,
                    openDate: _openDate,
                    profile: _profile.id,
                    id: _account!.id)
                ? _account!.id
                : null;

        if (accId != null) {
          if (_accountType!.id == cashTypeID) {
            if (_wallet == null) {
              _walletsDriftRepository.insertWallet(account: accId);
            } else {
              _walletsDriftRepository.updateWallet(
                  id: _wallet!.id, account: accId);
            }
          } else if (_accountType!.id == bankTypeID) {
            if (_bank == null) {
              _banksDriftRepository.insertBank(
                  account: accId,
                  branch: _branch,
                  accountNo: _accountNo,
                  branchCode: _branchCode,
                  holderName: _holderName,
                  institution: _institution);
            } else {
              _banksDriftRepository.updateBank(
                  id: _bank!.id,
                  account: accId,
                  accountNo: _accountNo,
                  branch: _branch,
                  branchCode: _branchCode,
                  holderName: _holderName,
                  institution: _institution);
            }
          } else if (_accountType!.id == cCardTypeID) {
            if (_card == null) {
              _cCardsDriftRepository.insertCCard(
                  account: accId,
                  cardNetwork: _cardNetwork,
                  cardNo: _cardNo,
                  institution: _institution,
                  statementDate: _statementDate);
            } else {
              _cCardsDriftRepository.updateCCard(
                  id: _card!.id,
                  account: accId,
                  cardNetwork: _cardNetwork,
                  cardNo: _cardNo,
                  institution: _institution,
                  statementDate: _statementDate);
            }
          } else if (_accountType!.id == loanTypeID) {
            if (_loan == null) {
              _loansDriftRepository.insertLoan(
                account: accId,
                institution: _institution,
                accountNo: _accountNo,
                agreementNo: _agreementNo,
                interestRate: _interestRate,
                startDate: _startDate,
                endDate: _endDate,
              );
            } else {
              _loansDriftRepository.updateLoan(
                id: _loan!.id,
                account: accId,
                institution: _institution,
                accountNo: _accountNo,
                agreementNo: _agreementNo,
                interestRate: _interestRate,
                startDate: _startDate,
                endDate: _endDate,
              );
            }
          }

          if (_account != null) {
            await _balancesDriftRepository.updateBalanceByAccount(
              account: accId,
            );
          } else {
            await _balancesDriftRepository.insertBalance(
                account: accId, amount: _openBal);
          }
        }
        loadingStatus = LoadingStatus.submitted;
        notifyListeners();
        _setLastUpdatedTimeStamp();
        AppLogger.instance.info("Account saved.");
        return true;
      }

      notifyListeners();
      return false;
    } catch (e) {
      AppLogger.instance.error('Failed to save account : ${e.toString()}');
      errorText = 'Error: Failed to save account';
      return false;
    }
  }

  void resetErrorText() {
    errorText = "";
    notifyListeners();
  }

  Future<void> _setLastUpdatedTimeStamp() async {
    try {
      final timeStamp = DateTime.now();
      _prefs?.setInt('lastUpdated', timeStamp.millisecondsSinceEpoch);
    } catch (e) {
      AppLogger.instance
          .error("Error setting Last updated timestamp ${e.toString()}");
    }
  }

  _setHelperText() {
    if (_accountType != null && _openBal == 0) {
      switch (_accountType?.id) {
        case 0:
          amountHelperText =
              "* Enter your wallet balance (as on ${defaultDate2.format(openDate)})";
          break;
        case 1:
          amountHelperText =
              "* Enter the bank account balance (as on ${defaultDate2.format(openDate)})";
          break;
        case 2:
          amountHelperText =
              "* Enter the used amount out of total credit card limit (as on ${defaultDate2.format(openDate)})";
          break;
        case 3:
          amountHelperText =
              "* Enter the loan balance (as on ${defaultDate2.format(openDate)})";
          break;
        default:
          amountHelperText = null;
          break;
      }
    } else {
      amountHelperText = null;
    }
    notifyListeners();
  }
}

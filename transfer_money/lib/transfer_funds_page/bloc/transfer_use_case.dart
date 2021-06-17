import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:transfer_money/core/example_locator.dart';
import 'package:transfer_money/transfer_funds_page/bloc/submit_service_adapter.dart';
import 'package:transfer_money/transfer_funds_page/bloc/transfer_bloc.dart';
import 'package:transfer_money/transfer_funds_page/entity/account_root_entity.dart';
import 'package:transfer_money/transfer_funds_page/view_model/account_list_view_model.dart';
import 'package:transfer_money/transfer_funds_page/view_model/account_view_model.dart';
import 'package:transfer_money/transfer_funds_page/view_model/transfer_page_view_model.dart';

import 'account_details_service_adapter.dart';


class TransferPageUseCase extends UseCase {
  Function(ViewModel) _accountDetailsViewModelCallBack;
  Function(ViewModel) _transferToFromViewModelCallBack;
  Function(ViewModel) _successPageViewModelCallBack;

  RepositoryScope scope;

  TransferPageUseCase(
      {Function accountDetailsViewModelCallBack,
      Function transferToFromViewModelCallBack,
        Function successPageViewModelCallBack})
      : assert(accountDetailsViewModelCallBack != null),
        _accountDetailsViewModelCallBack = accountDetailsViewModelCallBack,
        _transferToFromViewModelCallBack = transferToFromViewModelCallBack,
  _successPageViewModelCallBack = successPageViewModelCallBack ;

  void create() async {
    scope = ExampleLocator.instance.repository
        .containsScope<AccountRootEntity>();
    if (scope == null) {
      scope = ExampleLocator.instance.repository.create<AccountRootEntity>(
          AccountRootEntity(), _notifySubscribers,
          deleteIfExists: true);
    } else {
      scope.subscription = _notifySubscribers;
    }

    await ExampleLocator.instance.repository
        .runServiceAdapter(scope, AccountDetailsServiceAdapter());
  }

  void _notifySubscribers(entity) {
    _accountDetailsViewModelCallBack(buildViewModel(entity));
  }

  AccountListViewModel buildViewModel(AccountRootEntity entity) {
    List<AccountViewModel> accDetails = [];
    entity.accountDetails.forEach((e) {
      if (entity.lastSelectedAccountType == AccountType.FromAccount) {
        if (!(e.id == entity.selectedToAccountId)) {
          accDetails.add(AccountViewModel(
              id: e.id,
              accountType: e.accountType,
              accountName: e.accountName,
              accountBalance: e.accountBalance));
        }
      } else {
        if (!(e.id == entity.selectedFromAccountId)) {
          accDetails.add(AccountViewModel(
              id: e.id,
              accountType: e.accountType,
              accountName: e.accountName,
              accountBalance: e.accountBalance));
        }
      }
    });
    return AccountListViewModel(accountDetails: accDetails);
  }

  void selectedAccountId(String selectedId) {
    RepositoryScope scope = ExampleLocator.instance.repository
        .containsScope<AccountRootEntity>();

    final transferRootEntity =
        ExampleLocator.instance.repository.get<AccountRootEntity>(scope);

    if (transferRootEntity.lastSelectedAccountType == AccountType.FromAccount) {
      ExampleLocator.instance.repository.update<AccountRootEntity>(
          scope, transferRootEntity.merge(selectedFromAccId: selectedId));
    } else {
      ExampleLocator.instance.repository.update<AccountRootEntity>(
          scope, transferRootEntity.merge(selectedToAccId: selectedId));
    }

    _transferToFromViewModelCallBack(buildViewModelForTransferScreen(
        ExampleLocator.instance.repository.get<AccountRootEntity>(scope)));
  }

  void updateLastSelectedAccountType(AccountType accountType) {
    RepositoryScope scope = ExampleLocator.instance.repository
        .containsScope<AccountRootEntity>();
    if (scope == null) {
      scope = ExampleLocator.instance.repository.create<AccountRootEntity>(
          AccountRootEntity(), _notifySubscribers,
          deleteIfExists: true);
    }

    final transferRootEntity =
        ExampleLocator.instance.repository.get<AccountRootEntity>(scope);

    ExampleLocator.instance.repository.update<AccountRootEntity>(
        scope, transferRootEntity.merge(lastSelectedAccountType: accountType));
  }

  void _notifySubscribersForTransferScreen(entity) {
    _transferToFromViewModelCallBack(
        buildViewModelForTransferScreenAfterSuccess(entity));
  }

  TransferPageViewModel buildViewModelForTransferScreenAfterSuccess(
      AccountRootEntity entity) {
    final entityToElement = entity.accountDetails
        .firstWhere((element) => element.id == entity.selectedToAccountId);
    final entityFromElement = entity.accountDetails
        .firstWhere((element) => element.id == entity.selectedFromAccountId);
    final toViewModel = AccountViewModel(
        id: entityToElement.id,
        accountBalance: entityToElement.accountBalance,
        accountName: entityToElement.accountName,
        accountType: entityToElement.accountType);
    final fromViewModel = AccountViewModel(
        id: entityFromElement.id,
        accountBalance: entityFromElement.accountBalance,
        accountName: entityFromElement.accountName,
        accountType: entityFromElement.accountType);
    return TransferPageViewModel(
        from: fromViewModel,
        to: toViewModel,
        amount: entity.amount,
        didSucceed: true);
  }

  TransferPageViewModel buildViewModelForTransferScreen(
      AccountRootEntity entity) {
    if (entity.selectedFromAccountId != "" && entity.selectedToAccountId != "") {
      final entityToElement = entity.accountDetails
          .firstWhere((element) => element.id == entity.selectedToAccountId);
      final entityFromElement = entity.accountDetails
          .firstWhere((element) => element.id == entity.selectedFromAccountId);
      final toViewModel = AccountViewModel(
          id: entityToElement.id,
          accountBalance: entityToElement.accountBalance,
          accountName: entityToElement.accountName,
          accountType: entityToElement.accountType);
      final fromViewModel = AccountViewModel(
          id: entityFromElement.id,
          accountBalance: entityFromElement.accountBalance,
          accountName: entityFromElement.accountName,
          accountType: entityFromElement.accountType);
      return TransferPageViewModel(
          from: fromViewModel, to: toViewModel, amount: entity.amount);
    } else if (entity.selectedFromAccountId == "" && entity.selectedToAccountId == "") {
      return TransferPageViewModel(amount: entity.amount);
    } else if (entity.selectedFromAccountId == "") {
      final entityElement = entity.accountDetails
          .firstWhere((element) => element.id == entity.selectedToAccountId);
      final toViewModel = AccountViewModel(
          id: entityElement.id,
          accountBalance: entityElement.accountBalance,
          accountName: entityElement.accountName,
          accountType: entityElement.accountType);
      return TransferPageViewModel(
          to: toViewModel, amount: entity.amount);
    } else {
      final entityFromElement = entity.accountDetails
          .firstWhere((element) => element.id == entity.selectedFromAccountId);
      final fromViewModel = AccountViewModel(
          id: entityFromElement.id,
          accountBalance: entityFromElement.accountBalance,
          accountName: entityFromElement.accountName,
          accountType: entityFromElement.accountType);
      return TransferPageViewModel(
          from: fromViewModel, amount: entity.amount);
    }
  }

  void setTransferPageInitialState() {
    RepositoryScope scope = ExampleLocator.instance.repository
        .containsScope<AccountRootEntity>();

    if (scope == null) {
      scope = ExampleLocator.instance.repository.create<AccountRootEntity>(
          AccountRootEntity(), _notifySubscribers,
          deleteIfExists: true);
    }

    _transferToFromViewModelCallBack(buildViewModelForTransferScreen(
        ExampleLocator.instance.repository.get<AccountRootEntity>(scope)));
  }

  void updateAmount(double amount) {
    RepositoryScope scope = ExampleLocator.instance.repository
        .containsScope<AccountRootEntity>();

    if (scope == null) {
      scope = ExampleLocator.instance.repository.create<AccountRootEntity>(
          AccountRootEntity(), _notifySubscribers,
          deleteIfExists: true);
    }
    final transferRootEntity =
        ExampleLocator.instance.repository.get<AccountRootEntity>(scope);

    ExampleLocator.instance.repository.update<AccountRootEntity>(
        scope, transferRootEntity.merge(amount: amount));

    _transferToFromViewModelCallBack(buildViewModelForTransferScreen(
        ExampleLocator.instance.repository.get<AccountRootEntity>(scope)));
  }

  void submitBtnTapped() async {
    RepositoryScope scope = ExampleLocator.instance.repository
        .containsScope<AccountRootEntity>();
    if (scope == null) {
      scope = ExampleLocator.instance.repository.create<AccountRootEntity>(
          AccountRootEntity(), _notifySubscribersForTransferScreen,
          deleteIfExists: true);
    } else {
      scope.subscription = _notifySubscribersForTransferScreen;
    }
    final transferRootEntity =
        ExampleLocator.instance.repository.get<AccountRootEntity>(scope);
    if (transferRootEntity.selectedToAccountId == '' ||
        transferRootEntity.selectedFromAccountId == '' ||
        transferRootEntity.amount == 0) {
      _transferToFromViewModelCallBack(
          buildViewModelForTransferScreenForSubmitBtn(transferRootEntity));
    } else {
      await ExampleLocator.instance.repository
          .runServiceAdapter(scope, SubmitServiceAdapter());
    }
  }

  TransferPageViewModel buildViewModelForTransferScreenForSubmitBtn(
      AccountRootEntity entity) {
    if (entity.selectedFromAccountId != "" && entity.selectedToAccountId != "") {
      final entityToElement = entity.accountDetails
          .firstWhere((element) => element.id == entity.selectedToAccountId);
      final entityFromElement = entity.accountDetails
          .firstWhere((element) => element.id == entity.selectedFromAccountId);
      final toViewModel = AccountViewModel(
          id: entityToElement.id,
          accountBalance: entityToElement.accountBalance,
          accountName: entityToElement.accountName,
          accountType: entityToElement.accountType);
      final fromViewModel = AccountViewModel(
          id: entityFromElement.id,
          accountBalance: entityFromElement.accountBalance,
          accountName: entityFromElement.accountName,
          accountType: entityFromElement.accountType);
      return TransferPageViewModel(
          from: fromViewModel,
          to: toViewModel,
          amount: entity.amount,
          dataError: true);
    } else if (entity.selectedFromAccountId == "" && entity.selectedToAccountId == "") {
      return TransferPageViewModel(
          amount: entity.amount, dataError: true);
    } else if (entity.selectedFromAccountId == "") {
      final entityElement = entity.accountDetails
          .firstWhere((element) => element.id == entity.selectedToAccountId);
      final toViewModel = AccountViewModel(
          id: entityElement.id,
          accountBalance: entityElement.accountBalance,
          accountName: entityElement.accountName,
          accountType: entityElement.accountType);
      return TransferPageViewModel(
          to: toViewModel, amount: entity.amount, dataError: true);
    } else {
      final entityFromElement = entity.accountDetails
          .firstWhere((element) => element.id == entity.selectedFromAccountId);
      final fromViewModel = AccountViewModel(
          id: entityFromElement.id,
          accountBalance: entityFromElement.accountBalance,
          accountName: entityFromElement.accountName,
          accountType: entityFromElement.accountType);
      return TransferPageViewModel(
          from: fromViewModel, amount: entity.amount, dataError: true);
    }
  }

  void getDataForSuccessPage() {
    RepositoryScope scope = ExampleLocator.instance.repository
        .containsScope<AccountRootEntity>();
    final transferRootEntity =
    ExampleLocator.instance.repository.get<AccountRootEntity>(scope);
    _successPageViewModelCallBack(buildViewModelForSuccessPage(transferRootEntity));
  }

  TransferPageViewModel buildViewModelForSuccessPage(AccountRootEntity entity){
    final entityToElement = entity.accountDetails
        .firstWhere((element) => element.id == entity.selectedToAccountId);
    final entityFromElement = entity.accountDetails
        .firstWhere((element) => element.id == entity.selectedFromAccountId);
    final toViewModel = AccountViewModel(
        id: entityToElement.id,
        accountBalance: entityToElement.accountBalance,
        accountName: entityToElement.accountName,
        accountType: entityToElement.accountType);
    final fromViewModel = AccountViewModel(
        id: entityFromElement.id,
        accountBalance: entityFromElement.accountBalance,
        accountName: entityFromElement.accountName,
        accountType: entityFromElement.accountType);
    return TransferPageViewModel(
        from: fromViewModel,
        to: toViewModel,
        amount: entity.amount,);
  }
}



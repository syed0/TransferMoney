import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:transfer_money/core/example_locator.dart';
import 'package:transfer_money/transfer%20funds%20page/bloc/account_details_serviceAdapter.dart';
import 'package:transfer_money/transfer%20funds%20page/bloc/submit_serviceAdapter.dart';
import 'package:transfer_money/transfer%20funds%20page/bloc/transfer_page_bloc.dart';
import 'package:transfer_money/transfer%20funds%20page/model/transfer_page_entity.dart';
import 'package:transfer_money/transfer%20funds%20page/model/transfer_page_viewModal.dart';

class TransferPageUseCase extends UseCase {
  Function(ViewModel) _accountDetailsViewModelCallBack;
  Function(ViewModel) _transferToFromViewModelCallBack;

  RepositoryScope scope;

  TransferPageUseCase(
      {Function accountDetailsViewModelCallBack,
      Function transferToFromViewModelCallBack})
      : assert(accountDetailsViewModelCallBack != null),
        _accountDetailsViewModelCallBack = accountDetailsViewModelCallBack,
        _transferToFromViewModelCallBack = transferToFromViewModelCallBack;

  void create() async {
    scope = ExampleLocator.instance.repository
        .containsScope<TransferPageEntityList>();
    if (scope == null) {
      scope = ExampleLocator.instance.repository.create<TransferPageEntityList>(
          TransferPageEntityList(), _notifySubscribers,
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

  TransferPageViewModalList buildViewModel(TransferPageEntityList entity) {
    List<TransferPageViewModal> accDetails = [];
    entity.accDetails.forEach((e) {
      if (entity.lastSelectedAccountType == AccountType.FromAccount) {
        if (!(e.id == entity.selectedToAccId)) {
          accDetails.add(TransferPageViewModal(
              id: e.id,
              accType: e.accType,
              accName: e.accName,
              accBal: e.accBal));
        }
      } else {
        if (!(e.id == entity.selectedFromAccId)) {
          accDetails.add(TransferPageViewModal(
              id: e.id,
              accType: e.accType,
              accName: e.accName,
              accBal: e.accBal));
        }
      }
    });
    return TransferPageViewModalList(accDetails: accDetails);
  }

  void selectedAccountId(String selectedId) {
    RepositoryScope scope = ExampleLocator.instance.repository
        .containsScope<TransferPageEntityList>();

    final transferRootEntity =
        ExampleLocator.instance.repository.get<TransferPageEntityList>(scope);

    if (transferRootEntity.lastSelectedAccountType == AccountType.FromAccount) {
      ExampleLocator.instance.repository.update<TransferPageEntityList>(
          scope, transferRootEntity.merge(selectedFromAccId: selectedId));
    } else {
      ExampleLocator.instance.repository.update<TransferPageEntityList>(
          scope, transferRootEntity.merge(selectedToAccId: selectedId));
    }

    _transferToFromViewModelCallBack(buildViewModelForTransferScreen(
        ExampleLocator.instance.repository.get<TransferPageEntityList>(scope)));
  }

  void updateLastSelectedAccountType(AccountType accountType) {
    RepositoryScope scope = ExampleLocator.instance.repository
        .containsScope<TransferPageEntityList>();
    if (scope == null) {
      scope = ExampleLocator.instance.repository.create<TransferPageEntityList>(
          TransferPageEntityList(), _notifySubscribers,
          deleteIfExists: true);
    }

    final transferRootEntity =
        ExampleLocator.instance.repository.get<TransferPageEntityList>(scope);

    ExampleLocator.instance.repository.update<TransferPageEntityList>(
        scope, transferRootEntity.merge(lastSelectedAccountType: accountType));
  }

  void _notifySubscribersForTransferScreen(entity) {
    _transferToFromViewModelCallBack(
        buildViewModelForTransferScreenAfterSuccess(entity));
  }

  TransferPageFromAndToViewModal buildViewModelForTransferScreenAfterSuccess(
      TransferPageEntityList entity) {
    final entityToElement = entity.accDetails
        .firstWhere((element) => element.id == entity.selectedToAccId);
    final entityFromElement = entity.accDetails
        .firstWhere((element) => element.id == entity.selectedFromAccId);
    final toViewModel = TransferPageViewModal(
        id: entityToElement.id,
        accBal: entityToElement.accBal,
        accName: entityToElement.accName,
        accType: entityToElement.accType);
    final fromViewModel = TransferPageViewModal(
        id: entityFromElement.id,
        accBal: entityFromElement.accBal,
        accName: entityFromElement.accName,
        accType: entityFromElement.accType);
    return TransferPageFromAndToViewModal(
        from: fromViewModel,
        to: toViewModel,
        amount: entity.amount,
        didSucceed: true);
  }

  TransferPageFromAndToViewModal buildViewModelForTransferScreen(
      TransferPageEntityList entity) {
    if (entity.selectedFromAccId != "" && entity.selectedToAccId != "") {
      final entityToElement = entity.accDetails
          .firstWhere((element) => element.id == entity.selectedToAccId);
      final entityFromElement = entity.accDetails
          .firstWhere((element) => element.id == entity.selectedFromAccId);
      final toViewModel = TransferPageViewModal(
          id: entityToElement.id,
          accBal: entityToElement.accBal,
          accName: entityToElement.accName,
          accType: entityToElement.accType);
      final fromViewModel = TransferPageViewModal(
          id: entityFromElement.id,
          accBal: entityFromElement.accBal,
          accName: entityFromElement.accName,
          accType: entityFromElement.accType);
      return TransferPageFromAndToViewModal(
          from: fromViewModel, to: toViewModel, amount: entity.amount);
    } else if (entity.selectedFromAccId == "" && entity.selectedToAccId == "") {
      return TransferPageFromAndToViewModal(amount: entity.amount);
    } else if (entity.selectedFromAccId == "") {
      final entityElement = entity.accDetails
          .firstWhere((element) => element.id == entity.selectedToAccId);
      final toViewModel = TransferPageViewModal(
          id: entityElement.id,
          accBal: entityElement.accBal,
          accName: entityElement.accName,
          accType: entityElement.accType);
      return TransferPageFromAndToViewModal(
          to: toViewModel, amount: entity.amount);
    } else {
      final entityFromElement = entity.accDetails
          .firstWhere((element) => element.id == entity.selectedFromAccId);
      final fromViewModel = TransferPageViewModal(
          id: entityFromElement.id,
          accBal: entityFromElement.accBal,
          accName: entityFromElement.accName,
          accType: entityFromElement.accType);
      return TransferPageFromAndToViewModal(
          from: fromViewModel, amount: entity.amount);
    }
  }

  void setTransferPageInitialState() {
    RepositoryScope scope = ExampleLocator.instance.repository
        .containsScope<TransferPageEntityList>();

    if (scope == null) {
      scope = ExampleLocator.instance.repository.create<TransferPageEntityList>(
          TransferPageEntityList(), _notifySubscribers,
          deleteIfExists: true);
    }

    _transferToFromViewModelCallBack(buildViewModelForTransferScreen(
        ExampleLocator.instance.repository.get<TransferPageEntityList>(scope)));
  }

  void updateAmount(int amount) {
    RepositoryScope scope = ExampleLocator.instance.repository
        .containsScope<TransferPageEntityList>();

    if (scope == null) {
      scope = ExampleLocator.instance.repository.create<TransferPageEntityList>(
          TransferPageEntityList(), _notifySubscribers,
          deleteIfExists: true);
    }
    final transferRootEntity =
        ExampleLocator.instance.repository.get<TransferPageEntityList>(scope);

    ExampleLocator.instance.repository.update<TransferPageEntityList>(
        scope, transferRootEntity.merge(amount: amount));

    _transferToFromViewModelCallBack(buildViewModelForTransferScreen(
        ExampleLocator.instance.repository.get<TransferPageEntityList>(scope)));
  }

  void submitBtnTapped() async {
    RepositoryScope scope = ExampleLocator.instance.repository
        .containsScope<TransferPageEntityList>();
    if (scope == null) {
      scope = ExampleLocator.instance.repository.create<TransferPageEntityList>(
          TransferPageEntityList(), _notifySubscribersForTransferScreen,
          deleteIfExists: true);
    } else {
      scope.subscription = _notifySubscribersForTransferScreen;
    }
    final transferRootEntity =
        ExampleLocator.instance.repository.get<TransferPageEntityList>(scope);
    if (transferRootEntity.selectedToAccId == '' ||
        transferRootEntity.selectedFromAccId == '' ||
        transferRootEntity.amount == 0) {
      _transferToFromViewModelCallBack(
          TransferPageFromAndToViewModal(dataError: true));
    } else {
      await ExampleLocator.instance.repository
          .runServiceAdapter(scope, SubmitServiceAdapter());
    }
  }
}

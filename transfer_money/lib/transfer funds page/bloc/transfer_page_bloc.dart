import 'package:clean_framework/clean_framework.dart';
import 'package:transfer_money/transfer%20funds%20page/api/account_details_service.dart';
import 'package:transfer_money/transfer%20funds%20page/bloc/useCase.dart';
import 'package:transfer_money/transfer%20funds%20page/model/transfer_page_viewModal.dart';

class TransferPageBloc extends Bloc {
  TransferPageUseCase _useCase;

  final Pipe<TransferPageFromAndToViewModal> selectedAccountDetails =
      Pipe<TransferPageFromAndToViewModal>(canSendDuplicateData: true);
  final Pipe<TransferPageViewModalList> accountDetails =
      Pipe<TransferPageViewModalList>(canSendDuplicateData: true);
  final Pipe<AccountType> accountType =
      Pipe<AccountType>(canSendDuplicateData: true);
  final Pipe<String> selectedAccountId =
      Pipe<String>(canSendDuplicateData: true);
  final Pipe<int> amount = Pipe<int>(canSendDuplicateData: true);

  EventPipe setTheInitialStage = EventPipe();
  EventPipe getAccountDetails = EventPipe();
  EventPipe submitTapEvent = EventPipe();

  TransferPageBloc({AccountDetailsService accountDetailsService}) {
    _useCase =
        TransferPageUseCase(accountDetailsViewModelCallBack: (viewModal) {
      accountDetails.send(viewModal);
    }, transferToFromViewModelCallBack: (viewModal) {
      selectedAccountDetails.send(viewModal);
    });
    setTheInitialStage.listen(() {
      _useCase.setTransferPageInitialState();
    });
    getAccountDetails.listen(() {
      _useCase.create();
    });
    selectedAccountId.receive.listen((selectedId) {
      _useCase.selectedAccountId(selectedId);
    });
    accountType.receive.listen((accountType) {
      _useCase.updateLastSelectedAccountType(accountType);
    });
    amount.receive.listen((amount) {
      _useCase.updateAmount(amount);
    });
    submitTapEvent.listen(() {
      _useCase.submitBtnTapped();
    });
  }

  @override
  void dispose() {
    selectedAccountDetails.dispose();
    accountDetails.dispose();
  }
}

enum AccountType { FromAccount, ToAccount }

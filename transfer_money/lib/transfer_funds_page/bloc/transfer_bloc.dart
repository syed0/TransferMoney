import 'package:clean_framework/clean_framework.dart';
import 'package:transfer_money/transfer_funds_page/api/account_details_service.dart';
import 'package:transfer_money/transfer_funds_page/bloc/transfer_use_case.dart';
import 'package:transfer_money/transfer_funds_page/view_model/account_list_view_model.dart';
import 'package:transfer_money/transfer_funds_page/view_model/transfer_page_view_model.dart';


class TransferPageBloc extends Bloc {
  TransferPageUseCase _useCase;

  final Pipe<TransferPageViewModel> selectedAccountDetails =
      Pipe<TransferPageViewModel>(canSendDuplicateData: true);
  final Pipe<AccountListViewModel> accountDetails =
      Pipe<AccountListViewModel>(canSendDuplicateData: true);
  final Pipe<AccountType> accountType =
      Pipe<AccountType>(canSendDuplicateData: true);
  final Pipe<String> selectedAccountId =
      Pipe<String>(canSendDuplicateData: true);
  final Pipe<double> amount = Pipe<double>(canSendDuplicateData: true);
  final Pipe<TransferPageViewModel> successfulPageAccountDetails =
  Pipe<TransferPageViewModel>(canSendDuplicateData: true);

  EventPipe setTheInitialStage = EventPipe();
  EventPipe getAccountDetails = EventPipe();
  EventPipe submitTapEvent = EventPipe();
  EventPipe submitPageEvent = EventPipe();

  TransferPageBloc({AccountDetailsService accountDetailsService}) {
    _useCase =
        TransferPageUseCase(accountDetailsViewModelCallBack: (viewModel) {
      accountDetails.send(viewModel);
    }, transferToFromViewModelCallBack: (viewModel) {
      selectedAccountDetails.send(viewModel);
    },
        successPageViewModelCallBack: (viewModel){
          successfulPageAccountDetails.send(viewModel);
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
    submitPageEvent.listen(() {
      _useCase.getDataForSuccessPage();
    });
  }

  @override
  void dispose() {
    selectedAccountDetails.dispose();
    accountDetails.dispose();
  }
}

enum AccountType { FromAccount, ToAccount }

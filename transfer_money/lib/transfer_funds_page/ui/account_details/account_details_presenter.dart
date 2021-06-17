import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transfer_money/transfer_funds_page/bloc/transfer_bloc.dart';
import 'package:transfer_money/transfer_funds_page/view_model/account_list_view_model.dart';
import 'account_details_screen.dart';

class AccountDetailsPresenter extends Presenter<TransferPageBloc,
    AccountListViewModel, AccountDetailsScreen> {
  @override
  AccountDetailsScreen buildScreen(BuildContext context, TransferPageBloc bloc,
      AccountListViewModel viewModel) {
    return AccountDetailsScreen(
      context: context,
      viewModal: viewModel,
      onTap: (selectedId) {
        bloc.selectedAccountId.send(selectedId);
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildLoadingScreen(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Stream<AccountListViewModel> getViewModelStream(TransferPageBloc bloc) {
    return bloc.accountDetails.receive;
  }

  void sendViewModelRequest(TransferPageBloc bloc) {
    bloc.getAccountDetails.launch();
  }
}

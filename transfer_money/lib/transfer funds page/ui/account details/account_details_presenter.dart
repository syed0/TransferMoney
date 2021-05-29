import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transfer_money/transfer%20funds%20page/bloc/transfer_page_bloc.dart';
import 'package:transfer_money/transfer%20funds%20page/model/transfer_page_viewModal.dart';

import 'account_details_screen.dart';

class AccountDetailsPresenter extends Presenter<TransferPageBloc,
    TransferPageViewModalList, AccountDetailsScreen> {
  @override
  AccountDetailsScreen buildScreen(BuildContext context, TransferPageBloc bloc,
      TransferPageViewModalList viewModel) {
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
  Stream<TransferPageViewModalList> getViewModelStream(TransferPageBloc bloc) {
    return bloc.accountDetails.receive;
  }

  void sendViewModelRequest(TransferPageBloc bloc) {
    bloc.getAccountDetails.launch();
  }
}

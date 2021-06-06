import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:transfer_money/transfer%20funds%20page/bloc/transfer_page_bloc.dart';
import 'package:transfer_money/transfer%20funds%20page/model/transfer_page_viewModal.dart';
import 'package:transfer_money/transfer%20funds%20page/ui/submit_success/submit_success_page.dart';
import 'package:transfer_money/transfer%20funds%20page/ui/transfer_page_screen.dart';

import 'account details/account_details_widget.dart';

class TransferPagePresenter extends Presenter<TransferPageBloc,
    TransferPageFromAndToViewModal, TransferPageScreen> {
  @override
  TransferPageScreen buildScreen(BuildContext context, TransferPageBloc bloc,
      TransferPageFromAndToViewModal viewModel) {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      if (viewModel.dataError) {
        _showErrorDialog(context);
      }
      if (viewModel.didSucceed) {
        Navigator.push(context,
            new MaterialPageRoute(builder: (context) => SubmitSuccessPage()));
      }
    });

    return TransferPageScreen(
      context: context,
      viewModal: viewModel,
      onTap: (accountType) {
        bloc.accountType.send(accountType);
        Navigator.push(
            context,
            new MaterialPageRoute(
                builder: (context) => AccountDetailsWidget()));
      },
      onAmountTap: (amount) {
        bloc.amount.send(amount);
      },
      onCancelTap: () => Navigator.pop(context),
      onSubmitTap: () => bloc.submitTapEvent.launch(),
    );
  }
  @override
  Widget buildLoadingScreen(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  @override
  Stream<TransferPageFromAndToViewModal> getViewModelStream(
      TransferPageBloc bloc) {
    return bloc.selectedAccountDetails.receive;
  }

  void sendViewModelRequest(TransferPageBloc bloc) {
    bloc.setTheInitialStage.launch();
  }

  void _showErrorDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Text('Submit Failed'),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          )
        ],
      ),
    );
  }
}

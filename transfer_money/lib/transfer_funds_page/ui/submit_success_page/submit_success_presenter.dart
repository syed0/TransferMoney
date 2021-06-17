import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transfer_money/transfer_funds_page/bloc/transfer_bloc.dart';
import 'package:transfer_money/transfer_funds_page/ui/submit_success_page/submit_success_screen.dart';
import 'package:transfer_money/transfer_funds_page/view_model/transfer_page_view_model.dart';

class SubmitSuccessPagePresenter extends Presenter<TransferPageBloc,
    TransferPageViewModel, SubmitSuccessPage>{
  @override
  SubmitSuccessPage buildScreen(BuildContext context, TransferPageBloc bloc, TransferPageViewModel viewModel) {
    return SubmitSuccessPage(context: context, viewModal: viewModel,);
  }

  @override
  Stream<TransferPageViewModel> getViewModelStream(TransferPageBloc bloc) {
    return bloc.successfulPageAccountDetails.receive;
  }

  @override
  Widget buildLoadingScreen(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  void sendViewModelRequest(TransferPageBloc bloc) {
    bloc.submitPageEvent.launch();
  }
}
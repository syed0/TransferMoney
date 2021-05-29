import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transfer_money/transfer%20funds%20page/bloc/transfer_page_bloc.dart';
import 'package:transfer_money/transfer%20funds%20page/ui/transfer_page_presenter.dart';

class TransferPageWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TransferPagePresenter();
  }
}

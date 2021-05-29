import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/services.dart';
import 'package:transfer_money/transfer%20funds%20page/bloc/transfer_page_bloc.dart';

class TransferPageEntity extends Entity {
  TransferPageEntity({this.id, this.accBal, this.accName, this.accType});
  final String id;
  final String accName;
  final double accBal;
  final String accType;
}

class TransferPageEntityList extends Entity {
  final List<TransferPageEntity> accDetails;
  final String selectedFromAccId;
  final String selectedToAccId;
  final AccountType lastSelectedAccountType;
  final int amount;
  final bool didSucceed;

  @override
  TransferPageEntityList(
      {List<EntityFailure> errors = const [],
      this.accDetails = const [],
      this.selectedFromAccId = '',
      this.selectedToAccId = '',
      this.lastSelectedAccountType,
      this.amount,
      this.didSucceed});

  @override
  TransferPageEntityList merge(
      {errors,
      List<TransferPageEntity> accDetails,
      String selectedFromAccId,
      String selectedToAccId,
      AccountType lastSelectedAccountType,
      int amount,
      bool didSucceed}) {
    return TransferPageEntityList(
        errors: errors ?? this.errors,
        accDetails: accDetails ?? this.accDetails,
        selectedFromAccId: selectedFromAccId ?? this.selectedFromAccId,
        selectedToAccId: selectedToAccId ?? this.selectedToAccId,
        lastSelectedAccountType:
            lastSelectedAccountType ?? this.lastSelectedAccountType,
        amount: amount ?? this.amount,
        didSucceed: didSucceed ?? this.didSucceed);
  }
}

import 'package:clean_framework/clean_framework.dart';
import 'package:transfer_money/transfer_funds_page/bloc/transfer_bloc.dart';
import 'account_entity.dart';

class AccountRootEntity extends Entity {
  final List<AccountEntity> accountDetails;
  final String selectedFromAccountId;
  final String selectedToAccountId;
  final AccountType lastSelectedAccountType;
  final double amount;
  final bool didSucceed;

  @override
  AccountRootEntity(
      {List<EntityFailure> errors = const [],
      this.accountDetails = const [],
      this.selectedFromAccountId = '',
      this.selectedToAccountId = '',
      this.lastSelectedAccountType,
      this.amount = 0.0,
      this.didSucceed = false});

  @override
  AccountRootEntity merge(
      {errors,
      List<AccountEntity> accDetails,
      String selectedFromAccId,
      String selectedToAccId,
      AccountType lastSelectedAccountType,
      double amount,
      bool didSucceed}) {
    return AccountRootEntity(
        errors: errors ?? this.errors,
        accountDetails: accDetails ?? this.accountDetails,
        selectedFromAccountId: selectedFromAccId ?? this.selectedFromAccountId,
        selectedToAccountId: selectedToAccId ?? this.selectedToAccountId,
        lastSelectedAccountType:
            lastSelectedAccountType ?? this.lastSelectedAccountType,
        amount: amount ?? this.amount,
        didSucceed: didSucceed ?? this.didSucceed);
  }
}

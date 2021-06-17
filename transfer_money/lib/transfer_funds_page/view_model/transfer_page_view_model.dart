import 'package:clean_framework/clean_framework.dart';

import 'account_view_model.dart';

class TransferPageViewModel extends ViewModel {
  final AccountViewModel from;
  final AccountViewModel to;
  final double amount;
  final bool dataError;
  final bool didSucceed;

  TransferPageViewModel(
      {this.from ,
      this.to ,
      this.amount = 0.0,
      this.didSucceed = false,
      this.dataError = false});


  @override
  List<Object> get props => [from, to];
}

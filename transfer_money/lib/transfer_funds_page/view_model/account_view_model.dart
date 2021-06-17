import 'package:clean_framework/clean_framework.dart';

class AccountViewModel extends ViewModel {
  final String id;
  final String accountName;
  final double accountBalance;
  final String accountType;
  AccountViewModel({this.id = '', this.accountBalance = 0.0, this.accountName = '', this.accountType = ''});
  @override
  List<Object> get props => [id, accountType, accountName, accountBalance];
}
import 'package:clean_framework/clean_framework.dart';

class AccountEntity extends Entity {
  AccountEntity({this.id, this.accountBalance, this.accountName, this.accountType});
  final String id;
  final String accountName;
  final double accountBalance;
  final String accountType;
}
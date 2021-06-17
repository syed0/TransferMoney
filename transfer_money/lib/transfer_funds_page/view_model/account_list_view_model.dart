import 'package:clean_framework/clean_framework.dart';

import 'account_view_model.dart';

class AccountListViewModel extends ViewModel {
  final List<AccountViewModel> accountDetails;

  AccountListViewModel({this.accountDetails = const []});

  @override
  List<Object> get props => [accountDetails];
}
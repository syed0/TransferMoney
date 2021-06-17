import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/src/defaults/json_service.dart';
import 'package:transfer_money/transfer_funds_page/api/account_details_response_model.dart';
import 'package:transfer_money/transfer_funds_page/api/account_details_service.dart';
import 'package:transfer_money/transfer_funds_page/entity/account_entity.dart';
import 'package:transfer_money/transfer_funds_page/entity/account_root_entity.dart';


class AccountDetailsServiceAdapter extends ServiceAdapter<
    AccountRootEntity,
    JsonRequestModel,
    AccountDetailsRespModelList,
    AccountDetailsService> {
  AccountDetailsServiceAdapter() : super(AccountDetailsService());
  @override
  AccountRootEntity createEntity(AccountRootEntity initialEntity,
      AccountDetailsRespModelList responseModel) {
    List<AccountEntity> accList = [];

    responseModel.accDetails.forEach((element) {
      accList.add(AccountEntity(
          id: element.id,
          accountBalance: element.accBal,
          accountName: element.accName,
          accountType: element.accType));
    });
    return initialEntity.merge(accDetails: accList);
  }
}

import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/src/defaults/json_service.dart';
import 'package:transfer_money/transfer%20funds%20page/api/account_details_responseModel.dart';
import 'package:transfer_money/transfer%20funds%20page/api/account_details_service.dart';
import 'package:transfer_money/transfer%20funds%20page/model/transfer_page_entity.dart';

class AccountDetailsServiceAdapter extends ServiceAdapter<
    TransferPageEntityList,
    JsonRequestModel,
    AccountDetailsRespModelList,
    AccountDetailsService> {
  AccountDetailsServiceAdapter() : super(AccountDetailsService());
  @override
  TransferPageEntityList createEntity(TransferPageEntityList initialEntity,
      AccountDetailsRespModelList responseModel) {
    List<TransferPageEntity> accList = [];

    responseModel.accDetails.forEach((element) {
      accList.add(TransferPageEntity(
          id: element.id,
          accBal: element.accBal,
          accName: element.accName,
          accType: element.accType));
    });
    return initialEntity.merge(accDetails: accList);
  }
}

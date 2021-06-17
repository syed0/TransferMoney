import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:transfer_money/transfer_funds_page/api/submit_request_model.dart';
import 'package:transfer_money/transfer_funds_page/api/submit_response_model.dart';
import 'package:transfer_money/transfer_funds_page/api/submit_service.dart';
import 'package:transfer_money/transfer_funds_page/entity/account_root_entity.dart';


class SubmitServiceAdapter extends ServiceAdapter<AccountRootEntity,
    SubmitRequestModel, SubmitResponseModel, SubmitService> {
  SubmitServiceAdapter() : super(SubmitService());
  @override
  AccountRootEntity createEntity(
      AccountRootEntity initialEntity, SubmitResponseModel responseModel) {
    return initialEntity.merge(didSucceed: responseModel.didSucceed);
  }
  @override
  SubmitRequestModel createRequest(AccountRootEntity entity) {
    return SubmitRequestModel(fromAccountId: entity.selectedFromAccountId, toAccountId: entity.selectedToAccountId,amount: entity.amount);
  }
}

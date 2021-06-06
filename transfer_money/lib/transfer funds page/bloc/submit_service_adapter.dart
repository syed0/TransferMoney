import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:transfer_money/transfer%20funds%20page/api/submit_response_model.dart';
import 'package:transfer_money/transfer%20funds%20page/api/submit_service.dart';
import 'package:transfer_money/transfer%20funds%20page/model/transfer_page_entity.dart';

class SubmitServiceAdapter extends ServiceAdapter<TransferPageEntityList,
    JsonRequestModel, SubmitResponseModel, SubmitService> {
  SubmitServiceAdapter() : super(SubmitService());
  @override
  TransferPageEntityList createEntity(
      TransferPageEntityList initialEntity, SubmitResponseModel responseModel) {
    return initialEntity.merge(didSucceed: responseModel.didSucceed);
  }
}

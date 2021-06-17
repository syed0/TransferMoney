import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:transfer_money/core/example_locator.dart';
import 'package:transfer_money/transfer_funds_page/api/submit_request_model.dart';
import 'package:transfer_money/transfer_funds_page/api/submit_response_model.dart';

class SubmitService
    extends EitherService<SubmitRequestModel, SubmitResponseModel> {
  SubmitService()
      : super(
          method: RestMethod.post,
          restApi: ExampleLocator().api,
          path: 'submit/:{fromAccountId}/:{toAccountId}/:{amount}',
        );

  @override
  SubmitResponseModel parseResponse(Map<String, dynamic> jsonResponse) {
    return SubmitResponseModel.fromJson(jsonResponse);
  }
}

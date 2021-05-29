import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:transfer_money/core/example_locator.dart';
import 'package:transfer_money/transfer%20funds%20page/api/submit_responseModel.dart';

class SubmitService
    extends EitherService<JsonRequestModel, SubmitResponseModel> {
  SubmitService()
      : super(
          method: RestMethod.post,
          restApi: ExampleLocator().api,
          path: 'submit',
        );

  @override
  SubmitResponseModel parseResponse(Map<String, dynamic> jsonResponse) {
    return SubmitResponseModel.fromJson(jsonResponse);
  }
}

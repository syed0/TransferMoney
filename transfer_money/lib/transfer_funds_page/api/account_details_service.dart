import 'package:clean_framework/clean_framework.dart';
import 'package:clean_framework/clean_framework_defaults.dart';
import 'package:transfer_money/core/example_locator.dart';

import 'account_details_response_model.dart';

class AccountDetailsService
    extends EitherService<JsonRequestModel, AccountDetailsRespModelList> {
  AccountDetailsService()
      : super(
          method: RestMethod.get,
          restApi: ExampleLocator().api,
          path: 'accounts',
        );

  @override
  AccountDetailsRespModelList parseResponse(Map<String, dynamic> jsonResponse) {
    return AccountDetailsRespModelList.fromJson(jsonResponse);
  }
}

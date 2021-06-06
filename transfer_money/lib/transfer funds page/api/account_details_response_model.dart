import 'package:clean_framework/clean_framework_defaults.dart';

class AccountDetailsRespModel extends JsonResponseModel {
  final String id;
  final String accName;
  final double accBal;
  final String accType;

  AccountDetailsRespModel.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        accName = json['name'] ?? '',
        accBal = json['balance'] ?? 0.0,
        accType = json['type'] ?? '';

  @override
  List<Object> get props => [];
}

class AccountDetailsRespModelList extends JsonResponseModel {
  final List<AccountDetailsRespModel> accDetails;

  AccountDetailsRespModelList.fromJson(Map<String, dynamic> json)
      : accDetails = _getList(json['accounts'] ?? []);

  static List<AccountDetailsRespModel> _getList(List values) {
    return values.map((e) => AccountDetailsRespModel.fromJson(e)).toList();
  }

  @override
  List<Object> get props => [];
}

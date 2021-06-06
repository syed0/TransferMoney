import 'package:clean_framework/clean_framework_defaults.dart';

class SubmitResponseModel extends JsonResponseModel {
  @override
  List<Object> get props => [];

  final bool didSucceed;

  SubmitResponseModel.fromJson(Map<String, dynamic> json)
      : didSucceed = json["didSucceed"];
}

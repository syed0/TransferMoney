import 'package:clean_framework/clean_framework_defaults.dart';

class SubmitRequestModel extends JsonRequestModel{
  final String fromAccountId;
  final String toAccountId;
  final double amount;


  SubmitRequestModel({this.fromAccountId,this.toAccountId,this.amount});

  @override
  Map<String, dynamic> toJson() {
    return {"fromAccountId" : fromAccountId,
      "toAccountId" : toAccountId,
      "amount" : amount};
  }
}
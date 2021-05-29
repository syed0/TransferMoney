import 'package:clean_framework/clean_framework.dart';

class TransferPageViewModal extends ViewModel {
  TransferPageViewModal({this.id, this.accBal, this.accName, this.accType});
  final String id;
  final String accName;
  final double accBal;
  final String accType;
  @override
  List<Object> get props => [id, accType, accName, accBal];
}

class TransferPageViewModalList extends ViewModel {
  TransferPageViewModalList({this.accDetails});
  final List<TransferPageViewModal> accDetails;
  @override
  List<Object> get props => [accDetails];
}

class TransferPageFromAndToViewModal extends ViewModel {
  TransferPageFromAndToViewModal(
      {this.from,
      this.to,
      this.amount = 0,
      this.didSucceed = false,
      this.dataError = false});
  final TransferPageViewModal from;
  final TransferPageViewModal to;
  final int amount;
  final bool dataError;
  final bool didSucceed;

  @override
  // TODO: implement props
  List<Object> get props => [from, to];
}

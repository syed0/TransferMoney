import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:transfer_money/transfer_funds_page/view_model/transfer_page_view_model.dart';

class SubmitSuccessPage extends Screen {
  final TransferPageViewModel viewModal;
  final BuildContext context;

  SubmitSuccessPage({this.context,this.viewModal});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'Funds Transferred Successfully',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Container(
          child: Center(
            child: Column(children: [
              Text(
                ' SuccessFully transferred ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Text(
                '${viewModal.amount}',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
        Text(
            'from ${viewModal.from.accountName} to ${viewModal.to.accountName}',
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
        ),
        TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();

              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey.shade300,
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0)),
              ),
              child: Text("Ok",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              )
        ),
      ]),
          )),
    );
  }
}

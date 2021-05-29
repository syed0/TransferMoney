import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transfer_money/transfer%20funds%20page/bloc/transfer_page_bloc.dart';
import 'package:transfer_money/transfer%20funds%20page/model/transfer_page_viewModal.dart';

class TransferPageScreen extends Screen {
  final TransferPageFromAndToViewModal viewModal;
  final BuildContext context;
  final Function onTap;
  final Function onAmountTap;
  final Function onSubmitTap;
  final Function onCancelTap;

  TransferPageScreen(
      {this.context,
      this.viewModal,
      this.onTap,
      this.onAmountTap,
      this.onCancelTap,
      this.onSubmitTap});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Transfer Funds',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
      body: Column(
        children: [
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              "From",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
              ),
            ),
            TextField(
              readOnly: true,
              decoration: InputDecoration(
                  hintText: viewModal.from == null
                      ? 'Select the account'
                      : viewModal.from.accName,
                  border: InputBorder.none),
              textAlign: TextAlign.center,
              onTap: () {
                onTap(AccountType.FromAccount);
              },
            ),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "To",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              TextField(
                readOnly: true,
                decoration: InputDecoration(
                    hintText: viewModal.to == null
                        ? 'Select the account'
                        : viewModal.to.accName,
                    border: InputBorder.none),
                textAlign: TextAlign.center,
                onTap: () {
                  onTap(AccountType.ToAccount);
                },
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Amount",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                ),
              ),
              Row(
                children: [
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          viewModal.amount == 5 ? Colors.grey : Colors.white,
                    ),
                    onPressed: () {
                      onAmountTap(5);
                    },
                    child: Text(
                      "Rs 5",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          viewModal.amount == 10 ? Colors.grey : Colors.white,
                    ),
                    onPressed: () {
                      onAmountTap(10);
                    },
                    child: Text(
                      "Rs 10",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor:
                          viewModal.amount == 15 ? Colors.grey : Colors.white,
                    ),
                    onPressed: () {
                      onAmountTap(15);
                    },
                    child: Text(
                      "Rs 15",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  onSubmitTap();
                },
                child: Text(
                  "Submit",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  onCancelTap();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

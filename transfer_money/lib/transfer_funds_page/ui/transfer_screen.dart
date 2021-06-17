import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transfer_money/transfer_funds_page/bloc/transfer_bloc.dart';
import 'package:transfer_money/transfer_funds_page/view_model/transfer_page_view_model.dart';

class TransferPageScreen extends Screen {
  final TransferPageViewModel viewModal;
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        fixedColor: Colors.black,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.arrow_forward,
                color: Colors.black,
              ),
              label: "Submit"),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.cancel,
              color: Colors.black,
            ),
            label: "Cancel",
          ),
        ],
        onTap: (selectedItem) {
          if (selectedItem == 0) {
            onSubmitTap();
          } else {
            onCancelTap();
          }
        },
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
            Padding(
              padding:
                  const EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
              child: Text(
                "From",
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10.0),
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  suffixIcon: Icon(Icons.arrow_drop_down),
                  hintText: viewModal.from == null
                      ? 'Select the account'
                      : viewModal.from.accountName,
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                ),
                textAlign: TextAlign.start,
                onTap: () {
                  onTap(AccountType.FromAccount);
                },
              ),
            ),
          ]),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
                child: Text(
                  "To",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.arrow_drop_down),
                    hintText: viewModal.to == null
                        ? 'Select the account'
                        : viewModal.to.accountName,
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                  textAlign: TextAlign.start,
                  onTap: () {
                    onTap(AccountType.ToAccount);
                  },
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10.0, top: 12.0),
                child: Text(
                  "Amount",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: TextField(
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: viewModal.amount == 0.0
                        ? 'Enter Amount'
                        : viewModal.amount.toString(),
                    focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey)),
                  ),
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    onAmountTap(double.parse(value));
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

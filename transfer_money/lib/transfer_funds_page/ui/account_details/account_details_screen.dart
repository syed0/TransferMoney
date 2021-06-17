import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:transfer_money/transfer_funds_page/view_model/account_list_view_model.dart';

class AccountDetailsScreen extends Screen {
  final AccountListViewModel viewModal;
  final BuildContext context;
  final Function onTap;
  AccountDetailsScreen({this.context, this.viewModal, this.onTap});

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
      body: ListView.builder(
        itemCount: viewModal.accountDetails.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.all(2.0),
            child: InkWell(
              onTap: () {
                onTap(viewModal.accountDetails[index].id);
              },
              child: ListTile(
                tileColor: Colors.grey.shade300,
                title: Text(
                  "${viewModal.accountDetails[index].accountName}-${viewModal.accountDetails[index].accountType}",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.0,
                  ),
                ),
                subtitle: Text(
                  "${viewModal.accountDetails[index].accountBalance}",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward),
              ),
            ),
          );
        },
      ),
    );
  }
}

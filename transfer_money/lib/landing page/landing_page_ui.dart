import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:transfer_money/transfer%20funds%20page/ui/transfer_page_widget.dart';

class LandingPage extends StatelessWidget {
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
      body: Center(
          child: Column(children: [
        Text(
          'Welcome',
          style: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
        ),
        TextButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => TransferPageWidget()));
            },
            child: Text("Transfer Funds")),
      ])),
    );
  }
}

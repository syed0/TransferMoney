import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../transfer_widget.dart';

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
        child: TextButton(
          onPressed: () {
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => TransferPageWidget()));
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(30.0)),
          ),

          child: Text(
            " Continue ",
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}

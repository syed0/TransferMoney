import 'package:flutter/material.dart';

class SubmitSuccessPage extends StatelessWidget {
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
          'SuccessFully Done',
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
            child: Text("Ok")),
      ])),
    );
  }
}

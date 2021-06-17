import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:transfer_money/transfer_funds_page/bloc/transfer_bloc.dart';
import 'package:transfer_money/transfer_funds_page/ui/landing_page/landing_page_ui.dart';

void main() {
  runApp(BlocProvider(
    child: MyHomePage(),
    create: (_) => TransferPageBloc(),
  ));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.grey.shade500,
      ),
      home: LandingPage(),
    );
  }
}

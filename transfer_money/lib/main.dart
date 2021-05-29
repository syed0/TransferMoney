import 'package:clean_framework/clean_framework.dart';
import 'package:flutter/material.dart';
import 'package:transfer_money/landing%20page/landing_page_ui.dart';
import 'package:transfer_money/transfer%20funds%20page/bloc/transfer_page_bloc.dart';

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
      home: LandingPage(),
    );
  }
}

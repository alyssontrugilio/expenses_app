import 'package:flutter/material.dart';

import 'home/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'ExpensesApp',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            useMaterial3: true,
            primaryColor: Colors.blueGrey,
            brightness: Brightness.dark,
            fontFamily: 'Quicksand'),
        home: const MyHomePage());
  }
}

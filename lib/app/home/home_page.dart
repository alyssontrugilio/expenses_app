import 'package:flutter/material.dart';

import '../components/transaction_user.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        centerTitle: true,
        title: const Text(
          'Expenses APP',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Container(
                width: double.infinity,
                color: Colors.amber,
                child: const Text(
                  'Grafico',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ),
            const TransactionUser()
          ],
        ),
      ),
    );
  }
}

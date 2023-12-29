import 'dart:math';

import 'package:expenses_ap/app/components/chart.dart';
import 'package:flutter/material.dart';

import '../components/transaction_form.dart';
import '../components/transaction_list.dart';
import '../models/transaction.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];
  bool _showChart = true;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  get label => null;

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.pop(context);
  }

  _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere(
        (tr) => tr.id == id,
      );
    });
  }

  _deleAllTransaction() {
    setState(() {
      _transactions.clear();
    });
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransactionForm(
            _addTransaction,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery =  MediaQuery.of(context);
    bool isLandscape =
        mediaQuery.orientation == Orientation.landscape;

    final appBar = AppBar(
      backgroundColor: Theme.of(context).primaryColor,
      centerTitle: true,
      title: Text(
        'Expenses APP',
        style: TextStyle(
            fontSize: 20 * mediaQuery.textScaleFactor,
            fontWeight: FontWeight.bold),
      ),
      actions: [
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _showChart = !_showChart;
              });
            },
            icon: Icon(
              _showChart ? Icons.list_alt : Icons.show_chart,
            ),
          ),
        IconButton(
          onPressed: () => _openTransactionFormModal(context),
          icon: const Icon(
            Icons.add,
          ),
        ),
      ],
    );
    final avaibleHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'Seu zé',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15 * mediaQuery.textScaleFactor,
                ),
              ),
              accountEmail: Text(
                'seuze@email.com',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15 * mediaQuery.textScaleFactor,
                ),
              ),
              currentAccountPicture:
                  const CircleAvatar(child: Icon(Icons.person)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      TextButton.icon(
                        onPressed: () => _deleAllTransaction(),
                        icon: const Icon(Icons.playlist_remove_outlined),
                        label: Text(
                          'Remover todas as transações',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize:
                                15 * mediaQuery.textScaleFactor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // if (isLandscape)
            //   Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Switch(
            //         value: _showChart,
            //         onChanged: (value) {
            //           setState(() {
            //             _showChart = !_showChart;
            //           });
            //         },
            //       ),
            //       Text(
            //         'Exibir o gráfico',
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             color: Theme.of(context).primaryColor,
            //             fontSize: 20),
            //       )
            //     ],
            //   ),
            if (_showChart || !isLandscape)
              SizedBox(
                height: avaibleHeight * (isLandscape ? 0.8 : 0.30),
                child: Chart(_recentTransactions),
              ),

            SizedBox(
              height: avaibleHeight * (isLandscape ? 1 : 0.7),
              child: TransactionList(_transactions, _deleteTransaction),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _openTransactionFormModal(context),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

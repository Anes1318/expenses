import 'dart:isolate';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/inputFields.dart';
import 'package:expenses/components/transactionList.dart';
import 'package:expenses/klase/transaction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.indigo),
      title: 'Expenses',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> transactions = [
    // Transaction(id: 't1', title: 'Mis', amount: 69, date: DateTime.now()),
    // Transaction(id: 't2', title: 'Slusalice', amount: 40, date: DateTime.now())
  ];

  List<Transaction> get recentTransactions {
    return transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addTransaction(String title, double amount, DateTime selectedDate) {
    final novaTransaction = Transaction(
      id: DateTime.now().toString(),
      title: title,
      amount: amount,
      date: selectedDate,
    );

    setState(() {
      transactions.add(novaTransaction);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      transactions.removeWhere((element) => element.id == id);
    });
  }

  void _showModal(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (bCtx) {
          return InputFields(funkcija: _addTransaction);
        });
  }

  bool showChart = false;
  final appBar = AppBar(
    title: Text('Expenses'),
  );

  @override
  Widget build(BuildContext context) {
    final orijentacija = MediaQuery.of(context).orientation;
    final txList = Container(
      height: (MediaQuery.of(context).size.height -
              appBar.preferredSize.height -
              MediaQuery.of(context).padding.top) *
          0.8,
      child: TransactionList(transactions, _deleteTransaction),
    );
    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showModal(context),
        child: Icon(
          Icons.add,
        ),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              if (orijentacija == Orientation.landscape)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Show chart',
                      style: TextStyle(fontSize: 18),
                    ),
                    Switch(
                        value: showChart,
                        onChanged: (value) {
                          setState(() {
                            showChart = value;
                          });
                        }),
                  ],
                ),
              if (orijentacija != Orientation.landscape)
                Container(
                  height: (MediaQuery.of(context).size.height -
                          appBar.preferredSize.height -
                          MediaQuery.of(context).padding.top) *
                      0.3,
                  child: Chart(recentTransactions: recentTransactions),
                ),
              if (orijentacija != Orientation.landscape) txList,
              if (orijentacija == Orientation.landscape)
                (showChart)
                    ? Container(
                        height: (MediaQuery.of(context).size.height -
                                appBar.preferredSize.height -
                                MediaQuery.of(context).padding.top) *
                            0.7,
                        child: Chart(recentTransactions: recentTransactions),
                      )
                    : txList,
            ],
          ),
        ),
      ),
    );
  }
}

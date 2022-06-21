// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_const_constructors_in_immutables
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import './models/transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/new_transaction.dart';
import './widgets/chart.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    final ThemeData theme = ThemeData(
      primarySwatch: Colors.green,
      fontFamily: 'Quicksand',
      textTheme: ThemeData.light().textTheme.copyWith(
            bodyText2: TextStyle(),
            headline6: TextStyle(
              fontFamily: 'OpenSans',
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
      appBarTheme: AppBarTheme(
        titleTextStyle: TextStyle(
          fontFamily: 'OpenSans',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
    return MaterialApp(
      title: 'Flutter Expense Manager',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(secondary: Colors.cyan),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [
    Transaction(
      id: 'A1',
      title: 'Food Order',
      amount: 10,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 'A2',
      title: 'Laptop Stand',
      amount: 24.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 'A3',
      title: 'Education',
      amount: 19.99,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 'A1',
      title: 'Food Order',
      amount: 10,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 'A2',
      title: 'Laptop Stand',
      amount: 24.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 'A3',
      title: 'Education',
      amount: 19.99,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 'A1',
      title: 'Food Order',
      amount: 10,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 'A2',
      title: 'Laptop Stand',
      amount: 24.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 'A3',
      title: 'Education',
      amount: 19.99,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
    Transaction(
      id: 'A1',
      title: 'Food Order',
      amount: 10,
      date: DateTime.now().subtract(Duration(days: 1)),
    ),
    Transaction(
      id: 'A2',
      title: 'Laptop Stand',
      amount: 24.99,
      date: DateTime.now().subtract(Duration(days: 3)),
    ),
    Transaction(
      id: 'A3',
      title: 'Education',
      amount: 19.99,
      date: DateTime.now().subtract(Duration(days: 4)),
    ),
  ];
  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(Duration(days: 7)),
      );
    }).toList();
  }

  void _addNewTransactions(String txTitle, double txAmount, DateTime txDate) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: txDate,
    );

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (_) {
        return NewTransaction(_addNewTransactions);
      },
    );
  }

  void _deleteTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tx) => tx.id == id);
    });
  }

  List<Widget> _buildLandscapeContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
  ) {
    return [
      SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Show Chart"),
            Switch.adaptive(
                value: _showChart,
                onChanged: (val) {
                  setState(() {
                    _showChart = val;
                  });
                }),
          ],
        ),
      ),
      _showChart
          ? SizedBox(
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.9,
              child: Chart(_recentTransactions),
            )
          : txListWidget,
    ];
  }

  List<Widget> _buildPortraitContent(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget txListWidget,
  ) {
    return [
      SizedBox(
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(_recentTransactions),
      ),
      txListWidget,
    ];
  }

  PreferredSizeWidget _buildIosAppBar() {
    return CupertinoNavigationBar(
      middle: Text(
        'Personal Expenses',
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          GestureDetector(
            child: Icon(CupertinoIcons.add),
            onTap: () => _startAddNewTransaction(context),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAndroidAppBar() {
    return AppBar(
      title: Text(
        'Personal Expenses',
      ),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          onPressed: () => _startAddNewTransaction(context),
        ),
      ],
    );
  }

  @override
  Widget build(context) {
    final MediaQueryData mediaQuery = MediaQuery.of(context);
    final bool _isLandscape = mediaQuery.orientation == Orientation.landscape;

    final PreferredSizeWidget appBar =
        Platform.isIOS ? _buildIosAppBar() : _buildAndroidAppBar();

    // final AppBar appBar = AppBar(
    //   title: const Text('Expense Manager'),
    //   actions: [
    //     IconButton(
    //       icon: Icon(Icons.add),
    //       onPressed: () => _startAddNewTransaction(context),
    //     )
    //   ],
    // );

    final txListWidget = SizedBox(
      height: (mediaQuery.size.height -
              appBar.preferredSize.height -
              mediaQuery.padding.top) *
          (_isLandscape ? 0.9 : 0.7),
      child: TransactionList(_transactions, _deleteTransaction),
    );

    return Scaffold(
      appBar: appBar,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            if (_isLandscape)
              ..._buildLandscapeContent(
                mediaQuery,
                appBar as AppBar,
                txListWidget,
              ),
            if (!_isLandscape)
              ..._buildPortraitContent(
                mediaQuery,
                appBar as AppBar,
                txListWidget,
              ),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}

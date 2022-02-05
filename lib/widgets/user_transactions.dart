// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../models/transaction.dart';

import './new_transaction.dart';
import './transaction_list.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
  final List<Transaction> _userTransactions = [
    Transaction(
      id: 'A1',
      title: 'Food Order',
      amount: 10,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'A2',
      title: 'Laptop Stand',
      amount: 24.99,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'A3',
      title: 'Education',
      amount: 19.99,
      date: DateTime.now(),
    ),
  ];

  void _addNewTransactions(String txTitle, double txAmount) {
    final newTx = Transaction(
      id: DateTime.now().toString(),
      title: txTitle,
      amount: txAmount,
      date: DateTime.now(),
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransactions),
        TransactionList(_userTransactions),
      ],
    );
  }
}

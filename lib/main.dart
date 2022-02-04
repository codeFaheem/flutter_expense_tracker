// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';

import './transaction.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(context) {
    return MaterialApp(
      title: 'Flutter Expense Manager',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage({Key? key}) : super(key: key);

  final List<Transaction> transactions = [
    Transaction(
      id: 'A1',
      title: 'Food Order',
      amount: 5,
      date: DateTime.now(),
    ),
    Transaction(
      id: 'A2',
      title: 'Laptop Stand',
      amount: 15,
      date: DateTime.now(),
    ),
  ];

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expense Manager'),
      ),
      body: Column(
        children: <Widget>[
          SizedBox(height: 10),
          Card(
            color: Color.fromARGB(255, 45, 188, 255),
            elevation: 5,
            child: SizedBox(
              height: 100,
              width: double.infinity,
              child: Center(
                child: Text(
                  'Chart',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          SizedBox(height: 10),
          SizedBox(
            height: 200,
            width: double.infinity,
            child: Card(
              color: Color.fromARGB(255, 49, 216, 57),
              elevation: 5,
              child: Center(
                child: Text(
                  'List Of Transactions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

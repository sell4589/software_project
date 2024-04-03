import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        fontFamily: 'Consolas',
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.green)
            .copyWith(secondary: Colors.deepOrange),
      ),
      home: TransactionList(),
    );
  }
}

class TransactionList extends StatefulWidget {
  @override
  _TransactionListState createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final List<Transaction> transactions = [
    Transaction(
        id: 't1',
        title: 'New shoes',
        amount: 159.0,
        date: DateTime.now().subtract(Duration(days: 3))),
    Transaction(
        id: 't2', title: 'Groceries', amount: 125.0, date: DateTime.now()),
  ];
  final titleContoller = TextEditingController();
  final amountController = TextEditingController();
  void addTransaction(String txtitle, double txamount) {
    final newTx = Transaction(
        title: txtitle, amount: txamount, id: 'tx', date: DateTime.now());
    setState(() {
      transactions.add(newTx);
    });
    Navigator.of(context).pop();
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (ctx) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap:
              () {}, //use this with gesturedetector to prevent close the bottomsheet when you click inside the sheet
          child: Card(
            elevation: 5,
            child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  TextField(
                    decoration: InputDecoration(labelText: 'Title'),
                    controller: titleContoller,
                  ),
                  TextField(
                    decoration: InputDecoration(labelText: 'Amount'),
                    controller: amountController,
                    keyboardType: TextInputType.number,
                  ),
                  TextButton(
                    child: Text('Add Transaction'),
                    onPressed: () {
                      print(titleContoller.text);
                      print(amountController.text);
                      addTransaction(titleContoller.text,
                          double.parse(amountController.text));
                    },
                  ), //textbutton
                ], //column children
              ), //column
            ), //container
          ), //card
        ); //gesturedetector return
      }, //showModalBottomSheet builder
    ); //showModalBottomSheet function
  } //_startAddNewTransaction function

  List<Map<String, Object>> get grouppedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (var i = 0; i < transactions.length; i++) {
        if (transactions[i].date.day == weekDay.day &&
            transactions[i].date.month == weekDay.month &&
            transactions[i].date.year == weekDay.year) {
          totalSum += transactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum,
      };
    });
  }

  double get totalSpending {
    return grouppedTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _startAddNewTransaction(context);
            },
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          _startAddNewTransaction(context);
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Container(
                child: Row(
                  children: grouppedTransactionValues.map((data) {
                    final spendingPctOfTotal = totalSpending == 0.0
                        ? 0.0
                        : (data['amount'] as double) / totalSpending;
                    //return Text(data['day'].toString() + ' ' + data['amount'].toString());
                    return Flexible(
                      fit: FlexFit.tight,
                      child: Column(
                        children: <Widget>[
                          FittedBox(
                            child: Text('\$${data['amount']}'),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Container(
                            height: 60,
                            width: 10,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.grey, width: 1.0),
                                    color: Color.fromRGBO(220, 220, 220, 1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                FractionallySizedBox(
                                  heightFactor: spendingPctOfTotal,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(data['day'].toString()),
                        ],
                      ),
                    );
                  }).toList(),
                ),
                width: double.infinity,
                color: Colors.blueGrey,
              ),
              elevation: 5,
              margin: EdgeInsets.all(20),
            ),
            Column(
              children: [
                Container(
                  height: 300,
                  child: transactions.isEmpty
                      ? Column(
                          children: [
                            Text('No transacations yet'),
                            SizedBox(
                              height: 20,
                            ),
                            Image.network(
                              'https://static.thenounproject.com/png/194055-200.png',
                              fit: BoxFit.cover,
                            ),
                          ],
                        )
                      : ListView.builder(
                          itemCount: transactions.length,
                          itemBuilder: (bc, index) {
                            return Card(
                              child: Row(
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 20),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                      color: Colors.black,
                                      width: 2,
                                    )),
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      '\$' +
                                          transactions[index]
                                              .amount
                                              .toStringAsFixed(2),
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                        color:
                                            Theme.of(context).primaryColorDark,
                                      ),
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        transactions[index].title,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        DateFormat.yMMMd()
                                            .format(transactions[index].date),
                                        style: TextStyle(
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ], //column children
                                  ), //column
                                ], //row children
                              ), //row
                            ); //card
                          }, //itemBuilder
                        ), //listview builder
                ), //container of the list view
              ], //colum children
            ), //column,
          ], //column children
        ), //column
      ), //SingleChildScrollView
    ); //scaffold
  }
}

class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  Transaction(
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}

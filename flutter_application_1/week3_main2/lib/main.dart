import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var questionIndex = 0;
  void answerQuestion() {
    setState(() {
      questionIndex++;
    });
    print("button click $questionIndex");
  }

  @override
  Widget build(BuildContext context) {
    var questions = ['What is your fav color?', 'What is your fav animal?'];
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("My first app"),
        ), //appBar
        body: Column(
          children: [
            Text(questions.elementAt(questionIndex)),
            ElevatedButton(child: Text("Answer 1"), onPressed: answerQuestion),
            ElevatedButton(
                child: Text("Answer 2"),
                onPressed: () {
                  print("answer 2 is chosen");
                }),
            ElevatedButton(child: Text("Answer 3"), onPressed: answerQuestion),
          ],
        ),
      ), //scaffold
    ); //materialapp
  }
}

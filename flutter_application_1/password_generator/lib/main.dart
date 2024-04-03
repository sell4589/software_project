import 'dart:math'; //Random sayılar oluşturmak için dart dilindeki matematik kütüphanesini içeri alıyoruz.
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //build metodunda, uygulamanın temel tasarımını (MaterialApp, tema, ana sayfa) oluşturuyoruz.
    return MaterialApp(
      title: 'Password Generator',
      theme: ThemeData(
        primarySwatch: Colors.brown,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String password =
      'Click button to generate'; //password değişkeni, ekranda görünen şifreyi depolar.Başlangıçta o yazı tanımlanmış
  final Random _random =
      Random(); //_random değişkeni, rastgele sayılar oluşturmak için kullanılır.

  void generatePassword() {
    //generatePassword fonksiyonu, yeni bir rastgele şifre oluşturmak için kullanılır.
    String newPassword = '';
    for (int i = 0; i < 8; i++) {
      //for döngüsü, 8 karakterlik bir rastgele şifre oluşturmak için kullanılır.
      newPassword += String.fromCharCode(_random.nextInt(26) + 97);
    }
    setState(() {
      //setState fonksiyonu, şifre değiştiğinde arayüzü güncellemek için kullanılır.
      password = newPassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    //build metodu, uygulamanın arayüzünü oluşturur.
    return Scaffold(
      //Scaffold widget'ı, temel yapıyı sağlar (AppBar, body, bottomNavigationBar).
      appBar: AppBar(
        title: Text('Password Generator'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Generated Password:',
            ),
            SizedBox(height: 10),
            Text(
              password,
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 100.0,
          child: ElevatedButton(
            onPressed: generatePassword,
            child: Text(
              'click ',
              style: TextStyle(fontSize: 18),
            ),
          ),
        ),
      ),
    );
  }
}

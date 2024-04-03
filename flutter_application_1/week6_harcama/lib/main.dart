import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/services.dart';

void main() {
  /*
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
   */
  runApp(MyApp());
}

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
      home: TransactionList(), //harcama işlemlerini listeler
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
//TextEditingController sınıfından iki adet kontrolcü.
//Bu kontrolcüler, kullanıcıdan alınacak olan yeni harcama bilgilerini tutmak için kullanılır.
//Birisi harcama başlığı (title), diğeri harcama miktarı (amount) için kullanılır.
  final titleContoller = TextEditingController();
  final amountController = TextEditingController();

  //Yeni bir harcama eklemek için kullanılan bir metod.
  void addTransaction(String txtitle, double txamount) {
    final newTx = Transaction(
        title: txtitle, amount: txamount, id: 'tx', date: DateTime.now());
    setState(() {
      //setState fonksiyonu kullanılarak, transactions listesine yeni harcama eklenir. setState kullanılmasının nedeni, bu işlemin Flutter'ın widget ağacında bir değişiklik olduğunu belirtmektir.
      transactions.add(newTx);
    });
    //ekranın kapatılması sağlanır. Bu, kullanıcının harcama ekledikten sonra harcama ekranından çıkmasını sağlar
    Navigator.of(context).pop();
  }

//Bu metodun amacı, alt sayfayı göstererek yeni bir harcama eklemek için bir kullanıcı arayüzü oluşturmaktır.
  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
      //fonksiyonu kullanılarak, alt sayfa görünümü oluşturulur.
      context: ctx,
      builder: (ctx) {
        //builder parametresi, alt sayfanın içeriğini oluşturan bir fonksiyonu alır.

        //GestureDetector widget'ı kullanılarak, kullanıcının alt sayfanın dışında bir yere tıklamasını önlemek için boş bir onTap metodu eklenir.
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap:
              () {}, //use this with gesturedetector to prevent close the bottomsheet when you click inside the sheet
          child: SingleChildScrollView(
            //SingleChildScrollView widget'ı kullanılarak, sayfanın taşma (overflow) durumunda kullanıcının sayfayı kaydırmasına olanak tanınır.
            child: Card(
              //Card widget'ı, alt sayfanın ana konteynerini temsil eder.
              elevation: 5,
              child: Container(
                padding: EdgeInsets.only(
                  //padding ile içeriğin kenar boşlukları ayarlanır.
                  top: 10,
                  left: 10,
                  right: 10,
                  bottom: MediaQuery.of(ctx).viewInsets.bottom + 10,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //İki adet TextField widget'ı,alt butondaki  kullanıcının harcama başlığı ve miktarını girmesine olanak tanır.
                    TextField(
                      decoration: InputDecoration(labelText: 'Title'),
                      controller: titleContoller,
                    ),
                    TextField(
                      decoration: InputDecoration(labelText: 'Amount'),
                      controller: amountController,
                      keyboardType: TextInputType
                          .number, //keyboardType özelliği, miktarın sadece sayısal değerler içermesini sağlar.
                    ),

                    TextButton(
                      //TextButton widget'ı, yeni harcamayı eklemek için kullanılır.
                      child: Text('Add Transaction'),
                      onPressed: () {
                        //Butona basıldığında, onPressed metodu çağrılır.
                        print(titleContoller.text);
                        print(amountController.text);
                        //Bu metod, addTransaction fonksiyonunu çağırarak yeni harcamayı ekler.
                        //Bu fonksiyon, titleController ve amountController kontrolcülerinden alınan değerleri kullanarak yeni bir harcama ekler.
                        addTransaction(titleContoller.text,
                            double.parse(amountController.text));
                      },
                    ), //textbutton
                  ], //column children
                ), //column
              ), //container
            ),
          ), //card
        ); //gesturedetector return
      }, //showModalBottomSheet builder
    ); //showModalBottomSheet function
  } //_startAddNewTransaction function

//grouppedTransactionValues metodun amacı, harcamaları haftalık olarak gruplamak ve her günün toplam harcama miktarını içeren bir liste oluşturmaktır.
//Her gün için bir harcama özeti olan bir Map oluşturulur ve bu harcama özetleri bir liste olarak döndürülür.
  List<Map<String, Object>> get grouppedTransactionValues {
    return List.generate(7, (index) {
      //List.generate fonksiyonu kullanılarak, 7 günlük bir döngü oluşturulur.
      final weekDay = DateTime.now()
          .subtract(Duration(days: index)); //günler geriye doğru sayılır.
      double totalSum = 0; //toplam harcama miktarı
      for (var i = 0; i < transactions.length; i++) {
        //transactions listesinde döngü yaparak, ilgili günün harcamalarını toplar.
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
    //Bu metodun amacı, haftalık harcamalardaki toplam miktarı hesaplamaktır.
    return grouppedTransactionValues.fold(0.0, (sum, item) {
      return sum +
          (item['amount']
              as double); //haftalık toplam harcamayı veren bir double değeri döndürür.
    });
  }
//_showChart Değişkeni:

//Bu değişken, haftalık harcamaların grafik olarak gösterilip gösterilmeyeceğini kontrol eder.
  bool _showChart = false;

  @override
  Widget build(BuildContext context) {
    final mediaQ = MediaQuery.of(
        context); //MediaQuery sınıfı kullanılarak, ekran boyutu ve yönlendirme bilgilerini alır.
    final isLandscape = mediaQ.orientation ==
        Orientation
            .landscape; //isLandscape değişkeni, cihazın ekran orientasyonunun yatay (landscape) olup olmadığını kontrol eder.
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        actions: [
          //actions özelliği, çubukta görünen ek eylemleri içerir
          IconButton(
            //IconButton kullanılarak yeni bir harcama eklemek için _startAddNewTransaction fonksiyonu çağrılır.
            icon: Icon(Icons.add),
            onPressed: () {
              _startAddNewTransaction(context);
            },
          ),
        ],
      ),
      //Bu buton, kullanıcıya yeni bir harcama eklemek için _startAddNewTransaction fonksiyonunu çağırma imkanı sunar.
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Platform.isIOS
          ? Container()
          : FloatingActionButton(
              child: Icon(Icons.add),
              onPressed: () {
                _startAddNewTransaction(context);
              },
            ),

      //body özelliği, uygulamanın ana içeriğini temsil eder.
//***SingleChildScrollView widget'ı kullanılarak, ekranın taşma durumunda kaydırma özelliği eklenir.
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //switch

            //Eğer cihaz yatay (landscape) moddaysa, bir Row widget'ı oluşturularak içinde bir metin (Text) ve bir anahtarlama düğmesi (Switch.adaptive) yer alır.
//Anahtarlama düğmesinin değeri _showChart değişkenine bağlıdır ve kullanıcı tarafından değiştirildiğinde onChanged fonksiyonu çağrılır. Bu fonksiyon, _showChart değişkenini günceller.
            /*     if (isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Show chart?'),
                  Switch.adaptive(
                    value: _showChart,
                    onChanged: (val) {
                      setState(() {
                        _showChart = val;
                      });
                    },
                  ),
                ],
              ),

            if ((isLandscape && _showChart) || (!isLandscape))
              //chart
              Container(
                height: mediaQ.size.height * 0.3,
                child: Card(
                  child: Container(
                    child: LayoutBuilder(builder: (ctx, constraints) {
                      return Row(
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
                                  height: constraints.maxHeight * 0.7,
                                  width: 10,
                                  child: Stack(
                                    children: <Widget>[
                                      Container(
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.grey, width: 1.0),
                                          color:
                                              Color.fromRGBO(220, 220, 220, 1),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      FractionallySizedBox(
                                        heightFactor: spendingPctOfTotal,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(10),
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
                      );
                    }),
                    width: double.infinity,
                    color: Colors.blueGrey,
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(20),
                ),
              ),
            if ((isLandscape && !_showChart) || (!isLandscape))
              //list
              Column(
                children: [
                  Container(
                    height: mediaQ.size.height * 0.6,
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
                          )*/
            ListView.builder(
              //dinamik bir liste oluşturmak için kullanılır.
              itemCount:
                  transactions.length, //, listenin kaç öğe içerdiğini belirtir.
              itemBuilder: (bc, index) {
                // fonksiyonu, her öğe için bir widget oluşturan bir callback fonksiyonunu temsil eder.
                return Card(
                  //harcamaların listelendiği her öğe için bir kart oluşturur. Bu, öğeleri gruplamak ve bir arada görüntülemek için kullanılır.
                  child: Row(
                    //Row, yatay bir düzenleme sağlar ve kart içindeki öğeleri yatay olarak düzenler.
                    children: [
                      Container(
                        //Harcamanın miktarını gösteren bir konteyner içerir.
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: BoxDecoration(
                            border: Border.all(
                          color: Colors.black,
                          width: 2,
                        )),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '\$' + transactions[index].amount.toStringAsFixed(2),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                      ),
                      Column(
                        //Column, dikey bir düzenleme sağlar ve harcama başlığı ile tarih bilgisini dikey olarak düzenler.
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactions[index].title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            DateFormat.yMMMd().format(transactions[index]
                                .date), //Tarih bilgisi, 'date' özelliği kullanılarak alınır ve gri renkte gösterilir.
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
            //container of the list view
          ], //colum children
        ), //column,
        //column children
      ), //column
      //SingleChildScrollView
    ); //scaffold
  }
}

//Transaction olan bu sınıf, uygulamanızda kullanılacak finansal işlemleri (transactions) modellemek için tasarlanmıştır.
class Transaction {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  Transaction(
      //  // 'required' kelimesi, bu parametrelerin null olamayacağını belirtir.
      {required this.id,
      required this.title,
      required this.amount,
      required this.date});
}

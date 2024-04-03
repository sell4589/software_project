import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter app',
      theme: ThemeData(
        //bu kısım uygulamanın teması için kullanışıyor.
        colorScheme: ColorScheme.fromSeed(
            seedColor:
                Colors.blue), //buradan uygulamanın rengini değiştiriyorsun.
        useMaterial3: true,
      ),
      home: const MyHomePage(
          title:
              'Week 4 Assignment'), //burada app barda ne yazacağını yazıyoruz.
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  //ana sayfa oluyor. Yukarıda myAppte kullandığımız title ı burda  kullandık.
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    //her setState çağırıldığında yeniden başlatılır.
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.title,
          // title özelliklerini girdik
          // text olarakta yukarıda tanımladığımız app bar textini alıyor.
          style: const TextStyle(
            //sonra stilini ayarladık.

            color: Colors.white, //rengini ayarladık.
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          StudentList(),
        ],
      ),
    );
  }
}

class StudentInfo {
  final int id;
  final String name;
  final String surname;
  final double gpd;
  StudentInfo({
    required this.id,
    required this.name,
    required this.gpd,
    required this.surname,
  });
}

class StudentList extends StatefulWidget {
  @override
  _StudentListState createState() => _StudentListState();
}

class _StudentListState extends State<StudentList> {
  final List<StudentInfo> studentInfo = [
    StudentInfo(
      id: 123,
      name: 'Rifat',
      gpd: 2.8,
      surname: 'Kurban',
    ),
    StudentInfo(
      id: 456,
      name: 'Melike',
      gpd: 3.2,
      surname: 'Kurban',
    ),
  ];
  final idController = TextEditingController();
  final nameController = TextEditingController();
  final surnameController = TextEditingController();
  final gpdController = TextEditingController();

  void addNewStudent(
    //Parametreler
    int txtId,
    String txtName,
    String txtSurname,
    double txtGpd,
  ) {
    //yeni bir öğrenci objesi oluşturma
    final newTx = StudentInfo(
      id: txtId,
      name: txtName,
      surname: txtSurname,
      gpd: txtGpd,
    );
    setState(() {
      studentInfo.add(newTx); //yukarıda oluşturduğumuz objeyi yazdık
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Card(
          elevation: 5,
          child: Container(
            color: Colors.white,
            padding: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Id:',
                    border: OutlineInputBorder(
                      // Çerçeve özelliğini burada belirliyoruz
                      borderSide: BorderSide(
                        color: Colors.black, // Çerçevenin rengi
                        width: 2, // Çerçeve kalınlığı
                      ),
                    ),
                  ),
                  controller: idController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Name:',
                    border: OutlineInputBorder(
                      // Çerçeve özelliğini burada belirliyoruz
                      borderSide: BorderSide(
                        color: Colors.black, // Çerçevenin rengi
                        width: 2, // Çerçeve kalınlığı
                      ),
                    ),
                  ),
                  controller: nameController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'Surname:',
                    border: OutlineInputBorder(
                      // Çerçeve özelliğini burada belirliyoruz
                      borderSide: BorderSide(
                        color: Colors.black, // Çerçevenin rengi
                        width: 2, // Çerçeve kalınlığı
                      ),
                    ),
                  ),
                  controller: surnameController,
                ),
                TextField(
                  decoration: const InputDecoration(
                    labelText: 'GPD:',
                    border: OutlineInputBorder(
                      // Çerçeve özelliğini burada belirliyoruz
                      borderSide: BorderSide(
                        color: Colors.black, // Çerçevenin rengi
                        width: 2, // Çerçeve kalınlığı
                      ),
                    ),
                  ),
                  controller: gpdController,
                ),
                TextButton(
                  //bir text butonu ekledik
                  child: Text('Add Student'),
                  onPressed: () {
                    addNewStudent(
                        int.parse(idController.text),
                        nameController.text,
                        surnameController.text,
                        double.parse(gpdController.text));
                  },
                ),
              ],
            ),
          ),
        ),
        Column(
            children: studentInfo.map((tx) {
          //burada yukarıda tanımladığın ismi çağıracaksın.
          return Card(
            elevation: 5,
            child: Container(
              color: Colors.white,
              child: Row(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Row'u yatayda ortalama

                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [
                      Text(
                        'Id: ${tx.id}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'GDP: ${tx.gpd}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                    //column children
                  ),
                  SizedBox(width: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Name: ${tx.name}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Surname: ${tx.surname}',
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ), //column
                ], //row children
              ), //row),
            ),
          ); //card
        }).toList()),
      ],
    );
  }
}

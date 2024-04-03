import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //genel uygulamayı tanımladık
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food recipe',
      theme: ThemeData(
        //temayı belirledik
        primarySwatch: Colors.pink,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //ana sayfa tasarımı
  final List<Food> foodList = [
    //ana sayfada yemek listesi olacağı için list Food yazıyoruz
    Food(
      //liste elemanlarını tek tek yazıyoruz.
      title: 'Pizza',
      description:
          'Cheddar cheese, Mozzarella cheese, Red pepper, Tomatoes, Olive, Sausage, Mushroom, Sausage.',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/c/c0/Pizza_with_tomatoes.jpg',
    ),
    Food(
      title: 'Spaghetti',
      description:
          '8 glasses of water, 1 level tablespoon of salt, 250 gr. , Pasta Strainer',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/3/33/Espaguetis_carbonara.jpg',
    ),
    Food(
      title: 'Hamburger',
      description:
          '1 large egg, ½ teaspoon salt, ½ teaspoon ground black pepper, 1 pound ground beef, ½ cup fine dry bread crumbs',
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/c/ce/McDonald%27s_Quarter_Pounder_with_Cheese%2C_United_States.jpg',
    ),
  ];
//build metodu, ana sayfanın görünümünü oluşturur.
  @override
  Widget build(BuildContext context) {
    //scaffold kısmını yazıyoruz.
    return Scaffold(
      appBar: AppBar(
        title: Text('Yummies :) :)'), //appbar kısmı
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        //liste görünümü oluşturur
        //Resimleri ListView içine yazıyoruz.

        //esnek programlı liste için  itemCount:,itemBuilder:kullanırız
        itemCount:
            foodList.length, //listenin uzunluğunu listenin uzunluğu yaptık
        itemBuilder: (context, index) {
          //
          return GestureDetector(
            //her karta tıklanılabilirlik ekler
            //kullanıcıların ekran üzerindeki çeşitli dokunma, kaydırma, basılı tutma gibi hareketlerini algılayarak bu hareketlere tepki vermenizi sağlar.
            onTap: () {
              //on tap methodu tanımladık ve bunun içine Navigator.Push methodu koyarak Recipi page e gitmesini sağladık
              Navigator.push(
                //yeni sayfaya gitme methodu
                //eğer resme tıklanırsa sayfaya gitme methodunu yazdık
                context,
                MaterialPageRoute(
                  builder: (context) => RecipePage(food: foodList[index]),
                ),
              );
            },
            child: Card(
              //sonra bunun içine card oluşturduk ve ana sayfa görüntüsünün nasıl olacağını gösterdik
              child: Column(
                children: [
                  Image.network(
                    //sadece image olacağı için onu ekledik.
                    foodList[index].imageUrl,
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Food {
  //bu ise liste ögeleri
  String title;
  String description;
  String imageUrl;

  Food({
    required this.title,
    required this.description,
    required this.imageUrl,
  });
}

class RecipePage extends StatelessWidget {
  //2. sayfamız
  //ikinci sayfayı oluşturduk
  final Food food; //bilgileri kullanabilmek için objesini oluşturduk.

  RecipePage({required this.food});

  @override
  Widget build(BuildContext context) {
    // Malzemeleri liste haline getir
    List<String> ingredients = food.description
        .split(', '); //bu kısmı alt alta malzemeleri yazabilmek için kullandık.
    //food adında bir nesnenin description özelliğini alır.
    //descriptiondaki dizeyi belirli bir ayracı kullanarak böler.
    //Sonuç olarak elde edilen alt dizeleri bir listeye ekler.
    //Bu örnekte, ayracın virgül (,) olduğunu görebiliriz. Yani, food.description dizesindeki her öğe virgülle ayrılmış bir liste elemanına dönüştürülür

    return Scaffold(
      //2. sayfasnın görüntüsünü ayarlıyoruz.
      appBar: AppBar(
        //apbarı oluşturduk.
        leading: IconButton(
          //geri dönme butonu
          icon: Icon(Icons.arrow_back), //düğmedeki ikonu belirtir
          onPressed: () {
            Navigator.pop(context); //bu bir önceki sayfaya geri dönme methodu.
          },
        ),
        title: Text('Recipi Page :)'),
        centerTitle: true, //diyerek başlığı ortaladık
      ),
      body: Column(
        //dikey
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          //aşağıdaki kod, belirtilen URL'den getirilen bir resmi görüntüleyen bir widget oluşturur. Resim, üstte belirtilen genişlikte yatay boşluğu doldurarak ve belirtilen yüksekliğe sahip olarak, ebeveyn widget'ı içinde üst ortaya hizalanmış bir şekilde görüntülenir.
          Align(
            //widget'ı, çocuğunu (bu durumda resmi) kendi içinde hizalamak için kullanılır. Bir alignment parametresi alır ve çocuğun, mevcut alan içinde nereye konumlandırılacağını belirtir.
            //sadece resmi align içine aldık
            alignment: Alignment
                .topCenter, //Burada, Alignment.topCenter özelliği ayarlanmıştır, bu da çocuğun (bu durumda resmin), Align widget'ının üst ortasına hizalanacağı anlamına gelir.

            child: Image.network(
              //Align widget'ının çocuğu bir Image widget'ıdır ve food.imageUrl içinde verilen URL'den bir resmi yükler.

              //yine en başa resmi koyduk .
              food.imageUrl,
              height: 200,
              width: double.infinity,
              fit: BoxFit
                  .cover, //fit özelliği, BoxFit.cover olarak ayarlanmıştır, bu da resmin tüm kutuyu kaplamak için ölçeklendirileceği anlamına gelir ve bu sırada en-boy oranını korur. Bu, gerekirse resmin bazı kısımlarının kırpılmasına neden olabilir.
            ),
          ),
          SizedBox(height: 16), //resmin altına boşluk ekledik
          Text(
            ' ${food.title}', //title ekledik
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8), //araya  boşluk ekledik
          // Malzemeleri liste halinde göster
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: ingredients
                .map((ingredient) => Text(' $ingredient'))
                .toList(), //map ile ingiridients i çektik.
          ),
        ],
      ),
    );
  }
}

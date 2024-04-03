import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Category> categories = DUMMY_CATEGORIES;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Genres'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //maxCrossAxisExtent:200, ızgara öğelerinin maksimum genişliğini belirler.
          crossAxisCount:
              2, //Yani, ekranda kaç tane elemanın yan yana sıralanacağını kontrol eder.
          childAspectRatio: 3 / 2, //, ızgara öğelerinin boyut oranını belirler.
          crossAxisSpacing: 20, //ızgara öğeleri arasındaki boşlukları belirler.
          mainAxisSpacing: 20, //ızgara öğeleri arasındaki boşlukları belirler.
        ),
        itemCount: categories
            .length, //kategori listesindeki toplam kategori sayısını belirler.
        itemBuilder: (context, index) {
          ///Bu kod parçası, Navigator.push metodunu kullanarak bir sayfa geçişi başlatır.
          /// MaterialPageRoute ise sayfa geçişini yöneten sınıftır.
          /// builder parametresi, yeni sayfanın nasıl oluşturulacağını belirten bir anonim fonksiyon alır.
          /// Bu durumda, BookListPage sayfası oluşturulur ve bu sayfaya ilgili kategori parametre olarak iletilir.
          /// Yani, kullanıcı bir kategoriye tıkladığında, BookListPage sayfası bu kategoriye ait kitapları listeleyecektir.
          return InkWell(
            //. Her bir kart, bir kategoriye yönlendiren bir dokunma işlemi (InkWell) ile oluşturulur.
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      BookListPage(category: categories[index]),
                ),
              );
            },
            child: Card(
              color: categories[index]
                  .color, //categories[index].color ifadesi kullanılarak kategoriye özgü renk belirlenir.
              child: Center(
                child: Text(
                  categories[index]
                      .title, //categories[index].title ifadesi, ilgili kategori öğesinin başlığını içerir.

                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class BookListPage extends StatefulWidget {
  final Category category;

  BookListPage({required this.category});

  @override
  _BookListPageState createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  List<Book> books =
      DUMMY_BOOKS; ////Bu satır, BookListPage sınıfında bir liste oluşturur ve bu liste, tüm kitapları içeren DUMMY_BOOKS listesini başlangıç değeri olarak alır.

  @override
  Widget build(BuildContext context) {
/*Bu satır,  kitapları tutacak olan bir liste olan filteredBooks'u oluşturur.
books listesindeki kitapları, belirli bir kategoriye ait olanlarla sınırlamak için where fonksiyonunu kullanır.
where fonksiyonu, verilen koşula uyan elemanları içeren yeni bir iterable döndürür.
Koşul, her bir kitabın kategoriler listesinde (book.categories) widget.category.id'yi içermesi durumunu kontrol eder.
toList() fonksiyonu, bu iterable'ı bir listeye dönüştürür ve filteredBooks listesine atar.
    */
    List<Book> filteredBooks = books
        .where((book) => book.categories.contains(widget.category.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: ListView.builder(
        itemCount: filteredBooks.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            shadowColor: Colors.black,
            child: ListTile(
              title: Text(filteredBooks[index].title),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        //uygulamanın alt kısmında bulunan bir gezinme çubuğu
        items: [
          //items özelliği, her bir gezinme öğesini (BottomNavigationBarItem) içeren bir liste alır.
          BottomNavigationBarItem(
            //BottomNavigationBarItem, alt gezinme çubuğundaki her bir öğeyi temsil eder.
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
        ],
        onTap: (index) {
          //index parametresi, tıklanan öğenin indeksini temsil eder.
//EĞer tıklanan öğe indeksi 0 ise (yani "Home" öğesi), Navigator.pop(context) kullanılarak mevcut sayfadan çıkılır ve bir önceki sayfaya dönülür.
          if (index == 0) {
            Navigator.pop(context);

            //Eğer tıklanan öğe indeksi 1 ise (yani "Add" öğesi), _showAddBookModal fonksiyonu çağrılarak bir modal pencere açılır. Bu fonksiyon, yeni bir kitap eklemek için bir alt sayfa veya modal pencere gösterir
          } else if (index == 1) {
            _showAddBookModal(context);
          }
        },
      ),
    );
  }

  void _showAddBookModal(BuildContext context) {
    String newBookTitle = ''; //// Yeni eklenen kitabın adını tutan değişken

//alttan yukarı doğru açılan bir modal pencere oluşturur
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Book Title'),
                onChanged: (value) {
                  //onChanged özelliği, metin alanındaki değer her değiştiğinde çalışan bir fonksiyonu belirler.
                  newBookTitle = value;
                },
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                onPressed: () {
                  if (newBookTitle.isNotEmpty) {
                    //                  // Yeni kitabı oluştur ve listeye ekle

                    Book newBook = Book(
                      id: 'b${books.length + 1}',
                      categories: [widget.category.id],
                      title: newBookTitle,
                    );

                    setState(() {
                      // setState, kitap listesini günceller ve eklenen kitabı gösterir

                      books.add(newBook);
                    });

                    Navigator.pop(
                        context); //Modal pencereyi kapatmak için kullanılır. Bu sayede, kullanıcı yeni kitap ekledikten sonra modal pencere otomatik olarak kapanır.
                  }
                },
                child: Text('Add Book'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Category {
  final String id;
  final String title;
  final Color color;

  Category({
    required this.id,
    required this.title,
    required this.color,
  });
}

class Book {
  final String id;
  final List<String> categories;
  final String title;

  Book({
    required this.id,
    required this.categories,
    required this.title,
  });
}

final DUMMY_CATEGORIES = [
  Category(
    id: 'c1',
    title: 'Literature',
    color: Colors.purple,
  ),
  Category(
    id: 'c2',
    title: 'Self-Help',
    color: Colors.red,
  ),
  Category(
    id: 'c3',
    title: 'Horror',
    color: Colors.orange,
  ),
  Category(
    id: 'c4',
    title: 'History',
    color: Colors.amber,
  ),
  Category(
    id: 'c5',
    title: 'Mysteries',
    color: Colors.blue,
  ),
  Category(
    id: 'c6',
    title: 'Romance',
    color: Colors.green,
  ),
  Category(
    id: 'c7',
    title: 'Westerns',
    color: Colors.lightBlue,
  ),
  Category(
    id: 'c8',
    title: 'Comics',
    color: Colors.lightGreen,
  ),
  Category(
    id: 'c9',
    title: 'Health anf Fitness',
    color: Colors.pink,
  ),
  Category(
    id: 'c10',
    title: 'Hobbies and Crafts',
    color: Colors.teal,
  ),
  Category(
    id: 'c11',
    title: 'Religion',
    color: Colors.purpleAccent,
  ),
  Category(
    id: 'c12',
    title: 'Science Fiction (Sci-Fi)',
    color: Colors.cyanAccent,
  ),
  Category(
    id: 'c13',
    title: 'Short Stories',
    color: Colors.pink,
  ),
  Category(
    id: 'c14',
    title: 'Suspense and Thrillers',
    color: Colors.amber,
  ),
  Category(
    id: 'c15',
    title: 'Home and Garden',
    color: Colors.black12,
  ),
  Category(
    id: 'c16',
    title: 'Medical',
    color: Colors.teal,
  ),
  Category(
    id: 'c17',
    title: 'Parenting',
    color: Colors.pink,
  ),
];

final DUMMY_BOOKS = [
  Book(
    id: 'b1',
    categories: [
      'c1',
      'c3',
    ],
    title: 'Treasure Island -  Robert Louis Stevenson',
  ),
  Book(
    id: 'b2',
    categories: [
      'c1',
    ],
    title: 'Little Women and Other Novels - Louisa May Alcott',
  ),
  Book(
    id: 'b3',
    categories: [
      'c1',
    ],
    title: 'Frankenstein - Mary Shelley',
  ),
  Book(
    id: 'b4',
    categories: [
      'c1',
    ],
    title: 'To Kill a Mockingbird - Harper Lee',
  ),
  Book(
    id: 'b5',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b6',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b7',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b8',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b9',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b10',
    categories: [
      'c2',
    ],
    title: 'The Alchemist by Paulo Coelho',
  ),
  Book(
    id: 'b11',
    categories: [
      'c2',
    ],
    title: 'Atomic Habits by James Clear',
  ),
  Book(
    id: 'b12',
    categories: [
      'c2',
    ],
    title: 'Thinking Fast And Slow by Daniel Kahneman',
  ),
  Book(
    id: 'b13',
    categories: [
      'c2',
    ],
    title: 'The Four Agreements by Don Miguel Ruiz',
  ),
  Book(
    id: 'b14',
    categories: [
      'c2',
    ],
    title: 'The 7 Habits Of Highly Effective People by Stephen R. Covey',
  ),
  Book(
    id: 'b15',
    categories: [
      'c2',
    ],
    title: 'Best Self by Mike Bayer',
  ),
  Book(
    id: 'b16',
    categories: [
      'c2',
    ],
    title:
        'The Subtle Art of Not Giving a F*ck by Mark Manson Best Self Help Books for Women',
  ),
  Book(
    id: 'b17',
    categories: [
      'c2',
    ],
    title: 'Girl, Wash Your Face by Rachel Hollis',
  ),
  Book(
    id: 'b18',
    categories: [
      'c2',
    ],
    title: '12 Rules For Life by Jordan Peterson',
  ),
  Book(
    id: 'b19',
    categories: [
      'c2',
    ],
    title: 'Big Magic by Elizabeth Gilbert',
  ),
];

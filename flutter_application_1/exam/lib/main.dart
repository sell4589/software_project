import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final List<Category> categories = DUMMY_CATEGORIES;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 16, 1, 75),
      appBar: AppBar(
        title: Text(
          'MOVIES',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(222, 2, 10, 98),
        leading: const Icon(
          Icons.movie,
          color: Colors.white,
        ),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MovieListPage(category: categories[index]),
                ),
              );
            },
            child: Card(
              color: categories[index].color,
              child: Center(
                child: Text(
                  categories[index].title,
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

class MovieListPage extends StatefulWidget {
  final Category category;

  MovieListPage({required this.category});

  @override
  _MovieListPageState createState() => _MovieListPageState();
}

class _MovieListPageState extends State<MovieListPage> {
  List<Movie> movies =
      DUMMY_MOVIES; ////Bu satır, MovieListPage sınıfında bir liste oluşturur ve bu liste, tüm kitapları içeren DUMMY_BOOKS listesini başlangıç değeri olarak alır.

  @override
  Widget build(BuildContext context) {
    List<Movie> filteredMovies = movies
        .where((book) => book.categories.contains(widget.category.id))
        .toList();

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 19, 88),
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: ListView.builder(
        itemCount: filteredMovies.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            shadowColor: Colors.black,
            child: ListTile(
              title: Text(filteredMovies[index].title),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "add",
          ),
        ],
        onTap: (index) {
          if (index == 0) {
            Navigator.pop(context);
          } else if (index == 1) {
            _showAddMovieModal(context);
          }
        },
      ),
    );
  }

  void _showAddMovieModal(BuildContext context) {
    String newMovieTitle = ''; //// Yeni eklenen filmin adını tutan değişken

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                decoration: InputDecoration(labelText: ' Title'),
                onChanged: (value) {
                  newMovieTitle = value;
                },
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: () {
                  if (newMovieTitle.isNotEmpty) {
                    Movie newMovie = Movie(
                      id: 'b${movies.length + 1}',
                      categories: [widget.category.id],
                      title: newMovieTitle,
                    );

                    setState(() {
                      movies.add(newMovie);
                    });

                    Navigator.pop(context);
                  }
                },
                child: Text('Add Movie'),
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

class Movie {
  final String id;
  final List<String> categories;
  final String title;

  Movie({
    required this.id,
    required this.categories,
    required this.title,
  });
}

final DUMMY_CATEGORIES = [
  Category(
    id: 'c1',
    title: 'Action',
    color: Colors.black87,
  ),
  Category(
    id: 'c2',
    title: 'Romance',
    color: Colors.black87,
  ),
  Category(
    id: 'c3',
    title: 'Science Fiction',
    color: Colors.black87,
  ),
  Category(
    id: 'c4',
    title: 'Horror',
    color: Colors.black87,
  ),
  Category(
    id: 'c5',
    title: 'Comedy',
    color: Colors.black87,
  ),
  Category(
    id: 'c6',
    title: 'Documentary',
    color: Colors.black87,
  ),
  Category(
    id: 'c7',
    title: 'Fantasy',
    color: Colors.black87,
  ),
  Category(
    id: 'c8',
    title: 'Animation',
    color: Colors.black87,
  ),
  Category(
    id: 'c9',
    title: 'Thriller',
    color: Colors.black87,
  ),
  Category(
    id: 'c10',
    title: 'Drama',
    color: Colors.black87,
  ),
  Category(
    id: 'c11',
    title: 'Musical',
    color: Colors.black87,
  ),
  Category(
    id: 'c12',
    title: 'Historical',
    color: Colors.black87,
  ),
  Category(
    id: 'c13',
    title: 'Adventure',
    color: Colors.black87,
  ),
  Category(
    id: 'c14',
    title: 'Crime',
    color: Colors.black87,
  ),
  Category(
    id: 'c15',
    title: 'Mystery',
    color: Colors.black87,
  ),
  Category(
    id: 'c16',
    title: 'Biography',
    color: Colors.black87,
  ),
  Category(
    id: 'c17',
    title: 'War',
    color: Colors.black87,
  ),
  Category(
    id: 'c18',
    title: 'Western',
    color: Colors.black87, // Using a shade of brown
  ),
  Category(
    id: 'c19',
    title: 'Sports',
    color: Colors.black87,
  ),
  Category(
    id: 'c20',
    title: 'Family',
    color: Colors.black87,
  )
];

final DUMMY_MOVIES = [
  Movie(
    id: 'm1',
    categories: [
      'c1',
    ],
    title: 'Die Hard',
  ),
  Movie(
    id: 'm2',
    categories: [
      'c2',
    ],
    title: 'The Notebook',
  ),
  Movie(
    id: 'm3',
    categories: [
      'c3',
    ],
    title: 'Blade Runner',
  ),
  Movie(
    id: 'm4',
    categories: [
      'c1',
    ],
    title: 'Mad Max: Fury Road',
  ),
  Movie(
    id: 'm5',
    categories: [
      'c4',
    ],
    title: 'The Conjuring',
  ),
  Movie(
    id: 'm6',
    categories: [
      'c5',
    ],
    title: 'Superbad',
  ),
  Movie(
    id: 'm7',
    categories: [
      'c3',
      'c1',
    ],
    title: 'The Matrix',
  ),
  Movie(
    id: 'm8',
    categories: [
      'c2',
    ],
    title: 'Pride and Prejudice',
  ),
  Movie(
    id: 'm9',
    categories: [
      'c4',
    ],
    title: 'Get Out',
  ),
  Movie(
    id: 'm10',
    categories: [
      'c1',
    ],
    title: 'John Wick',
  ),
  Movie(
    id: 'm11',
    categories: [
      'c5',
    ],
    title: 'The Hangover',
  ),
  Movie(
    id: 'm12',
    categories: [
      'c3',
    ],
    title: 'Interstellar',
  ),
  Movie(
    id: 'm13',
    categories: [
      'c4',
    ],
    title: 'A Quiet Place',
  ),
  Movie(
    id: 'm14',
    categories: [
      'c1',
      'c3',
    ],
    title: 'Inception',
  ),
  Movie(
    id: 'm15',
    categories: [
      'c5',
    ],
    title: 'Step Brothers',
  ),
  Movie(
    id: 'm16',
    categories: [
      'c1',
    ],
    title: 'The Avengers',
  ),
  Movie(
    id: 'm17',
    categories: [
      'c2',
    ],
    title: 'La La Land',
  ),
  Movie(
    id: 'm18',
    categories: [
      'c3',
    ],
    title: 'Guardians of the Galaxy',
  ),
  Movie(
    id: 'm19',
    categories: [
      'c4',
    ],
    title: 'It',
  ),
  Movie(
    id: 'm20',
    categories: [
      'c5',
    ],
    title: 'Knocked Up',
  ),
  Movie(
    id: 'm21',
    categories: [
      'c3',
      'c1',
    ],
    title: 'Star Wars: The Force Awakens',
  ),
  Movie(
    id: 'm22',
    categories: [
      'c2',
    ],
    title: 'Titanic',
  ),
  Movie(
    id: 'm23',
    categories: [
      'c1',
    ],
    title: 'Gladiator',
  ),
  Movie(
    id: 'm24',
    categories: [
      'c4',
    ],
    title: 'Hereditary',
  ),
  Movie(
    id: 'm25',
    categories: [
      'c5',
    ],
    title: 'Anchorman: The Legend of Ron Burgundy',
  ),
  Movie(
    id: 'm26',
    categories: [
      'c1',
    ],
    title: 'Black Panther',
  ),
  Movie(
    id: 'm27',
    categories: [
      'c2',
    ],
    title: 'Eternal Sunshine of the Spotless Mind',
  ),
  Movie(
    id: 'm28',
    categories: [
      'c3',
    ],
    title: '2001: A Space Odyssey',
  ),
  Movie(
    id: 'm29',
    categories: [
      'c4',
    ],
    title: 'Psycho',
  ),
  Movie(
    id: 'm30',
    categories: [
      'c5',
    ],
    title: 'Bridesmaids',
  ),
  Movie(
    id: 'm31',
    categories: [
      'c1',
      'c3',
    ],
    title: 'Jurassic Park',
  ),
  Movie(
    id: 'm32',
    categories: [
      'c2',
    ],
    title: 'Casablanca',
  ),
  Movie(
    id: 'm33',
    categories: [
      'c1',
    ],
    title: 'Indiana Jones: Raiders of the Lost Ark',
  ),
  Movie(
    id: 'm34',
    categories: [
      'c4',
    ],
    title: 'The Shining',
  ),
  Movie(
    id: 'm35',
    categories: [
      'c5',
    ],
    title: 'The Grand Budapest Hotel',
  ),
];

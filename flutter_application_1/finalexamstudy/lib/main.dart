import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AuthorsPage(),
    );
  }
}

class Author {
  final String id;
  final String name;
  final Color color;

  Author({required this.id, required this.name, required this.color});
}

final List<Author> DUMMY_AUTHORS = [
  Author(id: 'c1', name: 'İhsan Oktay Anar', color: Colors.purple),
  Author(id: 'c2', name: 'Isaac Asimov', color: Colors.red),
  Author(id: 'c3', name: 'George Orwell', color: Colors.orange),
  Author(id: 'c4', name: 'Stefan Zweig', color: Colors.amber),
  Author(id: 'c5', name: 'Victor Hugo', color: Colors.blue),
  Author(id: 'c6', name: 'Yusuf Atılgan', color: Colors.green),
  Author(id: 'c7', name: 'Jack London', color: Colors.lightBlue),
  Author(id: 'c8', name: 'Frank Herbert', color: Colors.lightGreen),
  Author(id: 'c9', name: 'Nikolai Gogol', color: Colors.pink),
  Author(id: 'c10', name: 'Aldous Huxley', color: Colors.teal),
];

class AuthorsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Authors'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: DUMMY_AUTHORS.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => BooksPage(author: DUMMY_AUTHORS[index]),
                ),
              );
            },
            child: Card(
              color: DUMMY_AUTHORS[index].color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Center(
                child: Text(
                  DUMMY_AUTHORS[index].name,
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

class BooksPage extends StatefulWidget {
  const BooksPage({
    Key? key,
    required this.author,
  }) : super(key: key);

  final Author author;

  @override
  State<StatefulWidget> createState() {
    return _BooksPageState();
  }
}

class _BooksPageState extends State<BooksPage> {
  List<Book> allBooks = [];

  @override
  void initState() {
    super.initState();
    fetchBooks(widget.author.name);
  }

  Future<void> fetchBooks(String authorName) async {
    try {
      const String apiKey = 'AIzaSyBVWvIX2OvaPx_oAS0zAgQ9FkNRBrJCW0I';

      // Constructing the API request URL for books by a specific author
      String apiUrl =
          'https://www.googleapis.com/books/v1/volumes?q=inauthor:$authorName&key=$apiKey';

      // Sending HTTP get request and waiting for the response
      http.Response response = await http.get(Uri.parse(apiUrl));

      // Checking the status code of the response
      if (response.statusCode == 200) {
        // Parsing the response body as JSON
        Map<String, dynamic> responseData = json.decode(response.body);

        // Extracting the list of books from the API response
        List<dynamic> books = responseData['items'];

        // Creating a list of Book objects
        List<Book> bookList = books
            .map((book) => Book(
                  title: book['volumeInfo']['title'] ?? 'No Title',
                  description:
                      book['volumeInfo']['description'] ?? 'No Description',
                  authors: book['volumeInfo']['authors'] != null
                      ? List<String>.from(book['volumeInfo']['authors'])
                      : [],
                ))
            .toList();

        // Updating the state with the fetched books
        setState(() {
          allBooks = bookList;
        });
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      // Handling any errors that might occur
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Books by ${widget.author.name}'),
      ),
      body: ListView.builder(
        itemCount: allBooks.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: ListTile(
                title: Text(allBooks[index].title),
                subtitle: Text(allBooks[index].authors.join(', ')),
              ),
            ),
          );
        },
      ),
    );
  }
}

class Book {
  final String title;
  final String description;
  final List<String> authors;

  const Book({
    required this.title,
    required this.description,
    required this.authors,
  });
}

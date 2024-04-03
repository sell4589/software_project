import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Category {
  final Color color;
  final String title;

  Category({required this.color, required this.title});
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
  final List<Category> categories = [
    Category(color: Colors.red, title: 'Business'),
    Category(color: Colors.blue, title: 'Entertainment'),
    Category(color: Colors.green, title: 'General'),
    Category(color: Colors.orange, title: 'Health'),
    Category(color: Colors.purple, title: 'Science'),
    Category(color: Colors.teal, title: 'Sports'),
    Category(color: Colors.indigo, title: 'Technology'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Categories'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsPage(category: categories[index]),
                ),
              );
            },
            child: Card(
              color: categories[index].color,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
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

// ...

class NewsPage extends StatelessWidget {
  final Category category;

  NewsPage({required this.category});

  // Dummy news data for demonstration
  final List<Map<String, String>> newsData = [
    {
      'title': 'Sports News 1',
      'image': 'https://example.com/sports_image1.jpg',
      'description': 'Description for Sports News 1.',
    },
    {
      'title': 'Sports News 2',
      'image': 'https://example.com/sports_image2.jpg',
      'description': 'Description for Sports News 2.',
    },
    // Add more news data for other categories
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.title} News'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page (Home Page)
          },
        ),
      ),
      body: ListView.builder(
        itemCount: newsData.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(newsData[index]['title']!),
            leading: CircleAvatar(
              backgroundImage: NetworkImage(newsData[index]['image']!),
            ),
            subtitle: Text(newsData[index]['description']!),
          );
        },
      ),
    );
  }
}

// ...


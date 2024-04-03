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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, 
      ),
      backgroundColor: Colors.white, 
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            margin: EdgeInsets.only(bottom: 16.0),
            decoration: BoxDecoration(
              color: Colors.pink,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.subtitle1!.merge(
                          const TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18.0,
                            color: Colors.black,
                          ),
                        ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    "A Greet welcome to you all.",
                    style: Theme.of(context).textTheme.subtitle2!.merge(
                          const TextStyle(
                            color: Colors.black,
                          ),
                        ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
              children: [
                ProductBox(
                  image:
                      'data:image/jpeg;base64,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',
                  name: "Sneakers",
                  price: '\$49.99',
                  onTap: () {
                  },
                ),
                ProductBox(
                  image:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/2/24/Blue_Tshirt.jpg/255px-Blue_Tshirt.jpg',
                  name: 'Blue T-shirt',
                  price: '\$29.99',
                  onTap: () {
                  },
                ),
                ProductBox(
                  image:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/7/75/Selburose-sweater.jpg/330px-Selburose-sweater.jpg',
                  name: 'Selburose Sweater',
                  price: '\$39.99',
                  onTap: () {
                  },
                ),
                ProductBox(
                  image:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Shirt.jpg/375px-Shirt.jpg',
                  name: 'Formal Shirt',
                  price: '\$34.99',
                  onTap: () {
                  },
                ),
                ProductBox(
                  image:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Marcasite_necklace.jpg/330px-Marcasite_necklace.jpg',
                  name: 'Marcasite Necklace',
                  price: '\$59.99',
                  onTap: () {
                  },
                ),
                ProductBox(
                  image:
                      'https://upload.wikimedia.org/wikipedia/commons/thumb/1/17/Scarpa_di_vernice.jpg/300px-Scarpa_di_vernice.jpg',
                  name: 'Patent Leather Shoe',
                  price: '\$79.99',
                  onTap: () {
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,
                color: Colors.black), // Change the icon color to pink
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite,
                color: Colors.black), // Change the icon color to pink
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart,
                color: Colors.black), // Change the icon color to pink
            label: 'Add to Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,
                color: Colors.black), // Change the icon color to pink
            label: 'Notifications',
          ),
        ],
        backgroundColor: Colors
            .pink, // Change the background color of the bottom navigation bar to pink
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  final String image;
  final String name;
  final String price;
  final Function onTap;

  const ProductBox({
    required this.image,
    required this.name,
    required this.price,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Card(
        margin: EdgeInsets.all(8.0),
        color: Colors.pink, // Change the color of the box to pink
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Image.network(
                image,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white, // Change the text color to white
                    ),
                  ),
                  Text(
                    price,
                    style: TextStyle(
                      color: Colors.white, // Change the text color to white
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite,
                            color:
                                Colors.white), // Change the icon color to white
                        onPressed: () {
                          // Handle favorite button tap
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.shopping_cart,
                            color:
                                Colors.white), // Change the icon color to white
                        onPressed: () {
                          // Handle add to cart button tap
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'shop_screen.dart';

class ExploreScreen extends StatelessWidget {
  final List<Map<String, String>> shops = [
    {'name': 'Shoprite', 'imageUrl': 'https://i.postimg.cc/qMjrDxvM/image.png'},
    {'name': 'Pick n Pay', 'imageUrl': 'https://i.postimg.cc/kMyPDv8F/image.png'},
    {'name': 'Game', 'imageUrl': 'https://i.postimg.cc/3NhhVLGW/image.png'},
    {'name': 'Spar', 'imageUrl': 'https://i.postimg.cc/rFzZc19p/image.png'},
    {'name': 'Edgars', 'imageUrl': 'https://i.postimg.cc/xdV6KWVk/image.png'},
    {'name': 'Truworths', 'imageUrl': 'https://i.postimg.cc/VNzjs1cF/image.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Determine the number of cards per row based on screen width
    final crossAxisCount = screenWidth > 1200
        ? 4 // Four cards per row for large screens
        : screenWidth > 800
            ? 3 // Three cards per row for medium screens
            : 2; // Two cards per row for small screens

    return Scaffold(
      appBar: AppBar(
        title: Text('Explore Shops'),
        backgroundColor: Color.fromARGB(255, 64, 177, 113),
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: crossAxisCount, // Dynamic number of cards per row
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: shops.length,
        itemBuilder: (context, index) {
          final shop = shops[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ShopScreen(shopName: shop['name']!),
                ),
              );
            },
            child: Card(
              elevation: 4,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.network(
                    shop['imageUrl']!,
                    height: 80,
                    width: 80,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(Icons.store, size: 80, color: Colors.grey);
                    },
                  ),
                  SizedBox(height: 10),
                  Text(
                    shop['name']!,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

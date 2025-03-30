import 'package:flutter/material.dart';

class CreditsScreen extends StatelessWidget {
  final List<Map<String, String>> credits = [
    {'name': 'John Doe', 'role': 'Developer'},
    {'name': 'Jane Smith', 'role': 'UI/UX Designer'},
    {'name': 'Shoprite', 'role': 'Participating Store'},
    {'name': 'Pick n Pay', 'role': 'Participating Store'},
    {'name': 'Game', 'role': 'Participating Store'},
    {'name': 'Spar', 'role': 'Participating Store'},
  ];

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth > 1200
        ? 4 // Four items per row for large screens
        : screenWidth > 800
            ? 3 // Three items per row for medium screens
            : 2; // Two items per row for small screens

    return Scaffold(
      appBar: AppBar(
        title: Text('Credits'),
        backgroundColor:
            Color.fromARGB(255, 64, 177, 113), // Ensure opaque color
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigate back to the previous screen
          },
        ),
      ),
      body: Container(
        color: Colors.grey[200], // Set body background color to light grey
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount, // Dynamic number of items per row
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: credits.length,
            itemBuilder: (context, index) {
              final credit = credits[index];
              return Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        credit['role'] == 'Participating Store'
                            ? Icons.store
                            : Icons.person,
                        size: 50,
                        color: Colors.grey,
                      ),
                      SizedBox(height: 10),
                      Text(
                        credit['name']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 5),
                      Text(
                        credit['role']!,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

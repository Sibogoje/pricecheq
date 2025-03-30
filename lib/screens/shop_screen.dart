import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import '../data/items_data.dart';

class ShopScreen extends StatefulWidget {
  final String shopName;

  ShopScreen({required this.shopName});

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    // Filter items by shop name
    final shopItems =
        itemsData.where((item) => item['shopName'] == widget.shopName).toList();

    // Group items by category (e.g., based on itemName or other logic)
    final categories =
        shopItems.fold<Map<String, List<Map<String, String>>>>({}, (map, item) {
      final category =
          item['itemName']!.split(' ')[0]; // Use the first word as the category
      map.putIfAbsent(category, () => []).add(item);
      return map;
    });

    // Filter items based on search query and selected category
    final filteredItems = shopItems.where((item) {
      final matchesSearch = _searchQuery.isEmpty ||
          item['itemName']!.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' ||
          item['itemName']!.startsWith(_selectedCategory);
      return matchesSearch && matchesCategory;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
          },
          decoration: InputDecoration(
            hintText: 'Search items...',
            hintStyle: TextStyle(color: Colors.white70),
            border: InputBorder.none,
            icon: Icon(Icons.search, color: Colors.white),
          ),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color.fromARGB(255, 64, 177, 113),
        actions: [
          DropdownButton<String>(
            value: _selectedCategory,
            dropdownColor: Colors.white,
            icon: Icon(Icons.filter_list, color: Colors.white),
            underline: Container(),
            onChanged: (value) {
              setState(() {
                _selectedCategory = value!;
              });
            },
            items: ['All', ...categories.keys].map((category) {
              return DropdownMenuItem<String>(
                value: category,
                child: Text(category),
              );
            }).toList(),
          ),
        ],
      ),
      body: ListView(
        children: filteredItems.map((item) {
          return Card(
            child: ListTile(
              leading: Image.network(
                item['imageUrl']!,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: Colors.red);
                },
              ),
              title: Text(item['itemName']!),
              subtitle: Text('Price: ${item['price']}'),
              trailing: ElevatedButton(
                onPressed: () {
                  final price = double.tryParse(RegExp(r'\d+(\.\d+)?')
                          .firstMatch(item['price']!)
                          ?.group(0) ??
                      '0');
                  if (price != null) {
                    Provider.of<CartProvider>(context, listen: false)
                        .addItem(item['itemName']!, price, item['imageUrl']!);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text('${item['itemName']} added to cart!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                ),
                child: Text('Add to Cart'),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

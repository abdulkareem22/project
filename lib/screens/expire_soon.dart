import 'package:flutter/material.dart';

class Product {
  final String name;
  final DateTime expiryDate;

  Product({required this.name, required this.expiryDate});
}

class ExpireSoonList extends StatefulWidget {
  const ExpireSoonList({Key? key}) : super(key: key);

  @override
  _ExpireSoonListState createState() => _ExpireSoonListState();
}

class _ExpireSoonListState extends State<ExpireSoonList> {
  List<Product> products = [
    Product(name: 'Fruits', expiryDate: DateTime.now().add(Duration(days: 5))),
    Product(name: 'Vegetables', expiryDate: DateTime.now().add(Duration(days: 3))),
    Product(name: 'Meat', expiryDate: DateTime.now().add(Duration(days: 7))),
    // Add more products with different expiry dates
  ];

  String selectedItem = 'All'; // Default selection for dropdown

  bool sortAscending = true; // Default sorting order

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expire Soon List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () {
              _showSortDialog(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                DropdownButton<String>(
                  value: selectedItem,
                  onChanged: (value) {
                    setState(() {
                      selectedItem = value!;
                      _filterAndSortList();
                    });
                  },
                  items: [
                    'All items',
                    'Fruits',
                    'Vegetables',
                    'Meat',
                    // Add more items as needed
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(products[index].name),
                  subtitle: Text('Expiry Date: ${products[index].expiryDate}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showSortDialog(BuildContext context) async {
    await showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sort Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Name (ASC)'),
                onTap: () {
                  _sortListByName(true);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Name (DESC)'),
                onTap: () {
                  _sortListByName(false);
                  Navigator.pop(context);
                },
              ),
              // Add more sorting options as needed
            ],
          ),
        );
      },
    );
  }

  void _sortListByName(bool ascending) {
    setState(() {
      products.sort((a, b) => ascending ? a.name.compareTo(b.name) : b.name.compareTo(a.name));
    });
  }

  void _filterAndSortList() {
    setState(() {
      if (selectedItem == 'All items') {
        // Show all items without filtering
        _sortListByName(true);
      } else {
        // Filter and show items based on selected item
        List<Product> filteredProducts = products.where((product) => product.name == selectedItem).toList();
        _sortListByName(true);
        products = filteredProducts;
      }
    });
  }
}

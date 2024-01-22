// expired_list.dart

import 'package:flutter/material.dart';

class ExpiredList extends StatefulWidget {
  const ExpiredList({Key? key}) : super(key: key);

  @override
  _ExpiredListState createState() => _ExpiredListState();
}

class _ExpiredListState extends State<ExpiredList> {
  List<String> items = [
    
                    'Fruits',
                    'Vegetables',
                    'meat',
                    'Card',
                    'Medicine',
                    'Bakery',
                    'Beauty Products',
   
  ];

  String selectedItem = 'All'; // Default selection for dropdown

  bool sortAscending = true; // Default sorting order

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expired Items List'),
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
                    });
                  },
                  items: [
                    'All items',
                    'Fruits',
                    'Vegetables',
                    'meat',
                    'Card',
                    'Medicine',
                    'Bakery',
                    'Beauty Products',
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
                const SizedBox(width: 16.0),
                Text('Sort by:'),
                const SizedBox(width: 8.0),
                IconButton(
                  icon: sortAscending
                      ? const Icon(Icons.arrow_upward)
                      : const Icon(Icons.arrow_downward),
                  onPressed: () {
                    setState(() {
                      sortAscending = !sortAscending;
                      // Implement your sorting logic here
                      // You can use a function to sort the 'items' list accordingly
                    });
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(items[index]),
                  // Add more details as needed
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showSortDialog(BuildContext context) async {
    // Implement the logic to choose sorting criteria
    // You can use a dialog with radio buttons for sorting options
    // For simplicity, let's just show a dialog with ascending/descending option

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
      // Implement your sorting logic based on the 'ascending' parameter
      // You can use the 'sort' method of the 'items' list
      items.sort((a, b) => ascending ? a.compareTo(b) : b.compareTo(a));
    });
  }
}

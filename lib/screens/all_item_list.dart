import 'package:flutter/material.dart';

class AllItemsList extends StatefulWidget {
  const AllItemsList({Key? key}) : super(key: key);

  @override
  _AllItemsListState createState() => _AllItemsListState();
}

class _AllItemsListState extends State<AllItemsList> {
  List<String> items = [
    'Fruits',
    'Vegetables',
    'Meat',
    'Card',
    'Medicine',
    'Bakery',
    'Beauty Products',
    // Add more items as needed
  ];

  String selectedItem = 'All'; // Default selection for dropdown

  bool sortAscending = true; // Default sorting order

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Items List'),
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
                    'Meat',
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
                      _sortListByName();
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

  void _sortListByName() {
    items.sort((a, b) => sortAscending ? a.compareTo(b) : b.compareTo(a));
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
                  _sortListByName();
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Name (DESC)'),
                onTap: () {
                  _sortListByName();
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
}

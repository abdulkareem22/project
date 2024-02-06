import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  @override
  _InventoryPageState createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  // You can add your inventory data or logic here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inventory'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product 1: Quantity - 10',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Product 2: Quantity - 20',
              style: TextStyle(fontSize: 18),
            ),
            // Add more inventory items as needed
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: InventoryPage(),
  ));
}

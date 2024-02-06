// main.dart
import 'package:flutter/material.dart';
import 'package:expiry_app/screens/add_item.dart';
import 'package:expiry_app/screens/settings.dart';
import 'package:expiry_app/screens/all_item_list.dart';
import 'package:expiry_app/screens/expire_soon.dart';
import 'package:expiry_app/screens/expired_list.dart';
import 'package:expiry_app/screens/inventory.dart';

void main() {
  runApp(const MaterialApp(
    home: WelcomeScreen(),
  ));
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static String id = 'welcome_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Product Expiry App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: ListView(
        children: [
          _buildSection(
            context,
            "All items",
            Icons.bookmark_sharp,
            AllItemsList.id,
          ),
          _buildSection(
            context,
            'Expire Soon',
            Icons.hourglass_empty,
            ExpireSoonList.id,
          ),
          _buildSection(
            context,
            'Expired Items',
            Icons.warning,
            ExpiredItemsList.id,
          ),
          _buildSection(
            context,
            'Items Sold',
            Icons.shopping_cart,
            ItemsSoldList.id,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddItemPage()),
                );
              },
              icon: const Icon(Icons.add),
              label: const Text('Add Items'),
            ),
          ),
        ],
      ),
    );
  }

  ListTile _buildSection(
      BuildContext context, String title, IconData? icon, String route) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      title: SectionTitle(title: title, icon: icon),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;

  const SectionTitle({Key? key, required this.title, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (icon != null) Icon(icon, size: 24, color: Colors.black54),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// expire_soon_list.dart
class ExpireSoonList extends StatelessWidget {
  static String id = 'expire_soon_list';

  const ExpireSoonList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expire Soon List'),
      ),
      body: Container(
        height: 100,
        color: Colors.yellow[100],
        child: const Center(
          child: Text('Expire Soon List'),
        ),
      ),
    );
  }
}

// expired_items_list.dart
class ExpiredItemsList extends StatelessWidget {
  static String id = 'expired_items_list';

  const ExpiredItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Expired Items List'),
      ),
      body: Container(
        height: 100,
        color: Colors.red[100],
        child: const Center(
          child: Text('Expired Items List'),
        ),
      ),
    );
  }
}

// all_items_list.dart
class AllItemsList extends StatelessWidget {
  static String id = 'all_items_list';

  const AllItemsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('All Items List'),
      ),
      body: Container(
        height: 100,
        color: Colors.blueAccent[100],
        child: const Center(
          child: Text('All Items List'),
        ),
      ),
    );
  }
}

// items_sold_list.dart
class ItemsSoldList extends StatelessWidget {
  static String id = 'items_sold_list';

  const ItemsSoldList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Items Sold List'),
      ),
      body: Container(
        height: 100,
        color: Colors.green[100],
        child: const Center(
          child: Text('Items Sold List'),
        ),
      ),
    );
  }
}

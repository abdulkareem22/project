import 'package:flutter/material.dart';
import 'package:expiry_app/screens/add_item.dart';
import 'package:expiry_app/screens/settings.dart';


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
              // Navigate to the SettingsPage when the settings icon is pressed
              // Placeholder for settings action
              // You can add your settings logic here
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
            AllItemsList.id, // Correct route name
          ),
          _buildSection(
            context,
            'Expire Soon',
            Icons.hourglass_empty,
            ExpireSoonList.id, // Correct route name
          ),
          _buildSection(
            context,
            'Expired Items',
            Icons.warning,
            ExpiredItemsList.id, // Correct route name
          ),
          // Button to add items
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AddItemPage()),
                );
                // Placeholder for add items action
                // You can add your add items logic here
              },
              icon: const Icon(Icons.add), // Add your desired icon
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
        // Navigate to different pages based on the tapped section
        Navigator.pushNamed(context, route);
      },
      title: SectionTitle(title: title, icon: icon),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String title;
  final IconData? icon;

  const SectionTitle({Key? key, required this.title, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          if (icon != null) // Conditionally add icon if provided
            Icon(icon, size: 24, color: Colors.black54),
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

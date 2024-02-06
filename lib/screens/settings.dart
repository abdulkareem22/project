// settings.dart

// ignore_for_file: avoid_print

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool receiveNotifications = true;
  String selectedNotificationSound = 'Default Sound';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          SwitchListTile(
            title: const Text('Receive Notifications'),
            value: receiveNotifications ?? true, // Use null-aware operator
            onChanged: (value) {
              setState(() {
                receiveNotifications = value;
              });
            },
          ),
          ListTile(
            title: const Text('Notification Sound'),
            subtitle: Text(selectedNotificationSound),
            onTap: () {
              _showNotificationSoundDialog(context);
            },
          ),
          ListTile(
            title: const Text('Set Notification Date'),
            subtitle: const Text('Tap to select date'),
            onTap: () {
              _selectNotificationDate(context);
            },
          ),
          ListTile(
            title: const Text('Delete All Expired Items'),
            onTap: () {
              _showDeleteConfirmationDialog(context);
            },
          ),
        ],
      ),
    );
  }

  Future<void> _showNotificationSoundDialog(BuildContext context) async {
    final List<String> soundOptions = ['Default Sound', 'Sound 1', 'Sound 2'];

    final String? selectedSound = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Notification Sound'),
          children: soundOptions
              .map(
                (sound) => SimpleDialogOption(
                  onPressed: () {
                    Navigator.pop(context, sound);
                  },
                  child: Text(sound),
                ),
              )
              .toList(),
        );
      },
    );

    if (selectedSound != null) {
      setState(() {
        selectedNotificationSound = selectedSound;
      });
    }
  }

  Future<void> _selectNotificationDate(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      print('Selected Date: $selectedDate');
    }
  }

  Future<void> _showDeleteConfirmationDialog(BuildContext context) async {
    bool? confirmDelete = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete All Expired Items?'),
          content: const Text('This action cannot be undone.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );

    // ignore: duplicate_ignore
    if (confirmDelete == true) {
      
      print('Deleting all expired items...');
      // Implement the logic to delete all expired items
    }
  }
}

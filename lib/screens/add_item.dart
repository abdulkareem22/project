import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

class AddItemPage extends StatefulWidget {
  const AddItemPage({Key? key}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  late ImagePicker _imagePicker;
  XFile? _imageFile;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _expiryDateController = TextEditingController();
  final TextEditingController _reminderController = TextEditingController();
  final TextEditingController _groupController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _manufactureDateController =
      TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _contactController = TextEditingController();

  final List<String> _daysOfWeek = [
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday',
    'Sunday',
  ];

  final List<String> _groups = [
    'Fruits',
    'Vegetables',
    'Meat',
    'Card',
    'Medicine',
    'Bakery',
    'Beauty Products',
  ];

  @override
  void initState() {
    super.initState();
    _imagePicker = ImagePicker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: _getImage,
                child: _imageFile != null
                    ? Image.file(File(_imageFile!.path))
                    : const Icon(
                        Icons.camera_alt,
                        color: Colors.blue,
                        size: 68,
                      ),
              ),
              _buildTextField('Name', _nameController),
              _buildDatePicker('Expiry Date', _expiryDateController),
              _buildDropDown('Reminder', _daysOfWeek, _reminderController),
              _buildDropDown('Group', _groups, _groupController),
              _buildTextField('Note', _noteController),
              _buildTextField('Price', _priceController),
              _buildDatePicker('Manufacture Date', _manufactureDateController),
              _buildTextField('Quantity', _quantityController),
              _buildTextField('Contact', _contactController),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () async {
                      String barcode = await _scanBarcode();
                      _nameController.text = barcode;
                    },
                    icon: const Icon(Icons.qr_code_scanner),
                    label: const Text('Scan Barcode'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _saveItem();
                    },
                    child: const Text('Save Item'),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextField(
              controller: controller,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropDown(
      String label, List<String> items, TextEditingController controller) {
    List<String> selectedDays =
        controller.text.isNotEmpty ? controller.text.split(',').toList() : [];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: DropdownButtonFormField<String>(
              value: null, // Set to null to prevent automatic selection
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Row(
                    children: [
                      Checkbox(
                        value: selectedDays.contains(value),
                        onChanged: (bool? checked) {
                          setState(() {
                            if (checked != null) {
                              if (checked) {
                                selectedDays.add(value);
                              } else {
                                selectedDays.remove(value);
                              }
                              controller.text = selectedDays.join(',');
                            }
                          });
                        },
                      ),
                      Text(value),
                    ],
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                // Do nothing when the overall dropdown value changes
              },
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Text(
              label,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: InkWell(
              onTap: () async {
                DateTime? selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
                if (selectedDate != null) {
                  setState(() {
                    controller.text =
                        '${selectedDate.year}-${selectedDate.month}-${selectedDate.day}';
                  });
                }
              },
              child: IgnorePointer(
                child: TextField(
                  controller: controller,
                  style: const TextStyle(fontSize: 14),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _scanBarcode() async {
    try {
      String barcodeScanResult = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      return barcodeScanResult;
    } catch (e) {
      return 'Error: $e';
    }
  }

  void _getImage() async {
    final XFile? image =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      _imageFile = image;
    });
  }

  void _saveItem() {
    // Add logic to save the item
    // You can access the entered values using _nameController.text, _expiryDateController.text, etc.

    // After saving, navigate to a new page to display saved items
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            const AllItemList(), // Replace with the actual page for displaying saved items
      ),
    );
  }
}

class AllItemList extends StatelessWidget {
  const AllItemList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Items'),
      ),
      body: const Center(
        child: Text('Display saved items here'),
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: AddItemPage(),
  ));
}

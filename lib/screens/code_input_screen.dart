import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:checkingwork/widgets/filtered_dropdown.dart';
import 'package:checkingwork/providers/date_provider.dart';
import 'package:checkingwork/models/record_model.dart';
import 'package:checkingwork/providers/record_provider.dart';
import 'package:checkingwork/widgets/custom_bottom_nav_bar.dart';
import 'package:checkingwork/services/auth_service.dart';

class CodeInputScreen extends StatefulWidget {
  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  String? selectedCategory;
  String? selectedSubcategory;
  String? _hoursQuantity;

  final Map<String, List<String>> categoryMap = {
    'РГ-60': ['ПП', 'ПМ', 'ПР', 'ПВ'],
    'ПД-0-2': ['ИИ', 'ММ', 'ТА', 'ВА'],
    'КА-30': ['MД', 'ЛЛ', 'ДД', 'ВВ'],
  };

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);

    // Checking user autorization
    if (!authService.isLoggedIn()) {
      // If the user is not authorized, redirect him to the login screen
      Future.delayed(Duration.zero, () {
        Navigator.pushReplacementNamed(context, '/login');
      });
      return Scaffold(
        body: Center(child: CircularProgressIndicator()), //Showing a loading indicator during redirection
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Code Input Screen'),
      ),
      body: Column(
        children: [
          // Date picker widget
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Consumer<DateProvider>(
                  builder: (context, dateProvider, children) {
                    return Text(
                      dateProvider.selectedDate != null
                          ? "Selected Date: ${DateFormat('yyyy-MM-dd').format(dateProvider.selectedDate!)}"
                          : "Select a Date",
                      style: TextStyle(fontSize: 16),
                    );
                  },
                ),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: Provider.of<DateProvider>(context, listen: false).selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null) {
                      Provider.of<DateProvider>(context, listen: false).setDate(pickedDate);
                    }
                  },
                  child: Text('Select Date'),
                ),
              ],
            ),
          ),
          // First drop-down list for selecting a category
          FilteredDropdown(
            options: categoryMap.keys.toList(),
            label: 'Select Category',
            value: selectedCategory, // Passing the current value
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
                selectedSubcategory = null;
              });
            },
          ),
          // Second drop-down list for selecting a subcategory
          if (selectedCategory != null)
            FilteredDropdown(
              options: categoryMap[selectedCategory] ?? [],
              label: 'Select Subcategory',
              value: selectedSubcategory, // Passing the current value
              onChanged: (value) {
                setState(() {
                  selectedSubcategory = value;
                });
              },
            ),
          SizedBox(height: 20),
          // Example of an input field for the number of hours
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter hours quantity',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                _hoursQuantity = value;
              },
              controller: TextEditingController(text: _hoursQuantity), // Ensure the field updates correctly
            ),
          ),
          // "Save" button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                DateTime? selectedDate = Provider.of<DateProvider>(context, listen: false).selectedDate;

                if (selectedCategory != null &&
                    selectedSubcategory != null &&
                    selectedDate != null &&
                    _hoursQuantity != null && _hoursQuantity!.isNotEmpty) {
                  final newRecord = RecordModel(
                    category: selectedCategory!,
                    subcategory: selectedSubcategory!,
                    date: selectedDate,
                    hoursQuantity: _hoursQuantity!,
                  );

                  Provider.of<RecordProvider>(context, listen: false).addRecord(newRecord);

                  // Clearing fields after recording
                  setState(() {
                    selectedCategory = null;
                    selectedSubcategory = null;
                    _hoursQuantity = '';
                  });

                  print("Записано: $newRecord");
                } else {
                  print("Пожалуйста, заполните все поля.");
                }
              },
              child: Text('Записать'),
            ),
          ),
          // Display records in a table
          Expanded(
            child: Consumer2<DateProvider, RecordProvider>(
              builder: (context, dateProvider, recordProvider, child) {
                DateTime? selectedDate = dateProvider.selectedDate;
                List<RecordModel> recordsForDate = selectedDate != null
                    ? recordProvider.getRecordsForDate(selectedDate)
                    : [];

                return ListView.builder(
                  itemCount: recordsForDate.length,
                  itemBuilder: (context, index) {
                    RecordModel record = recordsForDate[index];
                    return ListTile(
                      title: Text('${record.category} - ${record.subcategory}'),
                      subtitle: Text('Hours: ${record.hoursQuantity}'),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(currentIndex: 1),
    );
  }
}
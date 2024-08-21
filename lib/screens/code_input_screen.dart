import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:checkingwork/widgets/filtered_dropdown.dart';
import 'package:checkingwork/providers/date_provider.dart';

class CodeInputScreen extends StatefulWidget {
  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  String? selectedCategory;
  String? selectedSubcategory;

  final Map<String, List<String>> categoryMap = {
    'РГ-60': ['ПП', 'ПМ', 'ПР', 'ПВ'],
    'ПД-0-2': ['ИИ', 'ММ', 'ТА', 'ВА'],
    'КА-30': ['MД', 'ЛЛ', 'ДД', 'ВВ'],
  };

  @override
  Widget build(BuildContext context) {
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
                    // Debugging statement
                    print("Current selectedDate: ${dateProvider.selectedDate}");

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
                    selectedDate != null) {
                  print("Записано: $selectedDate, $selectedCategory, $selectedSubcategory");
                } else {
                  print("Пожалуйста, заполните все поля.");
                }
              },
              child: Text('Записать'),
            ),
          ),
        ],
      ),
    );
  }
}
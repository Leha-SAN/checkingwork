import 'package:flutter/material.dart';
import 'package:checkingwork/widgets/filtered_dropdown.dart';

class CodeInputScreen extends StatefulWidget {
  @override
  _CodeInputScreenState createState() => _CodeInputScreenState();
}

class _CodeInputScreenState extends State<CodeInputScreen> {
  String? selectedCategory;
  String? selectedSubcategory;
  DateTime? selectedDate;

  // Категории и подкатегории
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
          // date selection widget
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  selectedDate != null
                      ? "Selected Date: ${selectedDate!.toLocal()}".split(' ')[0]
                      : "Select a Date",
                  style: TextStyle(fontSize: 16),
                ),
                ElevatedButton(
                  onPressed: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2101),
                    );
                    if (pickedDate != null && pickedDate != selectedDate)
                      setState(() {
                        selectedDate = pickedDate;
                      });
                  },
                  child: Text('Select Date'),
                ),
              ],
            ),
          ),
          // first dropdown to select project
          FilteredDropdown(
            options: categoryMap.keys.toList(),
            label: 'Select Category',
            onChanged: (value) {
              setState(() {
                selectedCategory = value;
                selectedSubcategory = null; // drop codes when projectfield changed
              });
            },
          ),
          // second dropdown list with codeslist
          if (selectedCategory != null) // show second widget after selecting first
            FilteredDropdown(
              options: selectedCategory != null
                  ? categoryMap[selectedCategory] ?? []
                  : [],
              label: 'Select Subcategory',
              onChanged: (value) {
                setState(() {
                  selectedSubcategory = value;
                });
              },
            ),
          SizedBox(height: 20),
          // example hours quantity input
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Enter hours quantity',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          // "Save" Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Data recording logic (for example, saving to a database)
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
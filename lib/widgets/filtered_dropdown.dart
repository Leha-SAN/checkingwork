import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class FilteredDropdown extends StatelessWidget {
  final List<String> options;
  final String label;
  final Function(String?)? onChanged;

  FilteredDropdown({
    required this.options,
    required this.label,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownSearch<String>(
        items: options,
        dropdownDecoratorProps: DropDownDecoratorProps(
          dropdownSearchDecoration: InputDecoration(
            labelText: label,
            border: OutlineInputBorder(),
          ),
        ),
        popupProps: PopupProps.menu(
          showSearchBox: true,
          searchFieldProps: TextFieldProps(
            decoration: InputDecoration(
              border: OutlineInputBorder(),
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
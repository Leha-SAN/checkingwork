import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';

class FilteredDropdown extends StatelessWidget {
  final List<String> options;
  final String label;
  final String? value;
  final Function(String?) onChanged;

  const FilteredDropdown({
    required this.options,
    required this.label,
    required this.onChanged,
    this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
        items: options
            .map((option) => DropdownMenuItem(
          value: option,
          child: Text(option),
        ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
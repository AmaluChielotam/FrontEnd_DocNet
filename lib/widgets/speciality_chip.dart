import 'package:flutter/material.dart';

class SpecialtyChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const SpecialtyChip({
    Key? key,
    required this.label,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Color(0xFF2D5B8F),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      selected: isSelected,
      onSelected: (bool value) {
        // Handle selection
      },
      backgroundColor: Colors.white,
      selectedColor: Color(0xFF2D5B8F),
      checkmarkColor: Colors.white,
      side: BorderSide(
        color: isSelected ? Color(0xFF2D5B8F) : Colors.grey[300]!,
      ),
      shape: StadiumBorder(),
    );
  }
}
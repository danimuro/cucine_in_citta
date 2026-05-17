import 'package:flutter/material.dart';

class CitySearchBar extends StatelessWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const CitySearchBar({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20),
      child: TextField(

        controller: controller,
        focusNode: focusNode,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Cerca una città...',
          hintStyle: TextStyle(color: Colors.grey),
          filled: true,
          fillColor: Colors.grey.shade900,
          prefixIcon: Icon(
            Icons.search,
            color: Colors.orange.shade900,
          ),
          suffixIcon: controller.text.isNotEmpty
              ? IconButton(
            icon: Icon(Icons.clear, color: Colors.grey),
            onPressed: onClear,
          )
              : null,
          contentPadding: EdgeInsets.all(18),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(28),
            borderSide: BorderSide(
              color: Colors.white,
              width: 1,
            ),
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
import 'package:flutter/material.dart';

class EmptyCuisinesView extends StatelessWidget {
  final String cityName;
  final VoidCallback onBack;

  const EmptyCuisinesView({
    super.key,
    required this.cityName,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.no_food, color: Colors.grey, size: 52),
          SizedBox(height: 12),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: Text(
              "Nessuna cucina disponibile a $cityName",
              style: TextStyle(color: Colors.grey, fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 20),
          TextButton.icon(
            onPressed: onBack,
            icon: Icon(Icons.arrow_back, color: Colors.orange.shade900),
            label: Text(
              "Cerca un'altra città",
              style: TextStyle(color: Colors.orange.shade900),
            ),
          ),
        ],
      ),
    );
  }
}
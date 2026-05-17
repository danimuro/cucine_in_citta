import 'package:flutter/material.dart';
import '../../data/models/city_suggestions.dart';

class SuggestionsList extends StatelessWidget {
  final List<CitySuggestion> suggestions;
  final ValueChanged<CitySuggestion> onTap;

  const SuggestionsList({
    super.key,
    required this.suggestions,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 20),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: ListView.separated(
                itemCount: suggestions.length,
                separatorBuilder: (_, __) =>
                    Divider(color: Colors.grey.shade800, height: 1),
                itemBuilder: (context, i) {
                  final s = suggestions[i];
                  return Container(
                    color: Colors.grey.shade900,
                    child: ListTile(
                      contentPadding:
                      EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                      title: Text(
                        s.mainText,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      subtitle: Text(
                        s.secondaryText,
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16
                        ),
                      ),
                      trailing: Icon(Icons.arrow_forward_ios,
                          color: Colors.white, size: 16),
                      onTap: () => onTap(s),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
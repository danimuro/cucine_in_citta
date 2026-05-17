import 'package:flutter/material.dart';
import '../../../providers/search_state.dart';

class CityHeader extends StatelessWidget {
  final SearchState state;
  final VoidCallback onBack;

  const CityHeader({
    super.key,
    required this.state,
    required this.onBack,
  });

  String get _mainText => switch (state) {
    SearchCuisinesShown(:final city) => city.mainText,
    SearchLoadingCuisines(:final city) => city.mainText,
    SearchEmptyCuisines(:final city) => city.mainText,
    _ => '',
  };

  String get _secondaryText => switch (state) {
    SearchCuisinesShown(:final city) => city.secondaryText,
    SearchLoadingCuisines(:final city) => city.secondaryText,
    SearchEmptyCuisines(:final city) => city.secondaryText,
    _ => '',
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: onBack,
          ),
          SizedBox(width: 4),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicWidth(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _mainText,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    Container(
                      height: 3,
                      decoration: BoxDecoration(
                        color: Colors.orange.shade900,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 6),
              Text(
                _secondaryText,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
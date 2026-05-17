import 'package:flutter/material.dart';
import '../../data/models/cuisine.dart';

class CuisinesGrid extends StatelessWidget {
  final List<Cuisine> cuisines;

  const CuisinesGrid({super.key, required this.cuisines});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
          child: Text(
            "${cuisines.length} cucine disponibili",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: 0.7,
            ),
            itemCount: cuisines.length,
            itemBuilder: (context, i) => _CuisineCard(cuisine: cuisines[i]),
          ),
        ),
      ],
    );
  }
}

class _CuisineCard extends StatelessWidget {
  final Cuisine cuisine;

  const _CuisineCard({required this.cuisine});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          width: 1,
        ),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 4, left: 4),
              child: Image.network(
                cuisine.imageUrl,
                fit: BoxFit.contain,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.restaurant,
                  color: Colors.white54,
                  size: 40,
                ),
              ),
            ),
          ),
          Text(
            cuisine.nameIt,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 15,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
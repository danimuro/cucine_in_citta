import 'category.dart';

class Product {
  final String id;
  final String title;
  final String description;
  final double price;
  final Category category;
  final List<String> images;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.category,
      required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'].toString(),
      title: json['title'],
      description: json['description'],
      price: (json['price'] as num).toDouble(),
      category: Category(
        id: json['category']['id'],
        name: json['category']['name'],
      ),
      images: List<String>.from(json['images']),
    );
  }
}
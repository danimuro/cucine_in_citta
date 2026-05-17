class Cuisine {
  final int id;
  final String name;
  final String nameIt;
  final String color;
  final String imageUrl;

  const Cuisine({
    required this.id,
    required this.name,
    required this.nameIt,
    required this.color,
    required this.imageUrl,
  });

  factory Cuisine.fromJson(Map<String, dynamic> json) {
    return Cuisine(
      id: json['id'] as int,
      name: json['name'] as String,
      nameIt: json['name_it'] as String? ?? json['name'] as String,
      color: json['color'] as String? ?? '#FF6600',
      imageUrl: json['image_emoji'] as String? ?? '',
    );
  }
}
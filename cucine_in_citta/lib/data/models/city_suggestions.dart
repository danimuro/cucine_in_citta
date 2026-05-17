class CitySuggestion {
  final int id;
  final String name;
  final String description;
  final double latitude;
  final double longitude;
  final String mainText;
  final String secondaryText;

  const CitySuggestion({
    required this.id,
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
    required this.mainText,
    required this.secondaryText,
  });

  factory CitySuggestion.fromJson(Map<String, dynamic> json) {
    final sf = json['structured_formatting'] as Map<String, dynamic>? ?? {};
    return CitySuggestion(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String? ?? '',
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      mainText: sf['main_text'] as String? ?? json['name'] as String,
      secondaryText: sf['secondary_text'] as String? ?? '',
    );
  }
}
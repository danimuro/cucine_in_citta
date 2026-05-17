import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/city_suggestions.dart';
import '../models/cuisine.dart';

class BestieBiteRepository {
  static const _baseUrl = 'https://api.bestiebite.com';
  final http.Client _client;

  BestieBiteRepository({http.Client? client})
      : _client = client ?? http.Client();

  Future<List<CitySuggestion>> autocomplete(String term) async {
    if (term.length < 2) return [];

    final uri = Uri.parse('$_baseUrl/places/v2/autocomplete').replace(
      queryParameters: {
        'term': term,
        'lang': 'it',
        'limit': '8',
      },
    );

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Autocomplete error: ${response.statusCode}');
    }

    final List<dynamic> json = jsonDecode(response.body);
    return json.map((e) => CitySuggestion.fromJson(e)).toList();
  }

  Future<List<Cuisine>> getCuisines(double lat, double lng) async {
    final uri = Uri.parse('$_baseUrl/places/labels/by-location-and-type').replace(
      queryParameters: {
        'lat': lat.toStringAsFixed(6),
        'lng': lng.toStringAsFixed(6),
        'type': 'cuisine',
      },
    );

    final response = await _client.get(uri);
    if (response.statusCode != 200) {
      throw Exception('Cuisines error: ${response.statusCode}');
    }

    final Map<String, dynamic> json = jsonDecode(response.body);
    final List<dynamic> data = json['data'] ?? [];
    return data.map((e) => Cuisine.fromJson(e)).toList();
  }
}
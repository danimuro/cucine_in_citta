import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'product.dart';

// prima il contratto
abstract class ProductsRepository {
  Future<List<Product>> getProducts();
}

// poi l'implementazione reale
class HttpProductsRepository implements ProductsRepository {
  final http.Client client;

  HttpProductsRepository({required this.client});

  @override
  Future<List<Product>> getProducts() async {
    final response = await client.get(
      Uri.parse('https://api.escuelajs.co/api/v1/products'),
    );

    if (response.statusCode != 200) {
      throw Exception('Errore nel caricamento prodotti');
    }

    final list = jsonDecode(response.body) as List;
    return list.map((e) => Product.fromJson(e)).toList();
  }
}

// provider del repository — crei il client qui, una volta sola
final productsRepositoryProvider = Provider<ProductsRepository>((ref) {
  return HttpProductsRepository(client: http.Client());
});
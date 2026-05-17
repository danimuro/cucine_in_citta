import 'package:apicall_flutter/data/products_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/product.dart';

class ProductsNotifier extends AsyncNotifier<List<Product>> {


  @override
  Future<List<Product>> build() async {
  return ref.read(productsRepositoryProvider).getProducts();
  }

  Future<void> reload() async {
  ref.invalidateSelf();
  }
}

final productsNotifierProvider = AsyncNotifierProvider<ProductsNotifier, List<Product>>(
  ProductsNotifier.new,
);
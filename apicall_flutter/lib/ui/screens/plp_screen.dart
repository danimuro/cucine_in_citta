import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../providers/products_notifier.dart';
import '../../resources/strings.dart';

class PLPView extends ConsumerWidget {
  const PLPView({super.key});


  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final state = ref.watch(productsNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.menu, color: Colors.blue),
              onPressed: () {},
            ),
            const Text(
              AppStrings.PLPTitle,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            const Spacer(),
            IconButton(
              icon: const Icon(Icons.shopping_cart, color: Colors.blue),
              onPressed: () => context.push('/cart'),
            ),
          ],
        ),
      ),

      body: state.when(
        loading: () => Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Errore'),
              TextButton(
                onPressed: () => ref.read(productsNotifierProvider.notifier).reload(),
                child: Text('Riprova'),
              ),
            ],
          ),
        ),
        data: (products) => ListView.builder(
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return InkWell(
              onTap: () => context.push("/product", extra: product),
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          product.images.first,
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product.title,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '\$${product.price}',
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.blue,
                              ),
                            ),


                          ],
                        ),

                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                      )
                    ],
                  ),
                ),

              ),
            );
          },
        ),
      )
    );
  }
}


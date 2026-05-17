import 'package:go_router/go_router.dart';

import '../data/product.dart';
import '../ui/screens/cart_screens.dart';
import '../ui/screens/pdp_screen.dart';
import '../ui/screens/plp_screen.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PLPView(),
    ),
    GoRoute(
      path: '/product',
      builder: (context, state) {
        final product = state.extra as Product;
        return PdpScreen(product: product);
      },
    ),
    GoRoute(
      path: '/cart',
      builder: (context, state) => const CartScreen(),
    ),
  ],
);
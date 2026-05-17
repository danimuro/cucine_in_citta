import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/repositories/bestie_bite_repository.dart';

final repositoryProvider = Provider<BestieBiteRepository>((ref) {
  return BestieBiteRepository();
});
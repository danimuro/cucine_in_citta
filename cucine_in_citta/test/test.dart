import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:cucine_in_citta/data/repositories/bestie_bite_repository.dart';

void main() {
  group('BestieBiteRepository', () {

    test('autocomplete ritorna città corretta', () async {
      final mockClient = MockClient((request) async {
        return http.Response(
          jsonEncode([
            {
              'id': 8047,
              'name': 'Milano',
              'description': 'Milano, Lombardia, Italia',
              'latitude': 45.4612939,
              'longitude': 9.172356,
              'country_code': 'IT',
              'structured_formatting': {
                'main_text': 'Milano',
                'secondary_text': 'Lombardia, Italia',
              }
            }
          ]),
          200,
        );
      });

      final repo = BestieBiteRepository(client: mockClient);
      final results = await repo.autocomplete('mila');

      expect(results.length, 1);
      expect(results.first.name, 'Milano');
    });

    test('autocomplete ritorna vuoto per term corto', () async {
      final repo = BestieBiteRepository();
      final results = await repo.autocomplete('m');
      expect(results, isEmpty);
    });

    test('autocomplete lancia eccezione su errore API', () async {
      final mockClient = MockClient((request) async {
        return http.Response('error', 500);
      });

      final repo = BestieBiteRepository(client: mockClient);
      expect(() => repo.autocomplete('milano'), throwsException);
    });

  });
}
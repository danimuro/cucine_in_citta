import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/city_suggestions.dart';
import '../data/repositories/bestie_bite_repository.dart';
import 'repository_provider.dart';
import 'search_state.dart';

class SearchNotifier extends StateNotifier<SearchState> {
  final BestieBiteRepository _repo;
  Timer? _debounce;

  SearchNotifier(this._repo) : super(const SearchIdle());

  void onQueryChanged(String query) {
    _debounce?.cancel();

    if (query.isEmpty) {
      state = const SearchIdle();
      return;
    }

    if (query.length < 2) {
      state = const SearchNoResults();
      return;
    }

    state = const SearchTyping();

    _debounce = Timer(const Duration(milliseconds: 1000), () {
      _fetchSuggestions(query);
    });
  }

  Future<void> _fetchSuggestions(String query) async {
    try {
      final suggestions = await _repo.autocomplete(query);
      if (suggestions.isEmpty) {
        state = const SearchNoResults();
      } else {
        state = SearchSuggestions(suggestions);
      }
    } catch (e) {
      state = SearchError(
        message: 'Errore nella ricerca. Riprova.',
        retry: () => _fetchSuggestions(query),
      );
    }
  }

  Future<void> onCitySelected(CitySuggestion city) async {
    state = SearchLoadingCuisines(city);
    try {
      final cuisines = await _repo.getCuisines(city.latitude, city.longitude);
      if (cuisines.isEmpty) {
        state = SearchEmptyCuisines(city);
      } else {
        state = SearchCuisinesShown(city: city, cuisines: cuisines);
      }
    } catch (e) {
      state = SearchError(
        message: 'Errore nel caricamento delle cucine.',
        retry: () => onCitySelected(city),
      );
    }
  }

  void reset() {
    _debounce?.cancel();
    state = const SearchIdle();
  }

  @override
  void dispose() {
    _debounce?.cancel();
    super.dispose();
  }
}

final searchProvider = StateNotifierProvider<SearchNotifier, SearchState>((ref) {
  return SearchNotifier(ref.watch(repositoryProvider));
});
import 'dart:ui';

import '../data/models/city_suggestions.dart';
import '../data/models/cuisine.dart';

sealed class SearchState {
  const SearchState();
}

class SearchIdle extends SearchState {
  const SearchIdle();
}

class SearchTyping extends SearchState {
  const SearchTyping();
}

class SearchSuggestions extends SearchState {
  final List<CitySuggestion> suggestions;
  const SearchSuggestions(this.suggestions);
}

class SearchNoResults extends SearchState {
  const SearchNoResults();
}

class SearchLoadingCuisines extends SearchState {
  final CitySuggestion city;
  const SearchLoadingCuisines(this.city);
}

class SearchCuisinesShown extends SearchState {
  final CitySuggestion city;
  final List<Cuisine> cuisines;
  const SearchCuisinesShown({required this.city, required this.cuisines});
}

class SearchEmptyCuisines extends SearchState {
  final CitySuggestion city;
  const SearchEmptyCuisines(this.city);
}

class SearchError extends SearchState {
  final String message;
  final VoidCallback retry;
  const SearchError({required this.message, required this.retry});
}
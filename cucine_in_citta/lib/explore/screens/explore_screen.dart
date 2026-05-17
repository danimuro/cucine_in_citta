import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/search_notifier.dart';
import '../../providers/search_state.dart';
import '../widgets/city_header.dart';
import '../widgets/cuisines_grid.dart';
import '../widgets/search_bar.dart';
import '../widgets/suggestion_list.dart';
import '../widgets/idle_view.dart';
import '../widgets/loading_view.dart';
import '../widgets/no_results_view.dart';
import '../widgets/empty_cuisines_view.dart';
import '../widgets/error_view.dart';

class ExploreScreen extends ConsumerStatefulWidget {
  const ExploreScreen({super.key});

  @override
  ConsumerState<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends ConsumerState<ExploreScreen> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _reset() {
    _controller.clear();
    setState(() {});
    ref.read(searchProvider.notifier).reset();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(searchProvider);
    final isCuisineView = state is SearchCuisinesShown ||
        state is SearchLoadingCuisines ||
        state is SearchEmptyCuisines;

    return Scaffold(
      backgroundColor: Colors.black,

      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 20),
              if (!isCuisineView)
                Text(
                  "Cucine in Città",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 35,
                  ),
                )
              else
                CityHeader(state: state, onBack: _reset),
              SizedBox(height: 20),
              if (!isCuisineView)
                CitySearchBar(
                  controller: _controller,
                  focusNode: _focusNode,
        
                  onChanged: (value) {
                    setState(() {});
                    ref.read(searchProvider.notifier).onQueryChanged(value);
                  },
                  onClear: _reset,
                ),
              Expanded(
                child: switch (state) {
                  SearchIdle() => IdleView(),
                  SearchTyping() => LoadingView(),
                  SearchSuggestions(:final suggestions) => SuggestionsList(
                    suggestions: suggestions,
                    onTap: (city) {
                      _focusNode.unfocus();
                      ref.read(searchProvider.notifier).onCitySelected(city);
                    },
                  ),
                  SearchNoResults() => NoResultsView(),
                  SearchLoadingCuisines() =>
                      LoadingView(message: "Caricamento cucine..."),
                  SearchCuisinesShown(:final cuisines) =>
                      CuisinesGrid(cuisines: cuisines),
                  SearchEmptyCuisines(:final city) =>
                      EmptyCuisinesView(cityName: city.mainText, onBack: _reset),
                  SearchError(:final message, :final retry) =>
                      ErrorView(message: message, onRetry: retry),
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
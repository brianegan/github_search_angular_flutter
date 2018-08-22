import 'dart:async';

import 'package:github_search_common/src/data/github_service.dart';
import 'package:github_search_common/src/ui/search_state.dart';
import 'package:rxdart/rxdart.dart';

class SearchBloc {
  final Sink<String> _textChangedSink;
  final Stream<SearchState> state;

  Function(String) get onTextChanged => _textChangedSink.add;

  factory SearchBloc(GithubService service) {
    final onTextChanged = PublishSubject<String>();

    final state = onTextChanged
        // If the text has not changed, do not perform a new search
        .distinct()
        // Wait for the user to stop typing for 250ms before running a search
        .debounce(const Duration(milliseconds: 250))
        // Call the Github api with the given search term and convert it to a
        // State. If another search term is entered, flatMapLatest will ensure
        // the previous search is discarded so we don't deliver stale results
        // to the View.
        .switchMap<SearchState>((String term) => _search(term, service))
        // Kick the whole thing off with an initial "No Term" state
        .startWith(SearchState.noTermFactory(SearchNoTerm()));

    return SearchBloc._(onTextChanged, state);
  }

  SearchBloc._(this._textChangedSink, this.state);

  void dispose() {
    _textChangedSink.close();
  }

  // The search function emits the current state of the Search as a Stream of
  // items: No Term, Loading, Populated, Empty, or Error.
  static Stream<SearchState> _search(
    String term,
    GithubService service,
  ) async* {
    if (term.isEmpty) {
      yield SearchState.noTermFactory(SearchNoTerm());
    } else {
      yield SearchState.loadingFactory(SearchLoading());

      try {
        final result = await service.search(term);

        if (result.isEmpty) {
          yield SearchState.emptyFactory(SearchEmpty());
        } else {
          yield SearchState.populatedFactory(SearchPopulated(result: result));
        }
      } catch (e) {
        yield SearchState.errorFactory(SearchError(message: '$e'));
      }
    }
  }
}

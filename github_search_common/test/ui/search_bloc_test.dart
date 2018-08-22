import 'dart:async';

import 'package:github_search_common/github_search_common.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../utils.dart';

class MockRepository extends Mock implements GithubService {}

void main() {
  group('SearchBloc', () {
    test('starts with an initial no term state', () {
      final service = MockRepository();
      final bloc = SearchBloc(service);

      expect(
        bloc.state,
        emitsInOrder([noTerm]),
      );
    });

    test('emits a loading state then result state when service call succeeds',
        () {
      final service = MockRepository();
      final bloc = SearchBloc(service);

      when(service.search('T')).thenAnswer((_) async => searchResult);

      scheduleMicrotask(() {
        bloc.onTextChanged('T');
      });

      expect(
        bloc.state,
        emitsInOrder([noTerm, loading, populated]),
      );
    });

    test('cancels the previous search', () {
      final service = MockRepository();
      final bloc = SearchBloc(service);

      when(service.search('T')).thenAnswer((_) async => searchResult);
      when(service.search('U'))
          .thenAnswer((_) async => SearchResult(items: []));

      scheduleMicrotask(() {
        bloc.onTextChanged('T');
        bloc.onTextChanged('U');
      });

      expect(
        bloc.state,
        emitsInOrder([noTerm, loading, empty]),
      );
    });

    test('emits a no term state when user provides an empty search term', () {
      final service = MockRepository();
      final bloc = SearchBloc(service);

      scheduleMicrotask(() {
        bloc.onTextChanged('');
      });

      expect(
        bloc.state,
        emitsInOrder([noTerm, noTerm]),
      );
    });

    test('emits an empty state when no results are returned', () {
      final service = MockRepository();
      final bloc = SearchBloc(service);

      when(service.search('T'))
          .thenAnswer((_) async => SearchResult(items: []));

      scheduleMicrotask(() {
        bloc.onTextChanged('T');
      });

      expect(
        bloc.state,
        emitsInOrder([noTerm, loading, empty]),
      );
    });

    test('throws an error when the backend errors', () {
      final service = MockRepository();
      final bloc = SearchBloc(service);

      when(service.search('T')).thenThrow(Exception());

      scheduleMicrotask(() {
        bloc.onTextChanged('T');
      });

      expect(
        bloc.state,
        emitsInOrder([noTerm, loading, error]),
      );
    });

    test('closes the stream on dispose', () {
      final service = MockRepository();
      final bloc = SearchBloc(service);

      scheduleMicrotask(() {
        bloc.dispose();
      });

      expect(
        bloc.state,
        emitsInOrder([noTerm, emitsDone]),
      );
    });
  });
}

final noTerm = predicate<SearchState>((state) => state.noTermSet);

final loading = predicate<SearchState>((state) => state.loadingSet);

final empty = predicate<SearchState>((state) => state.emptySet);

final populated = predicate<SearchState>((state) => state.populatedSet);

final error = predicate<SearchState>((state) => state.errorSet);

import 'package:github_search_common/github_search_common.dart';
import 'package:test/test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../utils.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  group('GithubCache', () {
    test('should save results based on the term', () async {
      final cache = GithubCache();
      final result = searchResult;

      cache.set('A', result);

      expect(cache.get('A'), result);
    });

    test('should remove values', () async {
      final cache = GithubCache();

      cache.set('A', searchResult);
      cache.remove('A');

      expect(cache.get('A'), isNull);
    });

    test('should determine if a term is cached', () async {
      final cache = GithubCache();
      final result = searchResult;

      expect(cache.contains('A'), isFalse);

      cache.set('A', result);

      expect(cache.contains('A'), isTrue);
    });
  });
}

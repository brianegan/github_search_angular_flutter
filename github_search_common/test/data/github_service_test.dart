import 'package:github_search_common/github_search_common.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import '../utils.dart';

class MockClient extends Mock implements GithubClient {}

void main() {
  group('GithubService', () {
    test('should load from the cache', () async {
      final cache = GithubCache();
      final client = MockClient();
      final service = GithubService(cache, client);
      final result = searchResult;

      cache.set('A', result);

      expect(await service.search('A'), result);
      verifyNever(client.search('A'));
    });

    test('falls back to the client if the result is not cached', () async {
      final cache = GithubCache();
      final client = MockClient();
      final service = GithubService(cache, client);
      final result = searchResult;

      when(client.search(('A'))).thenAnswer((_) async => result);

      expect(await service.search('A'), result);
      verify(client.search('A'));
    });

    test('caches the result after fetching from the client', () async {
      final cache = GithubCache();
      final client = MockClient();
      final service = GithubService(cache, client);
      final result = searchResult;

      when(client.search(('A'))).thenAnswer((_) async => result);

      expect(await service.search('A'), result);
      expect(cache.get('A'), result);
    });
  });
}

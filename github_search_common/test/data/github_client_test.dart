import 'dart:io';

import 'package:github_search_common/github_search_common.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  String fixture(String name) =>
      File('test/data/fixtures/$name.json').readAsStringSync();

  group('GithubClient', () {
    test('should fetch and parse results from the api', () async {
      final client = GithubClient(
        MockClient((_) async => Response(fixture('search_results'), 200)),
      );
      final result = await client.search('yo');
      final item = result.items.first;

      expect(result.items.length, 3);
      expect(item, TypeMatcher<SearchResultItem>());
      expect(item.full_name, 'yeoman/yo');
      expect(item.html_url, 'https://github.com/yeoman/yo');
      expect(item.owner.login, 'yeoman');
      expect(
        item.owner.avatar_url,
        'https://avatars0.githubusercontent.com/u/1714870?v=4',
      );
    });

    test('should throw an error on bad status code', () {
      final client = GithubClient(
        MockClient((_) async => Response(fixture('search_error'), 403)),
      );

      expect(
        client.search('yo'),
        throwsA(TypeMatcher<SearchResultError>()),
      );
    });
  });
}

import 'dart:async';

import 'package:github_search_common/src/data/entities.dart';
import 'package:github_search_common/src/data/github_cache.dart';
import 'package:github_search_common/src/data/github_client.dart';

class GithubService {
  final GithubCache cache;
  final GithubClient client;

  GithubService(this.cache, this.client);

  Future<SearchResult> search(String term) async {
    if (cache.contains(term)) {
      return cache.get(term);
    } else {
      final result = await client.search(term);

      cache.set(term, result);

      return result;
    }
  }
}

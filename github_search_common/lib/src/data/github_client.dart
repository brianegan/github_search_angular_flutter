import 'dart:async';
import 'dart:convert';

import 'package:github_search_common/src/data/entities.dart';
import 'package:http/http.dart' as http;

class GithubClient {
  final String baseUrl;
  final http.Client client;

  GithubClient(
    http.Client client, {
    this.baseUrl = "https://api.github.com/search/repositories?q=",
  }) : this.client = client ?? http.Client();

  /// Search Github for repositories using the given term
  Future<SearchResult> search(String term) async {
    final response = await client.get(Uri.parse("$baseUrl$term"));
    final results = json.decode(response.body);

    if (response.statusCode == 200) {
      return SearchResultMetaJson.fromJson(results);
    } else {
      throw SearchResultErrorMetaJson.fromJson(results);
    }
  }
}

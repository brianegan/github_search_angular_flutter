import 'package:github_search_common/github_search_common.dart';

SearchResult get searchResult {
  return SearchResult(
    items: [
      SearchResultItem(
        full_name: 'Hi',
        html_url: 'there',
        owner: GithubUser(login: 'Test', avatar_url: 'user'),
      )
    ],
  );
}

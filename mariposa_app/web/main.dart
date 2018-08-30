import 'dart:html';

import 'package:github_search_common/github_search_common.dart';
import 'package:http/browser_client.dart';
import 'package:mariposa/dom.dart' as mariposa;
import 'package:mariposa_app/search_screen.dart';

void main() {
  final SearchBloc bloc = SearchBloc(
    GithubService(
      GithubCache(),
      GithubClient(BrowserClient()),
    ),
  );

  mariposa.render(SearchScreen(bloc), querySelector('#app'));
}

import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:angular_dart_app/src/github_search/search_results_component.dart';
import 'package:github_search_common/github_search_common.dart';
import 'package:http/browser_client.dart';

@Component(
  selector: 'github-search',
  templateUrl: 'github_search_component.html',
  directives: [
    materialInputDirectives,
    coreDirectives,
    SearchResultsComponent,
  ],
  pipes: [commonPipes],
)
class GithubSearchComponent {
  final SearchBloc bloc = SearchBloc(
    GithubService(
      GithubCache(),
      GithubClient(BrowserClient()),
    ),
  );
}

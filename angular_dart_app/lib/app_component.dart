import 'package:angular/angular.dart';

import 'src/github_search/github_search_component.dart';

@Component(
  selector: 'github-search-app',
  template: '<github-search></github-search>',
  directives: [GithubSearchComponent],
)
class AppComponent {}

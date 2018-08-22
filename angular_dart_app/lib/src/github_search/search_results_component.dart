import 'package:angular/angular.dart';
import 'package:angular_components/angular_components.dart';
import 'package:github_search_common/github_search_common.dart';

@Component(
  selector: 'search-results',
  templateUrl: 'search_results_component.html',
  directives: [
    materialInputDirectives,
    coreDirectives,
    MaterialSpinnerComponent,
    MaterialIconComponent,
  ],
)
class SearchResultsComponent {
  @Input()
  SearchState state;
}

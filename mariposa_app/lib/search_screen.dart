import 'package:github_search_common/github_search_common.dart';
import 'package:html_builder/elements.dart';
import 'package:mariposa/mariposa.dart';
import 'package:mariposa_app/search_input.dart';
import 'package:mariposa_app/search_results.dart';

Node SearchScreen(SearchBloc bloc) {
  return Div(children: [
    Heading.h1(child: Text('Github Search')),
    SearchInput(onTextChanged: bloc.onTextChanged),
    SearchResults(bloc.state),
  ]);
}

import 'dart:async';

import 'package:github_search_common/github_search_common.dart';
import 'package:html_builder/elements.dart';
import 'package:mariposa/mariposa.dart';
import 'package:mariposa_app/async.dart';

Node SearchResults(Stream<SearchState> state) {
  return Div(children: [
    StreamBuilder<SearchState>(
      initialData: SearchState.noTermFactory(SearchNoTerm()),
      stream: state,
      builder: (context, snapshot) {
        return snapshot.data.when(
          loading: (SearchLoading loading) {
            return Div(className: 'center', children: [
              Div(className: 'lds-ring', children: [Div(), Div(), Div()])
            ]);
          },
          error: (SearchError error) {
            return Div(className: 'tc', children: [
              i(className: 'material-icons light-red', c: [Text('error')]),
              Paragraph(children: [Text('Error: Rate Limit Exceeded')]),
            ]);
          },
          noTerm: (SearchNoTerm noTerm) {
            return Div(className: 'tc', children: [
              i(className: 'material-icons light-blue', c: [Text('info')]),
              Paragraph(children: [Text('Please enter a term to begin')]),
            ]);
          },
          populated: (SearchPopulated populated) {
            return Section(children: [
              ul(
                className: 'list pa0 ma0',
                c: populated.result.items.map(SearchItem),
              )
            ]);
          },
          empty: (SearchEmpty empty) {
            return Div(className: 'tc', children: [
              i(
                className: 'material-icons light-yellow',
                c: [Text('warning')],
              ),
              Paragraph(children: [Text('No Results')]),
            ]);
          },
        );
      },
    ),
  ]);
}

Node SearchItem(SearchResultItem item) {
  return LI(
    className: 'pa2 cf',
    children: [
      Div(
        className: 'fl w-10 h-auto',
        children: [img(alt: item.full_name, src: item.owner.avatar_url)],
      ),
      Div(
        className: 'fl w-90 ph3',
        children: [
          Heading.h1(child: Text(item.full_name), className: 'f5 ma0'),
          p(c: [
            a(
              href: item.html_url,
              className: 'light-blue',
              target: '_blank',
              c: [Text('${item.html_url}')],
            )
          ]),
        ],
      )
    ],
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_github_search/empty_view.dart';
import 'package:flutter_github_search/error_view.dart';
import 'package:flutter_github_search/intro_view.dart';
import 'package:flutter_github_search/loading_view.dart';
import 'package:flutter_github_search/populated_view.dart';
import 'package:github_search_common/github_search_common.dart';
import 'package:http/http.dart';

// The View in a Stream-based architecture takes two arguments: The State Stream
// and the onTextChanged callback. In our case, the onTextChanged callback will
// emit the latest String to a Stream<String> whenever it is called.
//
// The State will use the Stream<String> to send new search requests to the
// GithubApi.
class SearchScreen extends StatefulWidget {
  final GithubService service;

  SearchScreen({Key key, GithubService service})
      : this.service = service ??
            GithubService(
              GithubCache(),
              GithubClient(
                IOClient(),
              ),
            ),
        super(key: key);

  @override
  SearchScreenState createState() {
    return SearchScreenState();
  }
}

class SearchScreenState extends State<SearchScreen> {
  SearchBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = SearchBloc(widget.service);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<SearchState>(
      stream: bloc.state,
      initialData: SearchState.noTermFactory(SearchNoTerm()),
      builder: (BuildContext context, AsyncSnapshot<SearchState> snapshot) {
        final state = snapshot.data;

        return Scaffold(
          body: Stack(
            children: <Widget>[
              Flex(direction: Axis.vertical, children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(16.0, 24.0, 16.0, 4.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search Github...',
                    ),
                    style: TextStyle(
                      fontSize: 36.0,
                      fontFamily: "Hind",
                      decoration: TextDecoration.none,
                    ),
                    onChanged: bloc.onTextChanged,
                  ),
                ),
                Expanded(
                  child: Stack(
                    children: <Widget>[
                      // Fade in an intro screen if no term has been entered
                      NoTermView(visible: state.noTermSet),

                      // Fade in an Empty Result screen if the search contained
                      // no items
                      EmptyView(visible: state.emptySet),

                      // Fade in a loading screen when results are being fetched
                      // from Github
                      LoadingView(visible: state.loadingSet),

                      // Fade in an error if something went wrong when fetching
                      // the results
                      ErrorView(visible: state.errorSet),

                      // Fade in the Result if available
                      PopulatedView(
                        items: state.populatedSet
                            ? state.populated.result.items
                            : [],
                      ),
                    ],
                  ),
                )
              ])
            ],
          ),
        );
      },
    );
  }
}

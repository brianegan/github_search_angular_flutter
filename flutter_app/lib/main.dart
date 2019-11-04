import 'package:flutter/material.dart';
import 'package:flutter_github_search/search_screen.dart';
import 'package:github_search_common/github_search_common.dart';
import 'package:http/http.dart';

void main() {
  runApp(
    SearchApp(service: GithubService(GithubCache(), GithubClient(Client()))),
  );
}

class SearchApp extends StatefulWidget {
  final GithubService service;

  SearchApp({Key key, this.service}) : super(key: key);

  @override
  _RxDartGithubSearchAppState createState() => _RxDartGithubSearchAppState();
}

class _RxDartGithubSearchAppState extends State<SearchApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RxDart Github Search',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.grey,
      ),
      home: SearchScreen(service: widget.service),
    );
  }
}

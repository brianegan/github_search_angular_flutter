# github_search_common

A pure-Dart library that provides the data layer and BLoC for a Github Search Experience. Can be used for Flutter and Web Dart projects.

## Updating the Entities and States

This project uses [meta_types](https://pub.dartlang.org/packages/meta_types) packages for Data Classes, Sealed Classes, and JSON Parsing.

If you change the entities or search states, you'll need to rebuild the generated files by running the following command in the root of the project:

`pub run build_runner watch`

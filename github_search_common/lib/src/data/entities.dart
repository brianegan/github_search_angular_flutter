import 'package:meta_types/meta_types.dart';
import 'package:meta_types_json/meta_types_json.dart';

part 'entities.g.dart';

@MetaJson()
@DataClass()
abstract class $SearchResult {
  List<$SearchResultItem> get items;

  bool get isPopulated => items.isNotEmpty;

  bool get isEmpty => items.isEmpty;
}

@MetaJson()
@DataClass()
abstract class $SearchResultItem {
  String get full_name;
  String get html_url;
  $GithubUser get owner;
}

@MetaJson()
@DataClass()
abstract class $GithubUser {
  String get login;
  String get avatar_url;
}

@MetaJson()
@DataClass()
abstract class $SearchResultError {
  String get message;
}

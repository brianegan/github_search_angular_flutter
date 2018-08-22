import 'package:github_search_common/src/data/entities.dart';
import 'package:meta_types/meta_types.dart';

part 'search_state.g.dart';

@SealedClass()
abstract class $SearchState {
  SearchLoading get loading;
  $SearchError get error;
  SearchNoTerm get noTerm;
  $SearchPopulated get populated;
  SearchEmpty get empty;
}

class SearchLoading {}

@DataClass()
abstract class $SearchError {
  String get message;
}

class SearchNoTerm {}

@DataClass()
abstract class $SearchPopulated {
  $SearchResult get result;
}

class SearchEmpty {}

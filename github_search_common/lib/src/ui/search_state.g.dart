// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_state.dart';

// **************************************************************************
// MetaTypesGenerator
// **************************************************************************

class SearchState extends _SearchStateBase {
  final SearchLoading _loading;
  final bool _loadingSet;

  final SearchError _error;
  final bool _errorSet;

  final SearchNoTerm _noTerm;
  final bool _noTermSet;

  final SearchPopulated _populated;
  final bool _populatedSet;

  final SearchEmpty _empty;
  final bool _emptySet;

  SearchState.loadingFactory(this._loading)
      : _errorSet = false,
        _error = null,
        _noTermSet = false,
        _noTerm = null,
        _populatedSet = false,
        _populated = null,
        _emptySet = false,
        _empty = null,
        _loadingSet = true;

  SearchState.errorFactory(this._error)
      : _loadingSet = false,
        _loading = null,
        _noTermSet = false,
        _noTerm = null,
        _populatedSet = false,
        _populated = null,
        _emptySet = false,
        _empty = null,
        _errorSet = true;

  SearchState.noTermFactory(this._noTerm)
      : _loadingSet = false,
        _loading = null,
        _errorSet = false,
        _error = null,
        _populatedSet = false,
        _populated = null,
        _emptySet = false,
        _empty = null,
        _noTermSet = true;

  SearchState.populatedFactory(this._populated)
      : _loadingSet = false,
        _loading = null,
        _errorSet = false,
        _error = null,
        _noTermSet = false,
        _noTerm = null,
        _emptySet = false,
        _empty = null,
        _populatedSet = true;

  SearchState.emptyFactory(this._empty)
      : _loadingSet = false,
        _loading = null,
        _errorSet = false,
        _error = null,
        _noTermSet = false,
        _noTerm = null,
        _populatedSet = false,
        _populated = null,
        _emptySet = true;

  SearchLoading get loading => _loading;
  bool get loadingSet => _loadingSet;

  SearchError get error => _error;
  bool get errorSet => _errorSet;

  SearchNoTerm get noTerm => _noTerm;
  bool get noTermSet => _noTermSet;

  SearchPopulated get populated => _populated;
  bool get populatedSet => _populatedSet;

  SearchEmpty get empty => _empty;
  bool get emptySet => _emptySet;

  W when<W>({
    @required W loading(SearchLoading loading),
    @required W error(SearchError error),
    @required W noTerm(SearchNoTerm noTerm),
    @required W populated(SearchPopulated populated),
    @required W empty(SearchEmpty empty),
  }) {
    if (_loadingSet) return loading(this.loading);
    if (_errorSet) return error(this.error);
    if (_noTermSet) return noTerm(this.noTerm);
    if (_populatedSet) return populated(this.populated);
    return empty(this.empty);
  }

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! SearchState) return false;
    return loading == other.loading &&
        error == other.error &&
        noTerm == other.noTerm &&
        populated == other.populated &&
        empty == other.empty;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, loading.hashCode), error.hashCode), noTerm.hashCode),
            populated.hashCode),
        empty.hashCode));
  }
}

abstract class _SearchStateBase extends SealedClass {
  SearchLoading get loading;
  SearchError get error;
  SearchNoTerm get noTerm;
  SearchPopulated get populated;
  SearchEmpty get empty;
  bool get loadingSet;

  bool get errorSet;

  bool get noTermSet;

  bool get populatedSet;

  bool get emptySet;
  @override
  Iterable<ComputedField> get computedFields => [];

  @override
  Iterable<SealedClassField> get unionFields => [
        new SealedClassField<SearchLoading>("loading"),
        new SealedClassField<SearchError>("error"),
        new SealedClassField<SearchNoTerm>("noTerm"),
        new SealedClassField<SearchPopulated>("populated"),
        new SealedClassField<SearchEmpty>("empty")
      ];
  W when<W>({
    @required W loading(SearchLoading loading),
    @required W error(SearchError error),
    @required W noTerm(SearchNoTerm noTerm),
    @required W populated(SearchPopulated populated),
    @required W empty(SearchEmpty empty),
  });
}

abstract class _SearchErrorBase extends DataClass {
  String get message;
  @override
  Iterable<ComputedField> get computedFields => [];

  @override
  Iterable<DataClassField> get nonDefaultedFields =>
      [new DataClassField<String>("message")];

  @override
  Iterable<DataClassField> get defaultedFields => [];

  Iterable<DataClassField> _fields;
  @override
  Iterable<DataClassField> get fields =>
      _fields ??= []..addAll(nonDefaultedFields)..addAll(defaultedFields);
}

class SearchError extends _SearchErrorBase {
  final String _message;

  SearchError({
    @required String message,
  })  : _message = message,
        super() {
    assert(this.message != null, "null value provided for field message");
  }

  SearchError clone({
    String message,
  }) =>
      new SearchError(
        message: message ?? _message,
      );

  @override
  String get message => _message;

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! SearchError) return false;
    return message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(0, message.hashCode));
  }
}

abstract class _SearchPopulatedBase extends DataClass {
  SearchResult get result;
  @override
  Iterable<ComputedField> get computedFields => [];

  @override
  Iterable<DataClassField> get nonDefaultedFields =>
      [new DataClassField<SearchResult>("result")];

  @override
  Iterable<DataClassField> get defaultedFields => [];

  Iterable<DataClassField> _fields;
  @override
  Iterable<DataClassField> get fields =>
      _fields ??= []..addAll(nonDefaultedFields)..addAll(defaultedFields);
}

class SearchPopulated extends _SearchPopulatedBase {
  final SearchResult _result;

  SearchPopulated({
    @required SearchResult result,
  })  : _result = result,
        super() {
    assert(this.result != null, "null value provided for field result");
  }

  SearchPopulated clone({
    SearchResult result,
  }) =>
      new SearchPopulated(
        result: result ?? _result,
      );

  @override
  SearchResult get result => _result;

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! SearchPopulated) return false;
    return result == other.result;
  }

  @override
  int get hashCode {
    return $jf($jc(0, result.hashCode));
  }
}

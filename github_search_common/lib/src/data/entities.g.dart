// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entities.dart';

// **************************************************************************
// MetaTypesGenerator
// **************************************************************************

abstract class _SearchResultBase extends DataClass {
  List<SearchResultItem> get items;
  bool get isPopulated => items.isNotEmpty;
  bool get isEmpty => items.isEmpty;
  @override
  Iterable<ComputedField> get computedFields => [];

  @override
  Iterable<DataClassField> get nonDefaultedFields =>
      [new DataClassField<List<SearchResultItem>>("items")];

  @override
  Iterable<DataClassField> get defaultedFields => [
        new DataClassField<bool>("isPopulated"),
        new DataClassField<bool>("isEmpty")
      ];

  Iterable<DataClassField> _fields;
  @override
  Iterable<DataClassField> get fields =>
      _fields ??= []..addAll(nonDefaultedFields)..addAll(defaultedFields);
}

class SearchResult extends _SearchResultBase with SearchResultMetaJson {
  final List<SearchResultItem> _items;
  final bool _isPopulated;
  final bool _isEmpty;

  SearchResult({
    @required List<SearchResultItem> items,
    bool isPopulated,
    bool isEmpty,
  })  : _items = items,
        _isPopulated = isPopulated,
        _isEmpty = isEmpty,
        super() {
    assert(this.items != null, "null value provided for field items");
    assert(
        this.isPopulated != null, "null value provided for field isPopulated");
    assert(this.isEmpty != null, "null value provided for field isEmpty");
  }

  SearchResult clone({
    List<SearchResultItem> items,
    bool isPopulated,
    bool isEmpty,
  }) =>
      new SearchResult(
        items: items ?? _items,
        isPopulated: isPopulated ?? _isPopulated,
        isEmpty: isEmpty ?? _isEmpty,
      );

  @override
  List<SearchResultItem> get items => _items;
  @override
  bool get isPopulated => _isPopulated ?? super.isPopulated;
  @override
  bool get isEmpty => _isEmpty ?? super.isEmpty;

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! SearchResult) return false;
    return items == other.items &&
        isPopulated == other.isPopulated &&
        isEmpty == other.isEmpty;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, items.hashCode), isPopulated.hashCode), isEmpty.hashCode));
  }
}

abstract class _SearchResultItemBase extends DataClass {
  String get full_name;
  String get html_url;
  GithubUser get owner;
  @override
  Iterable<ComputedField> get computedFields => [];

  @override
  Iterable<DataClassField> get nonDefaultedFields => [
        new DataClassField<String>("full_name"),
        new DataClassField<String>("html_url"),
        new DataClassField<GithubUser>("owner")
      ];

  @override
  Iterable<DataClassField> get defaultedFields => [];

  Iterable<DataClassField> _fields;
  @override
  Iterable<DataClassField> get fields =>
      _fields ??= []..addAll(nonDefaultedFields)..addAll(defaultedFields);
}

class SearchResultItem extends _SearchResultItemBase
    with SearchResultItemMetaJson {
  final String _full_name;
  final String _html_url;
  final GithubUser _owner;

  SearchResultItem({
    @required String full_name,
    @required String html_url,
    @required GithubUser owner,
  })  : _full_name = full_name,
        _html_url = html_url,
        _owner = owner,
        super() {
    assert(this.full_name != null, "null value provided for field full_name");
    assert(this.html_url != null, "null value provided for field html_url");
    assert(this.owner != null, "null value provided for field owner");
  }

  SearchResultItem clone({
    String full_name,
    String html_url,
    GithubUser owner,
  }) =>
      new SearchResultItem(
        full_name: full_name ?? _full_name,
        html_url: html_url ?? _html_url,
        owner: owner ?? _owner,
      );

  @override
  String get full_name => _full_name;
  @override
  String get html_url => _html_url;
  @override
  GithubUser get owner => _owner;

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! SearchResultItem) return false;
    return full_name == other.full_name &&
        html_url == other.html_url &&
        owner == other.owner;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc(0, full_name.hashCode), html_url.hashCode), owner.hashCode));
  }
}

abstract class _GithubUserBase extends DataClass {
  String get login;
  String get avatar_url;
  @override
  Iterable<ComputedField> get computedFields => [];

  @override
  Iterable<DataClassField> get nonDefaultedFields => [
        new DataClassField<String>("login"),
        new DataClassField<String>("avatar_url")
      ];

  @override
  Iterable<DataClassField> get defaultedFields => [];

  Iterable<DataClassField> _fields;
  @override
  Iterable<DataClassField> get fields =>
      _fields ??= []..addAll(nonDefaultedFields)..addAll(defaultedFields);
}

class GithubUser extends _GithubUserBase with GithubUserMetaJson {
  final String _login;
  final String _avatar_url;

  GithubUser({
    @required String login,
    @required String avatar_url,
  })  : _login = login,
        _avatar_url = avatar_url,
        super() {
    assert(this.login != null, "null value provided for field login");
    assert(this.avatar_url != null, "null value provided for field avatar_url");
  }

  GithubUser clone({
    String login,
    String avatar_url,
  }) =>
      new GithubUser(
        login: login ?? _login,
        avatar_url: avatar_url ?? _avatar_url,
      );

  @override
  String get login => _login;
  @override
  String get avatar_url => _avatar_url;

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! GithubUser) return false;
    return login == other.login && avatar_url == other.avatar_url;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, login.hashCode), avatar_url.hashCode));
  }
}

abstract class _SearchResultErrorBase extends DataClass {
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

class SearchResultError extends _SearchResultErrorBase
    with SearchResultErrorMetaJson {
  final String _message;

  SearchResultError({
    @required String message,
  })  : _message = message,
        super() {
    assert(this.message != null, "null value provided for field message");
  }

  SearchResultError clone({
    String message,
  }) =>
      new SearchResultError(
        message: message ?? _message,
      );

  @override
  String get message => _message;

  @override
  bool operator ==(dynamic other) {
    if (identical(other, this)) return true;
    if (other is! SearchResultError) return false;
    return message == other.message;
  }

  @override
  int get hashCode {
    return $jf($jc(0, message.hashCode));
  }
}

// **************************************************************************
// _MetaTypesjsonGenerator
// **************************************************************************

abstract class SearchResultMetaJson implements _SearchResultBase, ToJson {
  static SearchResult fromJson(dynamic j) {
    final m = j as Map<String, dynamic>;
    return SearchResult(
      items: List<SearchResultItem>.unmodifiable((m['items'] as List<dynamic>)
          .map((dynamic v) =>
              SearchResultItemMetaJson.fromJson(v as Map<String, dynamic>))
          .toList()),
      isPopulated: m['isPopulated'] as bool,
      isEmpty: m['isEmpty'] as bool,
    );
  }

  dynamic toJson() => <String, dynamic>{
        'items': $toJson(items),
        'isPopulated': $toJson(isPopulated),
        'isEmpty': $toJson(isEmpty),
      };
}

abstract class SearchResultItemMetaJson
    implements _SearchResultItemBase, ToJson {
  static SearchResultItem fromJson(dynamic j) {
    final m = j as Map<String, dynamic>;
    return SearchResultItem(
      full_name: m['full_name'] as String,
      html_url: m['html_url'] as String,
      owner: GithubUserMetaJson.fromJson(m['owner']),
    );
  }

  dynamic toJson() => <String, dynamic>{
        'full_name': $toJson(full_name),
        'html_url': $toJson(html_url),
        'owner': $toJson(owner),
      };
}

abstract class GithubUserMetaJson implements _GithubUserBase, ToJson {
  static GithubUser fromJson(dynamic j) {
    final m = j as Map<String, dynamic>;
    return GithubUser(
      login: m['login'] as String,
      avatar_url: m['avatar_url'] as String,
    );
  }

  dynamic toJson() => <String, dynamic>{
        'login': $toJson(login),
        'avatar_url': $toJson(avatar_url),
      };
}

abstract class SearchResultErrorMetaJson
    implements _SearchResultErrorBase, ToJson {
  static SearchResultError fromJson(dynamic j) {
    final m = j as Map<String, dynamic>;
    return SearchResultError(
      message: m['message'] as String,
    );
  }

  dynamic toJson() => <String, dynamic>{
        'message': $toJson(message),
      };
}

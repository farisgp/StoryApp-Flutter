// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'story.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Story _$StoryFromJson(Map<String, dynamic> json) {
  return _Story.fromJson(json);
}

/// @nodoc
mixin _$Story {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get photoUrl => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  double? get lat => throw _privateConstructorUsedError;
  double? get lon => throw _privateConstructorUsedError;

  /// Serializes this Story to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryCopyWith<Story> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryCopyWith<$Res> {
  factory $StoryCopyWith(Story value, $Res Function(Story) then) =
      _$StoryCopyWithImpl<$Res, Story>;
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String photoUrl,
    DateTime createdAt,
    double? lat,
    double? lon,
  });
}

/// @nodoc
class _$StoryCopyWithImpl<$Res, $Val extends Story>
    implements $StoryCopyWith<$Res> {
  _$StoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? photoUrl = null,
    Object? createdAt = null,
    Object? lat = freezed,
    Object? lon = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            description: null == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String,
            photoUrl: null == photoUrl
                ? _value.photoUrl
                : photoUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            lat: freezed == lat
                ? _value.lat
                : lat // ignore: cast_nullable_to_non_nullable
                      as double?,
            lon: freezed == lon
                ? _value.lon
                : lon // ignore: cast_nullable_to_non_nullable
                      as double?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryImplCopyWith<$Res> implements $StoryCopyWith<$Res> {
  factory _$$StoryImplCopyWith(
    _$StoryImpl value,
    $Res Function(_$StoryImpl) then,
  ) = __$$StoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    String description,
    String photoUrl,
    DateTime createdAt,
    double? lat,
    double? lon,
  });
}

/// @nodoc
class __$$StoryImplCopyWithImpl<$Res>
    extends _$StoryCopyWithImpl<$Res, _$StoryImpl>
    implements _$$StoryImplCopyWith<$Res> {
  __$$StoryImplCopyWithImpl(
    _$StoryImpl _value,
    $Res Function(_$StoryImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? description = null,
    Object? photoUrl = null,
    Object? createdAt = null,
    Object? lat = freezed,
    Object? lon = freezed,
  }) {
    return _then(
      _$StoryImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        description: null == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String,
        photoUrl: null == photoUrl
            ? _value.photoUrl
            : photoUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        lat: freezed == lat
            ? _value.lat
            : lat // ignore: cast_nullable_to_non_nullable
                  as double?,
        lon: freezed == lon
            ? _value.lon
            : lon // ignore: cast_nullable_to_non_nullable
                  as double?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryImpl implements _Story {
  const _$StoryImpl({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    this.lat,
    this.lon,
  });

  factory _$StoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String description;
  @override
  final String photoUrl;
  @override
  final DateTime createdAt;
  @override
  final double? lat;
  @override
  final double? lon;

  @override
  String toString() {
    return 'Story(id: $id, name: $name, description: $description, photoUrl: $photoUrl, createdAt: $createdAt, lat: $lat, lon: $lon)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.photoUrl, photoUrl) ||
                other.photoUrl == photoUrl) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.lat, lat) || other.lat == lat) &&
            (identical(other.lon, lon) || other.lon == lon));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    description,
    photoUrl,
    createdAt,
    lat,
    lon,
  );

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryImplCopyWith<_$StoryImpl> get copyWith =>
      __$$StoryImplCopyWithImpl<_$StoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryImplToJson(this);
  }
}

abstract class _Story implements Story {
  const factory _Story({
    required final String id,
    required final String name,
    required final String description,
    required final String photoUrl,
    required final DateTime createdAt,
    final double? lat,
    final double? lon,
  }) = _$StoryImpl;

  factory _Story.fromJson(Map<String, dynamic> json) = _$StoryImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get description;
  @override
  String get photoUrl;
  @override
  DateTime get createdAt;
  @override
  double? get lat;
  @override
  double? get lon;

  /// Create a copy of Story
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryImplCopyWith<_$StoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryListResponse _$StoryListResponseFromJson(Map<String, dynamic> json) {
  return _StoryListResponse.fromJson(json);
}

/// @nodoc
mixin _$StoryListResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  List<Story> get listStory => throw _privateConstructorUsedError;

  /// Serializes this StoryListResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryListResponseCopyWith<StoryListResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryListResponseCopyWith<$Res> {
  factory $StoryListResponseCopyWith(
    StoryListResponse value,
    $Res Function(StoryListResponse) then,
  ) = _$StoryListResponseCopyWithImpl<$Res, StoryListResponse>;
  @useResult
  $Res call({bool error, String message, List<Story> listStory});
}

/// @nodoc
class _$StoryListResponseCopyWithImpl<$Res, $Val extends StoryListResponse>
    implements $StoryListResponseCopyWith<$Res> {
  _$StoryListResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = null,
  }) {
    return _then(
      _value.copyWith(
            error: null == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            listStory: null == listStory
                ? _value.listStory
                : listStory // ignore: cast_nullable_to_non_nullable
                      as List<Story>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$StoryListResponseImplCopyWith<$Res>
    implements $StoryListResponseCopyWith<$Res> {
  factory _$$StoryListResponseImplCopyWith(
    _$StoryListResponseImpl value,
    $Res Function(_$StoryListResponseImpl) then,
  ) = __$$StoryListResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message, List<Story> listStory});
}

/// @nodoc
class __$$StoryListResponseImplCopyWithImpl<$Res>
    extends _$StoryListResponseCopyWithImpl<$Res, _$StoryListResponseImpl>
    implements _$$StoryListResponseImplCopyWith<$Res> {
  __$$StoryListResponseImplCopyWithImpl(
    _$StoryListResponseImpl _value,
    $Res Function(_$StoryListResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? listStory = null,
  }) {
    return _then(
      _$StoryListResponseImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        listStory: null == listStory
            ? _value._listStory
            : listStory // ignore: cast_nullable_to_non_nullable
                  as List<Story>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryListResponseImpl implements _StoryListResponse {
  const _$StoryListResponseImpl({
    required this.error,
    required this.message,
    required final List<Story> listStory,
  }) : _listStory = listStory;

  factory _$StoryListResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryListResponseImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  final List<Story> _listStory;
  @override
  List<Story> get listStory {
    if (_listStory is EqualUnmodifiableListView) return _listStory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_listStory);
  }

  @override
  String toString() {
    return 'StoryListResponse(error: $error, message: $message, listStory: $listStory)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryListResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other._listStory,
              _listStory,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    error,
    message,
    const DeepCollectionEquality().hash(_listStory),
  );

  /// Create a copy of StoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryListResponseImplCopyWith<_$StoryListResponseImpl> get copyWith =>
      __$$StoryListResponseImplCopyWithImpl<_$StoryListResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryListResponseImplToJson(this);
  }
}

abstract class _StoryListResponse implements StoryListResponse {
  const factory _StoryListResponse({
    required final bool error,
    required final String message,
    required final List<Story> listStory,
  }) = _$StoryListResponseImpl;

  factory _StoryListResponse.fromJson(Map<String, dynamic> json) =
      _$StoryListResponseImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  List<Story> get listStory;

  /// Create a copy of StoryListResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryListResponseImplCopyWith<_$StoryListResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

StoryDetailResponse _$StoryDetailResponseFromJson(Map<String, dynamic> json) {
  return _StoryDetailResponse.fromJson(json);
}

/// @nodoc
mixin _$StoryDetailResponse {
  bool get error => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  Story? get story => throw _privateConstructorUsedError;

  /// Serializes this StoryDetailResponse to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of StoryDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $StoryDetailResponseCopyWith<StoryDetailResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StoryDetailResponseCopyWith<$Res> {
  factory $StoryDetailResponseCopyWith(
    StoryDetailResponse value,
    $Res Function(StoryDetailResponse) then,
  ) = _$StoryDetailResponseCopyWithImpl<$Res, StoryDetailResponse>;
  @useResult
  $Res call({bool error, String message, Story? story});

  $StoryCopyWith<$Res>? get story;
}

/// @nodoc
class _$StoryDetailResponseCopyWithImpl<$Res, $Val extends StoryDetailResponse>
    implements $StoryDetailResponseCopyWith<$Res> {
  _$StoryDetailResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of StoryDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? story = freezed,
  }) {
    return _then(
      _value.copyWith(
            error: null == error
                ? _value.error
                : error // ignore: cast_nullable_to_non_nullable
                      as bool,
            message: null == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String,
            story: freezed == story
                ? _value.story
                : story // ignore: cast_nullable_to_non_nullable
                      as Story?,
          )
          as $Val,
    );
  }

  /// Create a copy of StoryDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $StoryCopyWith<$Res>? get story {
    if (_value.story == null) {
      return null;
    }

    return $StoryCopyWith<$Res>(_value.story!, (value) {
      return _then(_value.copyWith(story: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$StoryDetailResponseImplCopyWith<$Res>
    implements $StoryDetailResponseCopyWith<$Res> {
  factory _$$StoryDetailResponseImplCopyWith(
    _$StoryDetailResponseImpl value,
    $Res Function(_$StoryDetailResponseImpl) then,
  ) = __$$StoryDetailResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({bool error, String message, Story? story});

  @override
  $StoryCopyWith<$Res>? get story;
}

/// @nodoc
class __$$StoryDetailResponseImplCopyWithImpl<$Res>
    extends _$StoryDetailResponseCopyWithImpl<$Res, _$StoryDetailResponseImpl>
    implements _$$StoryDetailResponseImplCopyWith<$Res> {
  __$$StoryDetailResponseImplCopyWithImpl(
    _$StoryDetailResponseImpl _value,
    $Res Function(_$StoryDetailResponseImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of StoryDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? error = null,
    Object? message = null,
    Object? story = freezed,
  }) {
    return _then(
      _$StoryDetailResponseImpl(
        error: null == error
            ? _value.error
            : error // ignore: cast_nullable_to_non_nullable
                  as bool,
        message: null == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String,
        story: freezed == story
            ? _value.story
            : story // ignore: cast_nullable_to_non_nullable
                  as Story?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$StoryDetailResponseImpl implements _StoryDetailResponse {
  const _$StoryDetailResponseImpl({
    required this.error,
    required this.message,
    this.story,
  });

  factory _$StoryDetailResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$StoryDetailResponseImplFromJson(json);

  @override
  final bool error;
  @override
  final String message;
  @override
  final Story? story;

  @override
  String toString() {
    return 'StoryDetailResponse(error: $error, message: $message, story: $story)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StoryDetailResponseImpl &&
            (identical(other.error, error) || other.error == error) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.story, story) || other.story == story));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, error, message, story);

  /// Create a copy of StoryDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$StoryDetailResponseImplCopyWith<_$StoryDetailResponseImpl> get copyWith =>
      __$$StoryDetailResponseImplCopyWithImpl<_$StoryDetailResponseImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$StoryDetailResponseImplToJson(this);
  }
}

abstract class _StoryDetailResponse implements StoryDetailResponse {
  const factory _StoryDetailResponse({
    required final bool error,
    required final String message,
    final Story? story,
  }) = _$StoryDetailResponseImpl;

  factory _StoryDetailResponse.fromJson(Map<String, dynamic> json) =
      _$StoryDetailResponseImpl.fromJson;

  @override
  bool get error;
  @override
  String get message;
  @override
  Story? get story;

  /// Create a copy of StoryDetailResponse
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$StoryDetailResponseImplCopyWith<_$StoryDetailResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

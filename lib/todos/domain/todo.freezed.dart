// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Todo _$TodoFromJson(Map<String, dynamic> json) {
  return _TODO.fromJson(json);
}

/// @nodoc
mixin _$Todo {
  String? get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  bool get completed => throw _privateConstructorUsedError;
  DateTime get dateCreated => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TodoCopyWith<Todo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TodoCopyWith<$Res> {
  factory $TodoCopyWith(Todo value, $Res Function(Todo) then) =
      _$TodoCopyWithImpl<$Res, Todo>;
  @useResult
  $Res call(
      {String? id,
      String title,
      String? description,
      bool completed,
      DateTime dateCreated});
}

/// @nodoc
class _$TodoCopyWithImpl<$Res, $Val extends Todo>
    implements $TodoCopyWith<$Res> {
  _$TodoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? completed = null,
    Object? dateCreated = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TODOCopyWith<$Res> implements $TodoCopyWith<$Res> {
  factory _$$_TODOCopyWith(_$_TODO value, $Res Function(_$_TODO) then) =
      __$$_TODOCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String title,
      String? description,
      bool completed,
      DateTime dateCreated});
}

/// @nodoc
class __$$_TODOCopyWithImpl<$Res> extends _$TodoCopyWithImpl<$Res, _$_TODO>
    implements _$$_TODOCopyWith<$Res> {
  __$$_TODOCopyWithImpl(_$_TODO _value, $Res Function(_$_TODO) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = null,
    Object? description = freezed,
    Object? completed = null,
    Object? dateCreated = null,
  }) {
    return _then(_$_TODO(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      completed: null == completed
          ? _value.completed
          : completed // ignore: cast_nullable_to_non_nullable
              as bool,
      dateCreated: null == dateCreated
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TODO implements _TODO {
  const _$_TODO(
      {this.id,
      required this.title,
      this.description,
      this.completed = false,
      required this.dateCreated});

  factory _$_TODO.fromJson(Map<String, dynamic> json) => _$$_TODOFromJson(json);

  @override
  final String? id;
  @override
  final String title;
  @override
  final String? description;
  @override
  @JsonKey()
  final bool completed;
  @override
  final DateTime dateCreated;

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, completed: $completed, dateCreated: $dateCreated)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TODO &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.completed, completed) ||
                other.completed == completed) &&
            (identical(other.dateCreated, dateCreated) ||
                other.dateCreated == dateCreated));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, description, completed, dateCreated);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TODOCopyWith<_$_TODO> get copyWith =>
      __$$_TODOCopyWithImpl<_$_TODO>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TODOToJson(
      this,
    );
  }
}

abstract class _TODO implements Todo {
  const factory _TODO(
      {final String? id,
      required final String title,
      final String? description,
      final bool completed,
      required final DateTime dateCreated}) = _$_TODO;

  factory _TODO.fromJson(Map<String, dynamic> json) = _$_TODO.fromJson;

  @override
  String? get id;
  @override
  String get title;
  @override
  String? get description;
  @override
  bool get completed;
  @override
  DateTime get dateCreated;
  @override
  @JsonKey(ignore: true)
  _$$_TODOCopyWith<_$_TODO> get copyWith => throw _privateConstructorUsedError;
}

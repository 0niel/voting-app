// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
class _$UserTearOff {
  const _$UserTearOff();

  _User call(
      {@JsonKey(name: 'ID')
          required int id,
      @JsonKey(name: 'arUser__LOGIN')
          required String login,
      @JsonKey(name: 'arUser__EMAIL')
          required String email,
      @JsonKey(name: 'arUser__NAME')
          required String name,
      @JsonKey(name: 'arUser__LAST_NAME')
          required String lastName,
      @JsonKey(name: 'arUser__SECOND_NAME')
          required String secondName,
      @JsonKey(name: 'PROPERTIES__PERSONAL_NUMBER__VALUE')
          required String personalNumber,
      @JsonKey(name: 'PROPERTIES__ACADEMIC_GROUP__VALUE_TEXT')
          required String academicGroup,
      @JsonKey(name: 'arUser__PHOTO')
          required String photoUrl}) {
    return _User(
      id: id,
      login: login,
      email: email,
      name: name,
      lastName: lastName,
      secondName: secondName,
      personalNumber: personalNumber,
      academicGroup: academicGroup,
      photoUrl: photoUrl,
    );
  }

  User fromJson(Map<String, Object?> json) {
    return User.fromJson(json);
  }
}

/// @nodoc
const $User = _$UserTearOff();

/// @nodoc
mixin _$User {
  @JsonKey(name: 'ID')
  int get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'arUser__LOGIN')
  String get login => throw _privateConstructorUsedError;
  @JsonKey(name: 'arUser__EMAIL')
  String get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'arUser__NAME')
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'arUser__LAST_NAME')
  String get lastName => throw _privateConstructorUsedError;
  @JsonKey(name: 'arUser__SECOND_NAME')
  String get secondName => throw _privateConstructorUsedError;
  @JsonKey(name: 'PROPERTIES__PERSONAL_NUMBER__VALUE')
  String get personalNumber => throw _privateConstructorUsedError;
  @JsonKey(name: 'PROPERTIES__ACADEMIC_GROUP__VALUE_TEXT')
  String get academicGroup => throw _privateConstructorUsedError;
  @JsonKey(name: 'arUser__PHOTO')
  String get photoUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'ID')
          int id,
      @JsonKey(name: 'arUser__LOGIN')
          String login,
      @JsonKey(name: 'arUser__EMAIL')
          String email,
      @JsonKey(name: 'arUser__NAME')
          String name,
      @JsonKey(name: 'arUser__LAST_NAME')
          String lastName,
      @JsonKey(name: 'arUser__SECOND_NAME')
          String secondName,
      @JsonKey(name: 'PROPERTIES__PERSONAL_NUMBER__VALUE')
          String personalNumber,
      @JsonKey(name: 'PROPERTIES__ACADEMIC_GROUP__VALUE_TEXT')
          String academicGroup,
      @JsonKey(name: 'arUser__PHOTO')
          String photoUrl});
}

/// @nodoc
class _$UserCopyWithImpl<$Res> implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  final User _value;
  // ignore: unused_field
  final $Res Function(User) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? login = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? lastName = freezed,
    Object? secondName = freezed,
    Object? personalNumber = freezed,
    Object? academicGroup = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      login: login == freezed
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      secondName: secondName == freezed
          ? _value.secondName
          : secondName // ignore: cast_nullable_to_non_nullable
              as String,
      personalNumber: personalNumber == freezed
          ? _value.personalNumber
          : personalNumber // ignore: cast_nullable_to_non_nullable
              as String,
      academicGroup: academicGroup == freezed
          ? _value.academicGroup
          : academicGroup // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$UserCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$UserCopyWith(_User value, $Res Function(_User) then) =
      __$UserCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'ID')
          int id,
      @JsonKey(name: 'arUser__LOGIN')
          String login,
      @JsonKey(name: 'arUser__EMAIL')
          String email,
      @JsonKey(name: 'arUser__NAME')
          String name,
      @JsonKey(name: 'arUser__LAST_NAME')
          String lastName,
      @JsonKey(name: 'arUser__SECOND_NAME')
          String secondName,
      @JsonKey(name: 'PROPERTIES__PERSONAL_NUMBER__VALUE')
          String personalNumber,
      @JsonKey(name: 'PROPERTIES__ACADEMIC_GROUP__VALUE_TEXT')
          String academicGroup,
      @JsonKey(name: 'arUser__PHOTO')
          String photoUrl});
}

/// @nodoc
class __$UserCopyWithImpl<$Res> extends _$UserCopyWithImpl<$Res>
    implements _$UserCopyWith<$Res> {
  __$UserCopyWithImpl(_User _value, $Res Function(_User) _then)
      : super(_value, (v) => _then(v as _User));

  @override
  _User get _value => super._value as _User;

  @override
  $Res call({
    Object? id = freezed,
    Object? login = freezed,
    Object? email = freezed,
    Object? name = freezed,
    Object? lastName = freezed,
    Object? secondName = freezed,
    Object? personalNumber = freezed,
    Object? academicGroup = freezed,
    Object? photoUrl = freezed,
  }) {
    return _then(_User(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      login: login == freezed
          ? _value.login
          : login // ignore: cast_nullable_to_non_nullable
              as String,
      email: email == freezed
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: lastName == freezed
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      secondName: secondName == freezed
          ? _value.secondName
          : secondName // ignore: cast_nullable_to_non_nullable
              as String,
      personalNumber: personalNumber == freezed
          ? _value.personalNumber
          : personalNumber // ignore: cast_nullable_to_non_nullable
              as String,
      academicGroup: academicGroup == freezed
          ? _value.academicGroup
          : academicGroup // ignore: cast_nullable_to_non_nullable
              as String,
      photoUrl: photoUrl == freezed
          ? _value.photoUrl
          : photoUrl // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$_User extends _User {
  const _$_User(
      {@JsonKey(name: 'ID')
          required this.id,
      @JsonKey(name: 'arUser__LOGIN')
          required this.login,
      @JsonKey(name: 'arUser__EMAIL')
          required this.email,
      @JsonKey(name: 'arUser__NAME')
          required this.name,
      @JsonKey(name: 'arUser__LAST_NAME')
          required this.lastName,
      @JsonKey(name: 'arUser__SECOND_NAME')
          required this.secondName,
      @JsonKey(name: 'PROPERTIES__PERSONAL_NUMBER__VALUE')
          required this.personalNumber,
      @JsonKey(name: 'PROPERTIES__ACADEMIC_GROUP__VALUE_TEXT')
          required this.academicGroup,
      @JsonKey(name: 'arUser__PHOTO')
          required this.photoUrl})
      : super._();

  factory _$_User.fromJson(Map<String, dynamic> json) => _$$_UserFromJson(json);

  @override
  @JsonKey(name: 'ID')
  final int id;
  @override
  @JsonKey(name: 'arUser__LOGIN')
  final String login;
  @override
  @JsonKey(name: 'arUser__EMAIL')
  final String email;
  @override
  @JsonKey(name: 'arUser__NAME')
  final String name;
  @override
  @JsonKey(name: 'arUser__LAST_NAME')
  final String lastName;
  @override
  @JsonKey(name: 'arUser__SECOND_NAME')
  final String secondName;
  @override
  @JsonKey(name: 'PROPERTIES__PERSONAL_NUMBER__VALUE')
  final String personalNumber;
  @override
  @JsonKey(name: 'PROPERTIES__ACADEMIC_GROUP__VALUE_TEXT')
  final String academicGroup;
  @override
  @JsonKey(name: 'arUser__PHOTO')
  final String photoUrl;

  @override
  String toString() {
    return 'User(id: $id, login: $login, email: $email, name: $name, lastName: $lastName, secondName: $secondName, personalNumber: $personalNumber, academicGroup: $academicGroup, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _User &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.login, login) &&
            const DeepCollectionEquality().equals(other.email, email) &&
            const DeepCollectionEquality().equals(other.name, name) &&
            const DeepCollectionEquality().equals(other.lastName, lastName) &&
            const DeepCollectionEquality()
                .equals(other.secondName, secondName) &&
            const DeepCollectionEquality()
                .equals(other.personalNumber, personalNumber) &&
            const DeepCollectionEquality()
                .equals(other.academicGroup, academicGroup) &&
            const DeepCollectionEquality().equals(other.photoUrl, photoUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(login),
      const DeepCollectionEquality().hash(email),
      const DeepCollectionEquality().hash(name),
      const DeepCollectionEquality().hash(lastName),
      const DeepCollectionEquality().hash(secondName),
      const DeepCollectionEquality().hash(personalNumber),
      const DeepCollectionEquality().hash(academicGroup),
      const DeepCollectionEquality().hash(photoUrl));

  @JsonKey(ignore: true)
  @override
  _$UserCopyWith<_User> get copyWith =>
      __$UserCopyWithImpl<_User>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserToJson(this);
  }
}

abstract class _User extends User {
  const factory _User(
      {@JsonKey(name: 'ID')
          required int id,
      @JsonKey(name: 'arUser__LOGIN')
          required String login,
      @JsonKey(name: 'arUser__EMAIL')
          required String email,
      @JsonKey(name: 'arUser__NAME')
          required String name,
      @JsonKey(name: 'arUser__LAST_NAME')
          required String lastName,
      @JsonKey(name: 'arUser__SECOND_NAME')
          required String secondName,
      @JsonKey(name: 'PROPERTIES__PERSONAL_NUMBER__VALUE')
          required String personalNumber,
      @JsonKey(name: 'PROPERTIES__ACADEMIC_GROUP__VALUE_TEXT')
          required String academicGroup,
      @JsonKey(name: 'arUser__PHOTO')
          required String photoUrl}) = _$_User;
  const _User._() : super._();

  factory _User.fromJson(Map<String, dynamic> json) = _$_User.fromJson;

  @override
  @JsonKey(name: 'ID')
  int get id;
  @override
  @JsonKey(name: 'arUser__LOGIN')
  String get login;
  @override
  @JsonKey(name: 'arUser__EMAIL')
  String get email;
  @override
  @JsonKey(name: 'arUser__NAME')
  String get name;
  @override
  @JsonKey(name: 'arUser__LAST_NAME')
  String get lastName;
  @override
  @JsonKey(name: 'arUser__SECOND_NAME')
  String get secondName;
  @override
  @JsonKey(name: 'PROPERTIES__PERSONAL_NUMBER__VALUE')
  String get personalNumber;
  @override
  @JsonKey(name: 'PROPERTIES__ACADEMIC_GROUP__VALUE_TEXT')
  String get academicGroup;
  @override
  @JsonKey(name: 'arUser__PHOTO')
  String get photoUrl;
  @override
  @JsonKey(ignore: true)
  _$UserCopyWith<_User> get copyWith => throw _privateConstructorUsedError;
}

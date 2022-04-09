// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const User._();
  @JsonSerializable(explicitToJson: true)
  const factory User(
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
          required String photoUrl}) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

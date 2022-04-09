// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$$_UserFromJson(Map<String, dynamic> json) => _$_User(
      id: json['ID'] as int,
      login: json['arUser__LOGIN'] as String,
      email: json['arUser__EMAIL'] as String,
      name: json['arUser__NAME'] as String,
      lastName: json['arUser__LAST_NAME'] as String,
      secondName: json['arUser__SECOND_NAME'] as String,
      personalNumber: json['PROPERTIES__PERSONAL_NUMBER__VALUE'] as String,
      academicGroup: json['PROPERTIES__ACADEMIC_GROUP__VALUE_TEXT'] as String,
      photoUrl: json['arUser__PHOTO'] as String,
    );

Map<String, dynamic> _$$_UserToJson(_$_User instance) => <String, dynamic>{
      'ID': instance.id,
      'arUser__LOGIN': instance.login,
      'arUser__EMAIL': instance.email,
      'arUser__NAME': instance.name,
      'arUser__LAST_NAME': instance.lastName,
      'arUser__SECOND_NAME': instance.secondName,
      'PROPERTIES__PERSONAL_NUMBER__VALUE': instance.personalNumber,
      'PROPERTIES__ACADEMIC_GROUP__VALUE_TEXT': instance.academicGroup,
      'arUser__PHOTO': instance.photoUrl,
    };

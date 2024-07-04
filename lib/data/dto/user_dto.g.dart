// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDto _$UserDtoFromJson(Map<String, dynamic> json) => UserDto(
      login: json['login'] as String?,
      id: (json['id'] as num?)?.toInt(),
      avatarUrl: json['avatar_url'] as String?,
    );

Map<String, dynamic> _$UserDtoToJson(UserDto instance) => <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatar_url': instance.avatarUrl,
    };

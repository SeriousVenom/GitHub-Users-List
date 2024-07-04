// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_details_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetailsDto _$UserDetailsDtoFromJson(Map<String, dynamic> json) =>
    UserDetailsDto(
      login: json['login'] as String?,
      id: (json['id'] as num?)?.toInt(),
      avatarUrl: json['avatar_url'] as String?,
      followers: (json['followers'] as num?)?.toInt(),
      following: (json['following'] as num?)?.toInt(),
    );

Map<String, dynamic> _$UserDetailsDtoToJson(UserDetailsDto instance) =>
    <String, dynamic>{
      'login': instance.login,
      'id': instance.id,
      'avatar_url': instance.avatarUrl,
      'followers': instance.followers,
      'following': instance.following,
    };

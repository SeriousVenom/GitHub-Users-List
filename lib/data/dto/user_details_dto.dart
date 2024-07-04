import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_details_dto.g.dart';

@JsonSerializable()
class UserDetailsDto extends Equatable {
  final String? login;
  final int? id;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;
  final int? followers;
  final int? following;

  const UserDetailsDto({
    this.login,
    this.id,
    this.avatarUrl,
    this.followers,
    this.following,
  });

  factory UserDetailsDto.fromJson(Map<String, dynamic> json) => _$UserDetailsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDetailsDtoToJson(this);

  @override
  List<Object?> get props => [
        login,
        id,
        avatarUrl,
        followers,
        following,
      ];
}

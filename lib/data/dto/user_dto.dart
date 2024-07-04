import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDto extends Equatable {
  final String? login;
  final int? id;
  @JsonKey(name: 'avatar_url')
  final String? avatarUrl;

  const UserDto({
    this.login,
    this.id,
    this.avatarUrl,
  });

  factory UserDto.fromJson(Map<String, dynamic> json) => _$UserDtoFromJson(json);
  Map<String, dynamic> toJson() => _$UserDtoToJson(this);

  @override
  List<Object?> get props => [
        login,
        id,
        avatarUrl,
      ];
}

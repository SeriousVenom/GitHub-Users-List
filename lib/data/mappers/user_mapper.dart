import 'package:github_user_list/data/dto/user_dto.dart';
import 'package:github_user_list/data/models/user_model.dart';

extension UserDtoExt on UserDto {
  UserModel toModel() {
    return UserModel(
      login: login ?? '',
      id: id ?? 0,
      avatarUrl: avatarUrl ?? '',
    );
  }
}

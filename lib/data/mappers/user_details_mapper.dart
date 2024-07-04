import 'package:github_user_list/data/dto/user_details_dto.dart';
import 'package:github_user_list/data/models/user_details_model.dart';

extension UserDetailsDtoExt on UserDetailsDto {
  UserDetailsModel toModel() {
    return UserDetailsModel(
      login: login ?? '',
      id: id ?? 0,
      avatarUrl: avatarUrl ?? '',
      followers: followers ?? 0,
      following: following ?? 0,
    );
  }
}

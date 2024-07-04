import 'package:dio/dio.dart';
import 'package:github_user_list/config/api_urls.dart';
import 'package:github_user_list/data/dto/user_details_dto.dart';
import 'package:github_user_list/data/dto/user_dto.dart';
import 'package:github_user_list/data/mappers/user_details_mapper.dart';
import 'package:github_user_list/data/mappers/user_mapper.dart';
import 'package:github_user_list/data/models/user_details_model.dart';
import 'package:github_user_list/data/models/user_model.dart';
import 'package:github_user_list/domain/repositories/main/abstract_main_repository.dart';

class MainRepository implements AbstractMainRepository {
  MainRepository({required this.dio});

  Dio dio;
  final token = 'ACCESS_TOKEN';
  @override
  Future<List<UserModel>> getGitHubUsers({required int page}) async {
    var response = await dio.get(
      '${ApiUrls.getUsers}?since=${(page - 1) * 30}&per_page=30',
      options: Options(
        headers: {
          'Authorization': 'token $token',
        },
      ),
    );
    var userData = response.data as List<dynamic>;
    var userModel = userData.map((json) => UserDto.fromJson(json).toModel()).toList();
    return userModel;
  }

  @override
  Future<UserDetailsModel> getUserDetails({required String userName}) async {
    var response = await dio.get(
      '${ApiUrls.getUsers}/$userName',
      options: Options(
        headers: {
          'Authorization': 'token $token',
        },
      ),
    );
    var userDetailsData = response.data as Map<String, dynamic>;
    var userDetailsModel = UserDetailsDto.fromJson(userDetailsData).toModel();
    return userDetailsModel;
  }
}

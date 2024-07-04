import 'package:github_user_list/data/models/user_details_model.dart';
import 'package:github_user_list/data/models/user_model.dart';

abstract interface class AbstractMainRepository {
  Future<List<UserModel>> getGitHubUsers({required int page});
  Future<UserDetailsModel> getUserDetails({required String userName});
}

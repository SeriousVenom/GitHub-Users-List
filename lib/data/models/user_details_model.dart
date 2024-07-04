class UserDetailsModel {
  final String login;
  final int id;
  final String avatarUrl;
  final int followers;
  final int following;

  const UserDetailsModel({
    required this.login,
    required this.id,
    required this.avatarUrl,
    required this.followers,
    required this.following,
  });
}

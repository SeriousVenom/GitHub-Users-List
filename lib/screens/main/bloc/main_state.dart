import 'package:equatable/equatable.dart';
import 'package:github_user_list/config/lce.dart';
import 'package:github_user_list/data/models/user_details_model.dart';
import 'package:github_user_list/data/models/user_model.dart';

class MainState extends Equatable {
  final Lce<List<UserDetailsModel>> userDetailsList;
  final bool hasReachedMax;
  final String letterRange;

  const MainState({
    this.userDetailsList = const Lce.loading(),
    this.hasReachedMax = false,
    this.letterRange = 'A-H',
  });

  MainState copyWith({
    Lce<List<UserDetailsModel>>? userDetailsList,
    bool? hasReachedMax,
    String? letterRange,
  }) {
    return MainState(
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      letterRange: letterRange ?? this.letterRange,
      userDetailsList: userDetailsList ?? this.userDetailsList,
    );
  }

  @override
  List<Object?> get props => [hasReachedMax, letterRange, userDetailsList];
}

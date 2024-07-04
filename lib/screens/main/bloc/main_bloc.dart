import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_user_list/config/lce.dart';
import 'package:github_user_list/data/models/user_details_model.dart';
import 'package:github_user_list/domain/repositories/main/abstract_main_repository.dart';
import 'package:github_user_list/screens/main/bloc/main_events.dart';
import 'package:github_user_list/screens/main/bloc/main_state.dart';
import 'package:github_user_list/data/models/user_model.dart';

class MainBloc extends Bloc<MainEvents, MainState> {
  MainBloc(super.initialState, {required this.mainRepository}) {
    on<OnInit>(_onInit);
    on<LoadUsers>(_onLoadUsers);
    on<SearchUsers>(_onSearchUsers);
  }

  final AbstractMainRepository mainRepository;

  Future<void> _onInit(OnInit event, Emitter<MainState> emit) async {}

  Future<void> _onSearchUsers(SearchUsers event, Emitter<MainState> emit) async {
    if (event.query.isEmpty) {
      add(LoadUsers(page: 1, letterRange: state.letterRange));
    } else if (state.userDetailsList.hasContent) {
      final filteredUsers =
          state.userDetailsList.requiredContent.where((user) => user.login.toLowerCase().contains(event.query.toLowerCase())).toList();
      emit(state.copyWith(userDetailsList: Lce.content(filteredUsers)));
    }
  }

  Future<void> _onLoadUsers(LoadUsers event, Emitter<MainState> emit) async {
    try {
      if (event.page == 1) {
        emit(state.copyWith(userDetailsList: const Lce.loading()));
      }
      List<UserDetailsModel> userList = [];
      final newUsers = await mainRepository.getGitHubUsers(page: event.page);
      for (var user in newUsers) {
        final userDetails = await mainRepository.getUserDetails(userName: user.login);
        userList.add(userDetails);
      }
      final filteredNewUsers = _filterUsers(userList, event.letterRange);

      final allUsers = (event.page == 1
              ? <UserDetailsModel>[]
              : state.userDetailsList.hasContent
                  ? state.userDetailsList.requiredContent
                  : <UserDetailsModel>[]) +
          filteredNewUsers;

      emit(state.copyWith(
        userDetailsList: allUsers.asContent,
        hasReachedMax: filteredNewUsers.isEmpty,
        letterRange: event.letterRange,
      ));
    } on DioException catch (e) {
      print('Error: $e');
      emit(state.copyWith(userDetailsList: Lce.error(e.message)));
    }
  }

  List<UserDetailsModel> _filterUsers(List<UserDetailsModel> users, String? letterRange) {
    if (letterRange == null) return users;

    final ranges = {
      'A-H': RegExp(r'^[A-H]', caseSensitive: false),
      'I-P': RegExp(r'^[I-P]', caseSensitive: false),
      'Q-Z': RegExp(r'^[Q-Z]', caseSensitive: false),
    };

    final regex = ranges[letterRange];
    if (regex == null) return users;

    return users.where((user) => regex.hasMatch(user.login)).toList();
  }
}

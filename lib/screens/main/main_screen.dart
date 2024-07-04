import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:github_user_list/domain/repositories/main/abstract_main_repository.dart';
import 'package:github_user_list/screens/main/bloc/main_bloc.dart';
import 'package:github_user_list/screens/main/bloc/main_events.dart';
import 'package:github_user_list/screens/main/bloc/main_state.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _mainBloc = MainBloc(const MainState(), mainRepository: GetIt.I<AbstractMainRepository>());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('GitHub Users'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'A-H'),
              Tab(text: 'I-P'),
              Tab(text: 'Q-Z'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UsersTab(letterRange: 'A-H', mainBloc: _mainBloc),
            UsersTab(letterRange: 'I-P', mainBloc: _mainBloc),
            UsersTab(letterRange: 'Q-Z', mainBloc: _mainBloc),
          ],
        ),
      ),
    );
  }
}

class UsersTab extends StatefulWidget {
  final String letterRange;
  final MainBloc mainBloc;

  const UsersTab({super.key, required this.letterRange, required this.mainBloc});

  @override
  _UsersTabState createState() => _UsersTabState();
}

class _UsersTabState extends State<UsersTab> {
  final ScrollController _scrollController = ScrollController();
  int _page = 1;

  @override
  void initState() {
    super.initState();
    _loadUsers();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          _loadMoreUsers();
        }
      }
    });
  }

  @override
  void didUpdateWidget(UsersTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.letterRange != widget.letterRange) {
      _page = 1;
      _loadUsers(reset: true);
    }
  }

  void _loadUsers({bool reset = false}) {
    widget.mainBloc.add(LoadUsers(page: reset ? 1 : _page, letterRange: widget.letterRange));
  }

  void _loadMoreUsers() {
    _page++;
    widget.mainBloc.add(LoadUsers(page: _page, letterRange: widget.letterRange));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            decoration: const InputDecoration(
              hintText: 'Search by username',
              border: OutlineInputBorder(),
            ),
            onChanged: (query) {
              widget.mainBloc.add(SearchUsers(query: query));
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<MainBloc, MainState>(
            bloc: widget.mainBloc,
            builder: (context, state) {
              if (state.userDetailsList.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.userDetailsList.hasError) {
                return Center(child: Text(state.userDetailsList.requiredError.toString()));
              }

              return ListView.builder(
                controller: _scrollController,
                itemCount: state.userDetailsList.requiredContent.length,
                itemBuilder: (context, index) {
                  final user = state.userDetailsList.requiredContent[index];
                  return ListTile(
                    leading: Image.network(user.avatarUrl),
                    title: Text(user.login),
                    subtitle: Text('Followers: ${user.followers}, Following: ${user.following}'),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

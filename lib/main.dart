import 'package:flutter/material.dart';
import 'package:github_user_list/config/di.dart';
import 'package:github_user_list/screens/main/main_screen.dart';

void main() {
  diRegister();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: false,
      ),
      home: const MainScreen(),
    );
  }
}

// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'dart:convert';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: GitHubUsersScreen(),
//     );
//   }
// }
//
// class GitHubUsersScreen extends StatefulWidget {
//   @override
//   _GitHubUsersScreenState createState() => _GitHubUsersScreenState();
// }
//
// class _GitHubUsersScreenState extends State<GitHubUsersScreen> with SingleTickerProviderStateMixin {
//   late TabController _tabController;
//   TextEditingController _searchController = TextEditingController();
//
//   @override
//   void initState() {
//     super.initState();
//     _tabController = TabController(length: 3, vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _tabController.dispose();
//     _searchController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('GitHub Users'),
//         bottom: TabBar(
//           controller: _tabController,
//           tabs: [
//             Tab(text: 'A-H'),
//             Tab(text: 'I-P'),
//             Tab(text: 'Q-Z'),
//           ],
//         ),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _searchController,
//               decoration: InputDecoration(
//                 hintText: 'Search by username',
//                 prefixIcon: Icon(Icons.search),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               onChanged: (value) {
//                 setState(() {
//                   // Trigger a rebuild to filter the list based on search query
//                 });
//               },
//             ),
//           ),
//           Expanded(
//             child: TabBarView(
//               controller: _tabController,
//               children: [
//                 UserListTab(
//                   searchQuery: _searchController.text,
//                   startRange: 'A',
//                   endRange: 'H',
//                 ),
//                 UserListTab(
//                   searchQuery: _searchController.text,
//                   startRange: 'I',
//                   endRange: 'P',
//                 ),
//                 UserListTab(
//                   searchQuery: _searchController.text,
//                   startRange: 'Q',
//                   endRange: 'Z',
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class UserListTab extends StatefulWidget {
//   final String searchQuery;
//   final String startRange;
//   final String endRange;
//
//   UserListTab({required this.searchQuery, required this.startRange, required this.endRange});
//
//   @override
//   _UserListTabState createState() => _UserListTabState();
// }
//
// class _UserListTabState extends State<UserListTab> {
//   ScrollController _scrollController = ScrollController();
//   List<dynamic> _users = [];
//   int _page = 1;
//   bool _isLoading = false;
//   bool _hasMore = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMoreUsers();
//     _scrollController.addListener(() {
//       if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent && !_isLoading) {
//         _loadMoreUsers();
//       }
//     });
//   }
//
//   Future<void> _loadMoreUsers() async {
//     if (_isLoading || !_hasMore) return;
//     setState(() {
//       _isLoading = true;
//     });
//     Dio dio = Dio();
//     final response = await dio.get('https://api.github.com/users?since=${_users.isEmpty ? 0 : _users.last['id']}&per_page=30');
//     if (response.statusCode == 200) {
//       List<dynamic> fetchedUsers = json.decode(response.data);
//       if (fetchedUsers.isNotEmpty) {
//         for (var user in fetchedUsers) {
//           final userDetails = await _fetchUserDetails(user['login']);
//           user['followers'] = userDetails['followers'];
//           user['following'] = userDetails['following'];
//         }
//         setState(() {
//           _users.addAll(fetchedUsers);
//         });
//       } else {
//         setState(() {
//           _hasMore = false;
//         });
//       }
//     } else {
//       // Handle the error
//     }
//
//     setState(() {
//       _isLoading = false;
//     });
//   }
//
//   Future<Map<String, dynamic>> _fetchUserDetails(String username) async {
//     Dio dio = Dio();
//     final response = await dio.get('https://api.github.com/users/$username');
//     if (response.statusCode == 200) {
//       return json.decode(response.data);
//     } else {
//       // Handle the error
//       return {'followers': 0, 'following': 0};
//     }
//   }
//
//   List<dynamic> get filteredUsers {
//     return _users.where((user) {
//       final username = user['login'].toString().toUpperCase();
//       return username.startsWith(RegExp('[${widget.startRange}-${widget.endRange}]')) &&
//           (widget.searchQuery.isEmpty || username.contains(widget.searchQuery.toUpperCase()));
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       controller: _scrollController,
//       itemCount: filteredUsers.length + 1,
//       itemBuilder: (context, index) {
//         if (index == filteredUsers.length) {
//           return _isLoading ? Center(child: CircularProgressIndicator()) : SizedBox.shrink();
//         }
//
//         final user = filteredUsers[index];
//         return ListTile(
//           leading: CircleAvatar(
//             backgroundImage: NetworkImage(user['avatar_url']),
//           ),
//           title: Text(user['login']),
//           subtitle: Text('Followers: ${user['followers']}, Following: ${user['following']}'),
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
// }

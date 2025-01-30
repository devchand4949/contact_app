import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactapp/screens/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:azlistview/azlistview.dart';

import '../models/contact_model.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";
  List<UserModel> _users = [];
  FocusNode _focusNode = FocusNode();  // Added FocusNode

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  void _fetchUsers() {
    FirebaseFirestore.instance
        .collection('users')
        .snapshots()
        .listen((snapshot) {
      List<UserModel> users = snapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data(), doc.id);
      }).toList();

      for (var user in users) {
        user.tagIndex = user.name[0].toUpperCase();
      }
      SuspensionUtil.sortListBySuspensionTag(users);
      setState(() {
        _users = users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<UserModel> filteredUsers = _users.where((user) {
      return user.name.toLowerCase().contains(_searchQuery);
    }).toList();

    return SingleChildScrollView( // Wrap the Column with SingleChildScrollView
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              focusNode: _focusNode,  // Attached FocusNode to the TextField
              decoration: InputDecoration(
                labelText: "Search",
                hintText: "Search by name",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value.toLowerCase();
                });
              },
            ),
          ),
          SizedBox(height: 8),
          // Wrap AzListView with Expanded and ensure it works with available space
          Container(
            height: MediaQuery.of(context).size.height - 200,  // Adjust height based on keyboard visibility
            child: AzListView(
              data: filteredUsers,
              itemCount: filteredUsers.length, // Ensure this is added
              itemBuilder: (context, index) =>
                  _buildListItem(filteredUsers[index], context),
              indexBarOptions: IndexBarOptions(),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();  // Dispose of the FocusNode
    super.dispose();
  }

  Widget _buildListItem(UserModel user, BuildContext context) {
    return ListTile(
      title: Text(
        user.name,
        style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Theme.of(context).colorScheme.surface,
            fontWeight: FontWeight.bold),
      ),
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) => DetailScreen(detailScn: user)),
        );
      },
    );
  }
}

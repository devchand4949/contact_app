import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactapp/screens/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contactapp/models/contact_model.dart';

class ListWidget extends StatefulWidget {
  const ListWidget({super.key});

  @override
  State<ListWidget> createState() => _ListWidgetState();
}

class _ListWidgetState extends State<ListWidget> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  Widget build(BuildContext context) {
    final firebase = FirebaseFirestore.instance.collection('users').snapshots();

    return Column(
      children: [
        // सर्च इनपुट फ़ील्ड
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
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
        // Firebase से डेटा स्ट्रीम
        Expanded(
          child: StreamBuilder<QuerySnapshot>(
              stream: firebase,
              builder: (BuildContext, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasError) {
                  return Center(
                    child: Text('Data not found'),
                  );
                }

                // डेटा को सर्च इनपुट के आधार पर फ़िल्टर करना
                final users = snapshot.data!.docs
                    .map((doc) => UserModel.fromJson(
                    doc.data() as Map<String, dynamic>, doc.id))
                    .where((user) => user.name
                    .toLowerCase()
                    .contains(_searchQuery)) // नाम पर फ़िल्टर
                    .toList();

                return ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    return ListTile(
                      title: Text(
                        user.name,
                        style: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(
                            color: Theme.of(context).colorScheme.surface,
                            fontWeight: FontWeight.bold),
                      ),
                      trailing: IconButton(
                        icon: Icon(CupertinoIcons.right_chevron),
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(detailScn: user)));
                        },
                      ),
                    );
                  },
                );
              }),
        ),
      ],
    );
  }
}

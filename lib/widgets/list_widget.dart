import 'dart:io';
import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/screens/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:contactapp/models/contact_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final firebase = FirebaseFirestore.instance.collection('users').snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: firebase,
        builder: (BuildContext, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return ScaffoldMessenger(
                child: SnackBar(content: Text('data not found')));
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final users = snapshot.data!.docs.map((doc) {
                  print(doc.data());//...........................
                  return UserModel.fromJson(
                      doc.data() as Map<String, dynamic>, doc.id);
                }).toList();
                final user = users[index];

                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    // CircleAvatar show image if available or initial letter
                    // leading: CircleAvatar(
                    //   radius: 20,
                    //   backgroundImage: contactmodel[index].image != null && contactmodel[index].image!.existsSync()
                    //       ? FileImage(contactmodel[index].image!)
                    //       : null,
                    //   child: contactmodel[index].image == null || !contactmodel[index].image!.existsSync()
                    //       ? Text(
                    //     contactmodel[index].name.isNotEmpty ? contactmodel[index].name[0].toUpperCase() : 'A',
                    //     style: TextStyle(fontSize: 20, color: Colors.white),
                    //   )
                    //       : null,
                    // ),
                    // Name field show
                    title: Text(
                      user.name,
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(
                          color:
                          Theme.of(context).colorScheme.surface,
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
                  ),
                );

              });
        });
  }
}
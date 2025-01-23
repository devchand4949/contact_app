import 'dart:io';
import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/screens/detail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ListWidget extends StatelessWidget {
  const ListWidget({super.key, required this.contactmodel});

  final List<ContactModel> contactmodel;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: contactmodel.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              // CircleAvatar show image if available or initial letter
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: contactmodel[index].image != null && contactmodel[index].image!.existsSync()
                    ? FileImage(contactmodel[index].image!)
                    : null,
                child: contactmodel[index].image == null || !contactmodel[index].image!.existsSync()
                    ? Text(
                  contactmodel[index].name.isNotEmpty ? contactmodel[index].name[0].toUpperCase() : 'A',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )
                    : null,
              ),
              // Name field show
              title: Text(
                contactmodel[index].name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.surface, fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                icon: Icon(CupertinoIcons.right_chevron),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => DetailScreen(detailScn: contactmodel[index])));
                },
              ),
            ),
          );
        });
  }
}

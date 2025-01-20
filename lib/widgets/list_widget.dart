import 'package:contactapp/models/contact_model.dart';
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
            padding: const EdgeInsets.symmetric(vertical: 8,),
            child: ListTile(
              leading: CircleAvatar(
                radius: 26,
                backgroundImage: FileImage(contactmodel[index].image),
              ),
              title: Text(
                contactmodel[index].name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surface,
                    ),
              ),
              trailing: IconButton(
                icon: Icon(CupertinoIcons.right_chevron),
                onPressed: () {},
              ),
            ),
          );
        });
  }
}

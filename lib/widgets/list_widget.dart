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
              // circleavatar show..............
              leading: CircleAvatar(
                radius: 20,
                backgroundImage: FileImage(contactmodel[index].image),
              ),
              // name field show .....................
              title: Text(
                contactmodel[index].name,
                style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.surface,fontWeight: FontWeight.bold
                    ),
              ),

              trailing: IconButton(
                icon: Icon(CupertinoIcons.right_chevron),
                onPressed: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailScreen(detailScn:contactmodel[index],)));
                },
              ),
            ),
          );
        });
  }
}

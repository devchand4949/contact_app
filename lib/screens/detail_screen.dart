import 'package:contactapp/main.dart';
import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/screens/home_sceen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactapp/screens/update_screen.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.detailScn});

  final UserModel detailScn;

  void _delete(BuildContext context) {
    FirebaseFirestore.instance.collection('users').snapshots();
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(detailScn.id).delete();
    Navigator.of(context).push(MaterialPageRoute(builder: (screen)=>HomeScreen()));
      print('delete');
  }

  void _showoption(context) async {
    print('showoption');
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Select Operation',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.normal),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            UpdateScreen(usermodel: detailScn),
                      ),
                    );
                  },
                  child: Text('Update'),
                ),
                TextButton(
                    onPressed: () => _delete(context), child: Text('Delete'))
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Contact Detail',
        ),
        toolbarHeight: 80,
        actions: [
          TextButton(
              onPressed: () => _showoption(context),
              child: Text(
                'Edit & delete',
                style: theme.textTheme.titleLarge,
              ))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  // CircleAvatar(//show picture in detailscreen
                  //   backgroundImage: FileImage(detailScn.image),
                  //   radius: 70,
                  // ),
                  const SizedBox(
                    height: 10,
                  ),
                  //show name in detailscreen
                  Text(
                    detailScn.name,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Theme.of(context).colorScheme.surface,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.normal),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //show phone in detailscreen
                  Text(
                    detailScn.contactNo,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                        letterSpacing: 0.5,
                        fontWeight: FontWeight.normal),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    height: 10,
                    thickness: 3,
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Text(
              detailScn.email,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.normal,
                  ),
            )
          ],
        ),
      ),
    );
  }
}

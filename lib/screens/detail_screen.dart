import 'package:contactapp/main.dart';
import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/screens/home_sceen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:contactapp/screens/update_screen.dart';
import 'package:direct_call_plus/direct_call_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({super.key, required this.detailScn});

  final UserModel detailScn;

  void _delete(BuildContext context) {
    FirebaseFirestore.instance.collection('users').snapshots();
    CollectionReference ref = FirebaseFirestore.instance.collection('users');
    ref.doc(detailScn.id).delete();
    // सभी स्क्रीन को पॉप करने के बाद होम स्क्रीन पर नेविगेट करें
    Navigator.of(context).popUntil((route) =>
        route.isFirst); // यह होम स्क्रीन पर जाने तक सभी स्क्रीन को पॉप कर देगा
    print('delete');
  }

  void _calling()async{
    try {
      bool? result =
          await DirectCallPlus.makeCall(detailScn.contactNo);
      if (result == false) {
        print("Call could not be initiated");
      }
    } catch (e) {
      print("Error making call: $e");
    }
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
        padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.red,
                    //show picture in detailscreen
                    // backgroundImage: FileImage(detailScn.image),
                    child: Text(
                      detailScn.name[0].toUpperCase(),style: TextStyle(
                      fontSize: 60,

                    ),
                    ),
                    radius: 50,
                  ),
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
                        fontWeight: FontWeight.normal,),
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
            //................................
            const SizedBox(
              height: 30,
            ),
            // email row..................
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.email_outlined),
                SizedBox(width: 20,),
                Text(
                  detailScn.email,
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.surface,
                    letterSpacing: 0.5,
                    fontWeight: FontWeight.normal,
                  ),
                ),

              ],
            ),
            SizedBox(
              height: 20,
            ),
            //calling row................
            GestureDetector(
              onTap: _calling,
              child: Row(
                children: [
                  const Icon(Icons.call),
                  const SizedBox(width: 20,),
                  Text(
                    detailScn.contactNo,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onTertiary,
                      fontSize: 22,
                      letterSpacing: 0.5,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            )

          ],
        ),
      ),
    );
  }
}

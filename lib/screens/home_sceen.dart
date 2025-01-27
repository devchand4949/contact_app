import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/providers/contact_provider.dart';
import 'package:contactapp/screens/input_screen.dart';
import 'package:contactapp/widgets/list_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context,) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Contacts'),
        toolbarHeight: 80,
        actions: [
          IconButton(
            icon: Icon(Icons.add,size: 30,),
            onPressed: () async {
              // Navigate to InputScreen and wait for the result
              await Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => InputScreen(),
                ),
              );
            },
          )
        ],
      ),
      body:ListWidget()
    );
  }
}

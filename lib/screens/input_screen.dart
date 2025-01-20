import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/providers/contact_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputScreen extends ConsumerStatefulWidget {
   InputScreen({super.key});

  @override
  ConsumerState<InputScreen> createState() => _InputScreenState();

}

class _InputScreenState extends ConsumerState<InputScreen> {

  final _nameController = TextEditingController();

  void _saveData(){

    final saveNameController = _nameController.text;
    if(saveNameController.isEmpty){
      return;
    }
    ref.read(ContactProvider.notifier).addModel(saveNameController);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Contact'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveData,
          )
        ],
      ),

      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                child: Icon(Icons.person),
              ),
            ),
            SizedBox(height: 30,),
            TextField(
              controller:_nameController,
              decoration: InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
            ),
          ],
        ),
      ),
    );
  }
}

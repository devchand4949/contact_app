import 'dart:io';

import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/providers/contact_provider.dart';
import 'package:contactapp/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputScreen extends ConsumerStatefulWidget {
  InputScreen({super.key});

  @override
  ConsumerState<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends ConsumerState<InputScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  File? _selectedImage;

  void _saveData() {
    final saveNameController = _nameController.text;
    final savePhoneController = _phoneController.text;
    final saveEmailController = _emailController.text;
    if (saveNameController.isEmpty ||
        _selectedImage == null ||
        savePhoneController.isEmpty ||
        saveEmailController.isEmpty) {
      return;
    }
    ref
        .read(ContactProvider.notifier)
        .addModel(saveNameController, _selectedImage!,savePhoneController,saveEmailController);
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
            // camera screen
            CameraScreen(onSelectPicker: (image) {
              _selectedImage = image;
            }),
            SizedBox(
              height: 30,
            ),
            //name field.......................
            TextField(
              controller: _nameController,
              maxLength: 30,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                  labelText: 'Name', border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 20,
            ),
            // phone field ......................
            TextField(
              controller: _phoneController,
              maxLength: 10,
              decoration: InputDecoration(
                prefix: Text('+91'),
                  labelText: 'Phone', border: OutlineInputBorder()),
              keyboardType: TextInputType.phone,
            ),
            SizedBox(
              height: 20,
            ),
            // email fielod ......................
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                  labelText: 'Email', border: OutlineInputBorder()),
              keyboardType: TextInputType.emailAddress,
            )
          ],
        ),
      ),
    );
  }
}

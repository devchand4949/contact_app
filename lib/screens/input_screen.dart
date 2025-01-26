import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/screens/camera_screen.dart';
import 'package:flutter/material.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();  // GlobalKey for form validation
  // File? _selectedImage;

  void _saveData() async {
    if(_formKey.currentState!.validate()) {
      final saveNameController = _nameController.text.trim();
      final savePhoneController = _phoneController.text.trim();
      final saveEmailController = _emailController.text.trim();
      // if (_selectedImage == null) {
      //   print('Please select an image');
      //   return;
      // }

      final id = Uuid().v4();
      final user = UserModel(id: id, name: saveNameController, email: saveEmailController, contactNo: savePhoneController);
      final firebase = await FirebaseFirestore.instance.collection('users');
      await firebase.doc(id).set(user.toJson());

      Navigator.of(context).pop();
    }
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
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(  // Wrap fields with a Form widget
          key: _formKey,  // Assign the GlobalKey to the form
          child: Column(
            children: [
              // CameraScreen(onSelectPicker: (image) {
              //   _selectedImage = image;
              // }),
              SizedBox(height: 30),
              // Name field..........................
              TextFormField(
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your name';
                  }
                  return null;
                },
                maxLength: 30,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              // Phone field...........................
              TextFormField(
                controller: _phoneController,
                maxLength: 10,
                decoration: InputDecoration(
                  prefix: Text('+91'),
                  labelText: 'Phone',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a phone number';
                  }
                  if (value.length != 10) {
                    return 'Enter a 10-digit phone number';
                  }
                  return null;  // No error if the phone number is valid
                },
              ),
              SizedBox(height: 20),
              // Email field..........................................
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email address';
                  }
                  if(!EmailValidator.validate(value)){//using package in email validator
                    return 'Please enter valid email address';
                  }
                  return null;  // No error if the email is valid
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:io';
import 'package:uuid/uuid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/screens/camera_screen.dart';
import 'package:flutter/material.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({super.key,required this.usermodel});

  final UserModel usermodel;

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();  // GlobalKey for form validation
  // File? _selectedImage;

  @override
  void initState() {
     _nameController.text =  widget.usermodel.name;
     _phoneController.text = widget.usermodel.contactNo;
     _emailController.text = widget.usermodel.email;
    super.initState();
  }

  void _saveData() async {
    print('call update method');
    if (_formKey.currentState!.validate()) {
      final saveNameController = _nameController.text;
      final savePhoneController = _phoneController.text;
      final saveEmailController = _emailController.text;
      _formKey.currentState!.save();
      // if (_selectedImage == null) {
      //   print('Please select an image');
      //   return;
      // }

      final id = Uuid().v4();
      final user = UserModel(id: widget.usermodel.id, name: saveNameController, email: saveEmailController, contactNo: savePhoneController);
      final firebase = FirebaseFirestore.instance.collection('users');
      await firebase.doc(user.id).update(user.toJson());
      print('data update sucessfully');
    Navigator.of(context).pop();

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Contact'),
        actions: [
          TextButton(
            child: Text('Save'),
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

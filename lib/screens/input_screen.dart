import 'dart:io';
import 'package:email_validator/email_validator.dart';
import 'package:contactapp/models/contact_model.dart';
import 'package:contactapp/providers/contact_provider.dart';
import 'package:contactapp/screens/camera_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InputScreen extends ConsumerStatefulWidget {
  const InputScreen({super.key});

  @override
  ConsumerState<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends ConsumerState<InputScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();  // GlobalKey for form validation
  File? _selectedImage;

  void _saveData() {
    if (_formKey.currentState?.validate() ?? false) {
      final saveNameController = _nameController.text;
      final savePhoneController = _phoneController.text;
      final saveEmailController = _emailController.text;

      // Placeholder for default image if none selected
      final ifbydefaultImage = _selectedImage ?? File('path_to_default_image_or_icon_placeholder');

      // Add contact if validation passes
      ref.read(ContactProvider.notifier).addModel(
          saveNameController,
          ifbydefaultImage,
          savePhoneController,
          saveEmailController
      );

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
              CameraScreen(onSelectPicker: (image) {
                _selectedImage = image;
              }),
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
                  final phoneRegExp = RegExp(r'^\+?[0-9]$');
                  if (!phoneRegExp.hasMatch(value)) {
                    return 'Please enter a valid phone number';
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

// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
//
// class CameraScreen extends  StatefulWidget{
//   const CameraScreen({super.key, required this.onSelectPicker});
//
//   final void Function(File image) onSelectPicker;
//
//   @override
//   State<CameraScreen> createState() => _CameraScreenState();
// }
//
// class _CameraScreenState extends State<CameraScreen> {
//   File? _selectedImage;
//
//   void _tackPicker() async {
//     final imagePicker = ImagePicker();
//     final pickImage = await imagePicker.pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickImage == null) {
//       return;
//     }
//     setState(() {
//       _selectedImage = File(pickImage.path);
//     });
//
//     widget.onSelectPicker(_selectedImage!);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: IconButton(
//         onPressed: _tackPicker,
//         icon: CircleAvatar(
//           radius: 50,
//           backgroundImage:
//               _selectedImage != null ? FileImage(_selectedImage!) : null,
//           child: _selectedImage == null ? Icon(Icons.person) : null,
//         ),
//       ),
//     );
//   }
// }

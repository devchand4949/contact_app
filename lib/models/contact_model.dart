
import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class ContactModel {
   ContactModel({
    required this.name,
     required this.image,
     required this.phone,
     required this.email
}) : id = uuid.v4();

  final String id;
  final String name;
  final File image;
  final String phone;
  final String email;


   Map<String,dynamic> toJson(){
     return{
       'name' : name,
       'image' : image,
       'phone' : phone,
       'email' : email
     };
   }
}


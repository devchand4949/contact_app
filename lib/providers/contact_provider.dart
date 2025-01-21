import 'dart:io';

import 'package:contactapp/models/contact_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ContactNotifier extends StateNotifier<List<ContactModel>>{
  ContactNotifier() : super(const []);

  void addModel(String name,File image,String phone,String email){
      final newContact = ContactModel(name: name,image:image,phone: phone,email: email);
      state = [newContact,...state];
  }
}

final ContactProvider = StateNotifierProvider<ContactNotifier,List<ContactModel>>((ref)=>ContactNotifier());
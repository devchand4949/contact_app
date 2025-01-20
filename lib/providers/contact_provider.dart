import 'dart:io';

import 'package:contactapp/models/contact_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class ContactNotifier extends StateNotifier<List<ContactModel>>{
  ContactNotifier() : super(const []);

  void addModel(String name,File image){
      final newContact = ContactModel(name: name,image:image);
      state = [newContact,...state];
  }
}

final ContactProvider = StateNotifierProvider<ContactNotifier,List<ContactModel>>((ref)=>ContactNotifier());
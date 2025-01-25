// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:contactapp/models/contact_model.dart';
//
// // Firestore instance provider
// final firestoreProvider = Provider((ref) => FirebaseFirestore.instance);
//
// // StateNotifierProvider for managing users
// final userProvider = StateNotifierProvider<UserNotifier, List<UserModel>>((ref) {
//   return UserNotifier(ref);
// });
//
// class UserNotifier extends StateNotifier<List<UserModel>> {
//   final Ref _ref;
//
//   UserNotifier(this._ref) : super([]);
//
//   // Add a user to Firestore and update the state
//   Future<void> addUser(UserModel user) async {
//     final firestore = _ref.read(firestoreProvider);
//     await firestore.collection('users').doc(user.id).set(user.toJson());
//     state = [...state, user];
//   }
//
//   // Fetch users from Firestore and update the state
//   Future<void> fetchUsers() async {
//     final firestore = _ref.read(firestoreProvider);
//     final snapshot = await firestore.collection('users').get();
//     state = snapshot.docs.map((doc) => UserModel.fromJson(doc.data(), doc.id)).toList();
//   }
// }

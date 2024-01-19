import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strings_social_media/models/post_model.dart';

import '../models/user_model.dart';

class UserRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> getUserById(String uid) async {
    final snapshot = await _firestore.collection('users').doc(uid).get();
    return UserModel.fromDoc(snapshot);
  }

  Future<void> createUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).set(user.toJson());
  }

  Future<void> updateUser(UserModel user) async {
    await _firestore.collection('users').doc(user.uid).update(user.toJson());
  }

  Future<void> deleteUser(String uid) async {
    await _firestore.collection('users').doc(uid).delete();
  }

  Future<List<UserModel>> getUsers() async {
    final snapshot = await _firestore.collection('users').get();
    return snapshot.docs.map((doc) => UserModel.fromDoc(doc)).toList();
  }

  Future<List<UserModel>> getUsersByName(String name) async {
    final snapshot = await _firestore
        .collection('users')
        .where('name', isEqualTo: name)
        .get();
    return snapshot.docs.map((doc) => UserModel.fromDoc(doc)).toList();
  }
}
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class ImageHandlerRepository {
  var firebaseStorage = FirebaseStorage.instance;

  Future<String> uploadProfilePicture(String uid, String filePath) async {
    String extension = filePath.split('.').last;
    var ref = firebaseStorage.ref().child('profile_pictures/$uid.$extension');
    var file = File(filePath);
    var uploadTask = ref.putFile(file);
    var snapshot = await uploadTask.whenComplete(() => null);
    return await snapshot.ref.getDownloadURL();
  }

  Future<String> uploadPostImage(
      String uid, String imageUid, String filePath) async {
    String extension = filePath.split('.').last;
    var ref =
        firebaseStorage.ref().child('post_images/$uid/$imageUid.$extension');
    var file = File(filePath);
    var uploadTask = ref.putFile(file);
    var snapshot = await uploadTask.whenComplete(() => null);
    return await snapshot.ref.getDownloadURL();
  }
}

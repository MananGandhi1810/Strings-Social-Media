class UserModel{
  final String uid;
  final String name;
  final String email;
  final String? photoUrl;
  final String bio;

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.photoUrl,
    required this.bio,
  });

  factory UserModel.fromDoc(dynamic doc){
    return UserModel(
      uid: doc.id,
      name: doc['name'],
      email: doc['email'],
      photoUrl: doc['photoUrl'],
      bio: doc['bio'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'photoUrl': photoUrl,
      'bio': bio,
    };
  }
}
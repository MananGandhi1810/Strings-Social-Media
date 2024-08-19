import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:strings_social_media/models/post_model.dart';

class PostRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> createPost(PostModel post) async {
    await _firestore.collection('posts').add(post.toJson());
  }

  Future<void> updatePost(PostModel post) async {
    await _firestore.collection('posts').doc(post.id).update(post.toJson());
  }

  Future<void> deletePost(String postId) async {
    await _firestore.collection('posts').doc(postId).delete();
  }

  Future<List<PostModel>> getPosts() async {
    final snapshot =
        await _firestore.collection('posts').orderBy("timestamp").get();
    return snapshot.docs.map((doc) => PostModel.fromDoc(doc)).toList();
  }

  Stream<QuerySnapshot> getPostsAsStream() {
    return _firestore
        .collection('posts')
        .orderBy("timestamp", descending: true)
        .snapshots();
  }

  Future<List<PostModel>> getPostsByAuthorId(String authorId) async {
    final snapshot = await _firestore
        .collection('posts')
        .where('authorId', isEqualTo: authorId)
        .get();
    return snapshot.docs.map((doc) => PostModel.fromDoc(doc)).toList();
  }

  Future<List<PostModel>> getPostsByParentId(String parentId) async {
    final snapshot = await _firestore
        .collection('posts')
        .where('parentId', isEqualTo: parentId)
        .get();
    return snapshot.docs.map((doc) => PostModel.fromDoc(doc)).toList();
  }
}

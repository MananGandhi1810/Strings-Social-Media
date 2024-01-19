import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel{
  final String id;
  final String content;
  final List<dynamic>? images;
  final String authorId;
  final Timestamp timestamp;
  final int likes;
  final int comments;
  final bool isComment;
  final String? parentId;
  final String? parentAuthorId;

  PostModel({
    required this.id,
    required this.content,
    required this.images,
    required this.authorId,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.isComment,
    required this.parentId,
    required this.parentAuthorId,
  });

  factory PostModel.fromDoc(dynamic doc){
    return PostModel(
      id: doc.id,
      content: doc['content'],
      images: doc['images'],
      authorId: doc['authorId'],
      timestamp: doc['timestamp'],
      likes: doc['likes'],
      comments: doc['comments'],
      isComment: doc['isComment'],
      parentId: doc['parentId'],
      parentAuthorId: doc['parentAuthorId'],
    );
  }

  Map<String, dynamic> toJson(){
    return {
      'id': id,
      'content': content,
      'images': images,
      'authorId': authorId,
      'timestamp': timestamp,
      'likes': likes,
      'comments': comments,
      'isComment': isComment,
      'parentId': parentId,
      'parentAuthorId': parentAuthorId,
    };
  }
}
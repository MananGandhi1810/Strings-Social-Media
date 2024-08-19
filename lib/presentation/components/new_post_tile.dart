import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:strings_social_media/models/post_model.dart';
import 'package:strings_social_media/repositories/auth_repository.dart';
import 'package:strings_social_media/repositories/profile_picture_repository.dart';
import 'package:strings_social_media/repositories/user_repository.dart';
import 'package:uuid/uuid.dart';

import '../../models/user_model.dart';
import '../../repositories/post_repository.dart';

class NewPostTile extends StatefulWidget {
  const NewPostTile({super.key});

  @override
  State<NewPostTile> createState() => _NewPostTileState();
}

class _NewPostTileState extends State<NewPostTile> {
  final TextEditingController _postController = TextEditingController();
  final List<String> _images = [];
  final List<String> _imageUrls = [];
  late User? user;
  late UserModel? userData;

  void fetchCurrentUser() async {
    user = AuthRepository().currentUser;
    userData = await UserRepository().getUserById(user!.uid);
    setState(() {});
  }

  @override
  void initState() {
    fetchCurrentUser();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 20,
        child: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(45),
          ),
          child: userData == null
              ? const CircularProgressIndicator()
              : userData!.photoUrl == null
                  ? const FlutterLogo()
                  : Image.network(userData!.photoUrl!),
        ),
      ),
      title: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _postController,
              decoration: InputDecoration(
                hintText: "What's on your mind?",
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.grey[50]!.withOpacity(0.25),
                  ),
                ),
              ),
              maxLines: null,
            ),
          ),
          IconButton(
            onPressed: () {
              ImagePicker().pickMultiImage().then((images) {
                if (images.isNotEmpty) {
                  setState(() {
                    for (var image in images) {
                      _images.add(image.path);
                    }
                    debugPrint(_images.toString());
                  });
                }
              });
            },
            icon: const Icon(Icons.image),
          ),
        ],
      ),
      subtitle: _images.isNotEmpty
          ? SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _images.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.fromLTRB(0, 8, 2, 0),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          _images.removeAt(index);
                        });
                      },
                      child: Image.file(
                        File(_images[index]),
                        height: 100,
                        width: 100,
                        fit: BoxFit.contain,
                      ),
                    ),
                  );
                },
              ),
            )
          : null,
      trailing: ElevatedButton(
        onPressed: () async {
          var uuid = const Uuid();
          debugPrint(_postController.text);
          if (_postController.text.isEmpty) {
            return;
          }
          if (_images.isNotEmpty) {
            for (var image in _images) {
              _imageUrls.add(await ImageHandlerRepository()
                  .uploadPostImage(user!.uid, uuid.v4(), image));
            }
          }
          PostModel newPost = PostModel(
            id: uuid.v4(),
            content: _postController.text,
            images: _imageUrls,
            authorId: user!.uid,
            timestamp: Timestamp.now(),
            likes: 0,
            comments: 0,
            isComment: false,
            parentId: null,
            parentAuthorId: null,
          );
          await PostRepository().createPost(newPost);
          setState(() {
            _postController.clear();
            _images.clear();
            _imageUrls.clear();
          });
        },
        child: const Text("Post"),
      ),
    );
  }
}

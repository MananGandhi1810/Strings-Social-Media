import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:strings_social_media/repositories/auth_repository.dart';
import 'package:strings_social_media/repositories/post_repository.dart';
import 'package:uuid/uuid.dart';

import '../models/post_model.dart';
import 'components/new_post_tile.dart';
import 'components/post_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const FlutterLogo(
          size: 50,
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: PostRepository().getPostsAsStream(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            final posts = snapshot.data!.docs
                .map((e) => PostModel.fromDoc(e))
                .toList();
            return ListView.builder(
              itemCount: posts.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return const NewPostTile();
                }
                return PostTile(
                  post: posts[index - 1],
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }
}

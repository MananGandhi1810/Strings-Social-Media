import 'package:flutter/material.dart';
import 'package:strings_social_media/repositories/user_repository.dart';

import '../../models/post_model.dart';
import '../../models/user_model.dart';
import '../profile_page.dart';

class PostTile extends StatefulWidget {
  const PostTile({super.key, required this.post});

  final PostModel post;

  @override
  State<PostTile> createState() => _PostTileState();
}

class _PostTileState extends State<PostTile> {
  UserModel? userData;

  void fetchUserData() async {
    userData = await UserRepository().getUserById(widget.post.authorId);
    setState(() {});
    debugPrint("User data: ${userData!.photoUrl} ${userData!.name}");
  }

  @override
  void initState() {
    fetchUserData();
    debugPrint("User data: $userData");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey[50]!.withOpacity(0.25),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
        child: InkWell(
          onTap: () {},
          child: Column(
            children: [
              ListTile(
                leading: GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(
                          userId: userData!.uid,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: userData == null
                          ? const CircularProgressIndicator()
                          : userData!.photoUrl == null
                              ? const FlutterLogo()
                              : Image.network(userData!.photoUrl!),
                    ),
                  ),
                ),
                title: Text(
                  userData?.name ?? "",
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  widget.post.content,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              widget.post.images == null || widget.post.images!.isEmpty
                  ? const SizedBox.shrink()
                  : SizedBox(
                      height: 100,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: widget.post.images!.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.network(
                              widget.post.images![index],
                            ),
                          );
                        },
                      ),
                  ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_border, size: 20),
                      ),
                      Text(
                        "${widget.post.likes}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.comment, size: 20),
                      ),
                      Text(
                        "${widget.post.comments}",
                        style: const TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

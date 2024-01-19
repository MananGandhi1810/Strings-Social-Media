import 'package:flutter/material.dart';

import '../models/user_model.dart';
import '../repositories/user_repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key, required this.userId});

  final String userId;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  UserModel? userData;

  void fetchUserData() async {
    userData = await UserRepository().getUserById(widget.userId);
    setState(() {});
  }

  @override
  void initState() {
    fetchUserData();
    debugPrint("User data: $userData");
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(50),
                child: userData == null
                    ? const CircularProgressIndicator()
                    : userData!.photoUrl == null
                    ? const FlutterLogo()
                    : Image.network(
                    userData!.photoUrl!),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Text(
              userData?.name ?? "",
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
            ),
            Text(
              userData?.bio ?? "",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

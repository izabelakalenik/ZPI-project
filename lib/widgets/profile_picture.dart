import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zpi_project/database_configuration/storage_service.dart';
import 'package:zpi_project/database_configuration/authentication_service.dart';

// based on tutorial: https://www.youtube.com/watch?v=tCN395wN3pY

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  StorageService storage = StorageService();
  final AuthenticationService authService = AuthenticationService();
  Uint8List? pickedImage;

  @override
  void initState() {
    super.initState();
    getProfilePicture();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: onProfileTapped,
        child: Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              image: pickedImage != null
                  ? DecorationImage(
                      fit: BoxFit.cover,
                      image: Image.memory(
                        pickedImage!,
                        fit: BoxFit.cover,
                      ).image)
                  : null,
            ),
            child: Center(
                child: pickedImage != null
                    ? null
                    : Icon(Icons.person_rounded,
                        color: Color(0xFFD08C4E), size: 150))));
  }

  Future<void> onProfileTapped() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image == null) return;

    final currentUser = authService.getCurrentUser();
    if (currentUser == null) return;

    String fileName = "${currentUser.uid}_profile_picture.jpg";
    await storage.uploadFile(fileName, image);

    final imageBytes = await image.readAsBytes();
    setState(() => pickedImage = imageBytes);
  }

  Future<void> getProfilePicture() async {
    final currentUser = authService.getCurrentUser();
    if (currentUser == null) return;

    String fileName = "${currentUser.uid}_profile_picture.jpg";

    try {
      final imageBytes = await storage.downloadFile(fileName);
      if (imageBytes != null) {
        setState(() => pickedImage = imageBytes);
      }
    } catch (e) {return;}
  }
}


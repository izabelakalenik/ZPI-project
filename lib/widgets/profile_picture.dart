import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zpi_project/database_configuration/storage_service.dart';

// based on tutorial: https://www.youtube.com/watch?v=tCN395wN3pY

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  StorageService storage = StorageService();
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
    await storage.uploadFile("username_profile_picture.jpg", image);

    final imageBytes = await image.readAsBytes();
    setState(() => pickedImage = imageBytes);
  }

  Future<void> getProfilePicture() async {
    final imageBytes = await storage.downloadFile("username_profile_picture.jpg");
    if (imageBytes == null) return;
    setState(() => pickedImage = imageBytes as Uint8List?);
  }
}


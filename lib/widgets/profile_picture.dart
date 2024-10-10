import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// based on tutorial: https://www.youtube.com/watch?v=tCN395wN3pY

class ProfilePicture extends StatefulWidget {
  const ProfilePicture({super.key});

  @override
  State<StatefulWidget> createState() => _ProfilePictureState();
}

class _ProfilePictureState extends State<ProfilePicture> {
  Uint8List? pickedImage;

  @override
  void initState() {
    super.initState();
    // getProfilePicture();
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
                        color: Colors.amberAccent, size: 150))));
  }

  Future<void> onProfileTapped() async {
    // 1. Choose image from device
    // 2. TODO: Upload image to storage service
    // 3. Show and persist image in the app

    // 1.
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    if (image == null) return;

    // 2. For the future
    // final storageRef = FirebaseStorage.instance.ref();
    // final imageRef = storage.child("user_1.jpg");
    // final imageBytes = await image.readAsBytes();
    // await imageRef.putData(imageBytes);

    // 3.
    final imageBytes = await image.readAsBytes();
    setState(() => pickedImage = imageBytes);
  }

// Future<void> getProfilePicture() async {
//   final storageRef = FirebaseStorage.instance.ref();
//   final imageRef = storage.child("user_1.jpg");
//
//   try {
//     final imagesBytes = await imageRef.getData();
//     if (imagesBytes == null) return;
//     setState(() => pickedImage = imageBytes);
//
//   } catch(e) {
//     debugPrint(
//       'Profile picture could not be found.',
//     );
//   }
// }
}

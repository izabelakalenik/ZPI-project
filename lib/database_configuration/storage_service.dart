import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';

class StorageService {
  StorageService() : ref = FirebaseStorage.instance.ref();
  final Reference ref;

  Future<void> uploadFile(String fileName, XFile file) async {
    try {
      final imageRef = ref.child(fileName);
      final imageBytes = await file.readAsBytes();
      await imageRef.putData(imageBytes);
    } catch (e) {
      debugPrint("Could not upload file.");
    }
  }

  Future<Uint8List?> downloadFile(String fileName) async {
    try {
      final imageRef = ref.child(fileName);
      return imageRef.getData();
    } catch (e) {
      debugPrint("Could not download file.");
      return null;
    }
  }
}
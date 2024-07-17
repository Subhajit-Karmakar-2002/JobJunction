import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jobjunction/constants/app_constants.dart';
import 'package:uuid/uuid.dart';

class ImageUploader extends ChangeNotifier {
  var uuid = Uuid();
  final ImagePicker _picker = ImagePicker();

  String? imageurl;

  String? imagePath;

  List<String> imageFil = [];
  void pickImage() async {
    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);

    if (_imageFile != null) {
      // _imageFile = await cropImage(_imageFile);
      imageFil.add(_imageFile.path);
      imageUpload(_imageFile);
      imagePath = _imageFile.path;
      notifyListeners();
    } else {
      return;
    }
  }

  // Future<XFile?> cropImage(XFile imageFile) async {
  //   CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
  //     sourcePath: imageFile.path,
  //     maxWidth: 800,
  //     maxHeight: 600,
  //     compressQuality: 70,
  //     // cropStyle: CropStyle.rectangle,
  //     // aspectRatioPresets: [CropAspectRatioPreset.ratio5x4],
  //     uiSettings: [
  //       AndroidUiSettings(
  //           toolbarTitle: 'Cropper',
  //           toolbarColor: Color(kLightBlue.value),
  //           toolbarWidgetColor: Colors.white,
  //           initAspectRatio: CropAspectRatioPreset.ratio5x4,
  //           lockAspectRatio: true),
  //       IOSUiSettings(
  //         title: 'Cropper',
  //       ),
  //     ],
  //   );

  //   if (croppedFile != null) {
  //     notifyListeners();
  //     return XFile(croppedFile.path);
  //   } else {
  //     return null;
  //   }
  // }

  Future<String?> imageUpload(XFile upload) async {
    try {
      File image = File(upload.path);
      print(image);
      final ref = FirebaseStorage.instance
          .ref()
          .child("jobjunction")
          .child("${uuid.v1()}.jpg");

      await ref.putFile(image);
      imageurl = await ref.getDownloadURL();
      print("Image URL: $imageurl");
      return imageurl;
    } catch (e) {
      print("Error uploading image: $e");
      return null;
    }
  }
}

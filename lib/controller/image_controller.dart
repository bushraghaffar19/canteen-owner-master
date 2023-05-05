import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as fStorage;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../shared/loading_widget.dart';

class ImageController{
  String url = '';
  Future<String> uploadImageToFirebase(String foldName , String fileName , File image,context) async {
    loadingDialogue(context: context);
    fStorage.Reference reference = fStorage.FirebaseStorage.instance
        .ref()
        .child(foldName)
        .child(fileName);
    fStorage.UploadTask uploadTask =
    reference.putFile(File(image.path));
    fStorage.TaskSnapshot taskSnapshot =
    await uploadTask.whenComplete(() {});
    String url = await taskSnapshot.ref.getDownloadURL();
    return url;
  }

 }
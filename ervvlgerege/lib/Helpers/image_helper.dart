import 'package:ervvlgerege/Controllers/image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import '../MyWidgets/fundamental/buttons.dart';
import '../MyWidgets/fundamental/text_heading.dart';
import '../global_constants.dart';

class ImageHelper {
  var imageCont = Get.find<ImageCont>();

  //zuragan file iig ursgah obs
  var imageFile = File('').obs;

  final _picker = ImagePicker();
  //zuragan file iig hvselt rvv ursgah obs
  String imageFilereq = '';

  Future<void> pickImageFromGallery() async {
    final pickedFile =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    if (pickedFile != null) {
      imageFilereq = pickedFile.path;
      imageCont.imageUpload();
      imageFile.value = File(imageFilereq);
    }
  }

  Future<void> pickImageFromCamera() async {
    final pickedFile = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50); //TODO image quality aa bvten yavuulah
    if (pickedFile != null) {
      imageFilereq = pickedFile.path;
      imageCont.imageUpload();
      imageFile.value = File(imageFilereq);
    }
  }

  Future<void> cameraAndGallery(BuildContext context) async {
    return await showDialog(
        context: context,
        builder: (context) => SimpleDialog(
              title: headerTxtForm6('Нүүр зураг солих'),
              children: [
                const SizedBox(
                  height: 20,
                ),
                popUpbtn('Зураг авах', FontAwesomeIcons.camera, () async {
                  await pickImageFromCamera();
                }),
                popUpbtn('Зураг сонгох', FontAwesomeIcons.image, () async {
                  await pickImageFromGallery();
                }),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    generalBtn(Mcolors.geregeBlue, 'хаах', () {
                      Navigator.pop(context);
                    })
                  ],
                )
              ],
            ));
  }
}

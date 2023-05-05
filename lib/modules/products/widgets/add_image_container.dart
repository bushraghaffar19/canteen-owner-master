import 'dart:io';

import 'package:flutter/material.dart';

import '../../../core/constants/app_fonts.dart';

class AddImageContainer extends StatelessWidget {
  final String title;
  final File? image;
  const AddImageContainer({super.key, this.image, required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
            width: double.infinity,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(26),
              color: Colors.grey.shade50,
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  spreadRadius: 3,
                  blurRadius: 20,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            child: Center(
              child: image == null ?Column(
                mainAxisSize: MainAxisSize.min,
                children:  [
                  const Icon(
                    Icons.camera_alt,
                    color: Colors.grey,
                    size: 40,
                  ),
                  Text(
                    title,
                    style: AppFonts.kFont12ptGrey,
                  ),
                ],
              ):ClipRRect(
                borderRadius: BorderRadius.circular(26),
                child: Image(
                  image: FileImage(image!),
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
            ),
          );
  }
}
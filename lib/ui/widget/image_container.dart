import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageContainer extends StatelessWidget {
  final XFile? _image;
  final Function()? _onTap;

  const ImageContainer({
    super.key,
    XFile? image,
    Function()? onTap,
  }): _image = image,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      child: _buildImageContainerDetail(),
    );
  }

  Widget _buildImageContainerDetail() {
    if(_image != null) {
      return Image.file(
        File(_image!.path),
        width: double.infinity,
      );
    }

    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey,
      child: const Center(
        child: Text('ここをタップして写真を選択',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageContainer extends StatelessWidget {
  final XFile? _image;
  final Function() _onImageContainer;

  const ImageContainer({
    super.key,
    required image,
    required onImageContainer,
  }): _image = image,
        _onImageContainer = onImageContainer;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onImageContainer(),
      child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.grey,
        child: _getContentToShow(_image),
      ),
    );
  }

  Widget _getContentToShow(XFile? image) {
    Widget widget;

    if(image == null) {
      widget = const Center(
          child: Text('ここをタップして写真を選択',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          )
      );
    } else {
      widget = Image.file(File(_image!.path));
    }
    return widget;
  }
}

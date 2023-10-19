import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_diary/model/page_model.dart';

class DiaryCard extends StatelessWidget {
  final PageModel _page;
  final Function(PageModel)? _onTap;

  const DiaryCard({
    super.key,
    required PageModel page,
    Function(PageModel page)? onTap,
  }): _page = page,
        _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 280,
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),

        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            if(_onTap != null) _onTap!(_page);
          },
          child: Column(
            children: [
              Image.file(
                File(_page.imagePath),
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  _page.getFormattedDate(),
                  style: const TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        )
      ),
    );
  }
}

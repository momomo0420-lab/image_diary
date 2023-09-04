import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_diary/model/diary_page.dart';
import 'package:image_picker/image_picker.dart';

class DiaryPageCard extends StatelessWidget {
  final DiaryPage _page;
  final Function(DiaryPage) _onTap;

  const DiaryPageCard({
    super.key,
    required DiaryPage page,
    required Function(DiaryPage) onTap,
  }): _page = page,
      _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 280,
        child: Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),

            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () => _onTap(_page),
              child: Column(
                children: [
                  Image.file(
                    File(_page.image.path),
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
      ),
    );
  }
}

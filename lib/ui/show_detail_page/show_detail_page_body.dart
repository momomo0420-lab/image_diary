import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_diary/model/page_item.dart';
import 'package:image_diary/model/page_model.dart';

/// 詳細画面のメイン
class ShowDetailPageBody extends StatelessWidget {
  // 日記のページデータ
  final PageModel _page;

  /// コンストラクタ
  const ShowDetailPageBody({
    super.key,
    required PageModel page,
  }): _page = page;

  /// メイン
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Image.memory(
              Uint8List.fromList(_page.image),
              width: double.infinity,
            ),
            const SizedBox(height: 16,),

            Text(_page.title, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 16,),

            Text(_page.getFormattedDate(), style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 16,),

            Text(_page.content, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 16,),
          ],
        )
      ),
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_diary/model/diary_page.dart';

/// 詳細画面のメイン
class ShowDetailPageBody extends StatelessWidget {
  // 日記のページデータ
  final DiaryPage? _page;

  /// コンストラクタ
  const ShowDetailPageBody({
    super.key,
    required DiaryPage? page,
  }): _page = page;

  /// メイン
  @override
  Widget build(BuildContext context) {
    return Center(
      child: _decideDisplayingWidget()
    );
  }

  /// 表示する内容を決める
  ///
  /// @return 表示するするウィジェット
  ///         ページデータがある場合 - 詳細ページを作成し返却
  ///         ページデータが無い場合 - [Now Loading...]の文字列
  Widget _decideDisplayingWidget() {
    Widget widget = const Center(child: Text('Now Loading...'));

    if(_page != null) {
      widget = _createDetailPage(_page!);
    }

    return widget;
  }

  /// 詳細ページを作成する
  ///
  /// @param page 日記のページデータ
  /// @return 詳細ページ
  Widget _createDetailPage(DiaryPage page) {
    return Column(
      children: [
        Container(
          height: 200,
          width: double.infinity,
          color: Colors.grey,
          child: Image.file(File(page.image.path)),
        ),
        const SizedBox(height: 16,),

        Text(page.title, style: const TextStyle(fontSize: 40)),
        const SizedBox(height: 16,),

        Text(page.getFormattedDate(), style: const TextStyle(fontSize: 30)),
        const SizedBox(height: 16,),

        Text(page.content, style: const TextStyle(fontSize: 30)),
        const SizedBox(height: 16,),
      ],
    );
  }
}

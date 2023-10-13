import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_view_mode_state.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_view_model.dart';

/// 詳細画面のメイン
class ShowDetailPageBody extends StatelessWidget {
  // 日記のページデータ
  final ShowDetailPageViewModel _viewModel;
  final ShowDetailPageViewModelState _state;

  /// コンストラクタ
  const ShowDetailPageBody({
    super.key,
    required ShowDetailPageViewModel viewModel,
    required ShowDetailPageViewModelState state,
  }): _viewModel = viewModel,
    _state = state;

  /// メイン
  @override
  Widget build(BuildContext context) {
    final page = _state.page;

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            Image.file(
              File(page.imagePath),
              width: double.infinity,
            ),
            const SizedBox(height: 16,),

            Text(page.title, style: const TextStyle(fontSize: 40)),
            const SizedBox(height: 16,),

            Text(page.getFormattedDate(), style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 16,),

            Text(page.content, style: const TextStyle(fontSize: 30)),
            const SizedBox(height: 16,),
          ],
        )
      ),
    );
  }
}

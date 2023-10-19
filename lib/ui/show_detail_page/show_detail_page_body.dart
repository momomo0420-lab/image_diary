import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_view_model.dart';

/// 詳細画面のメイン
class ShowDetailPageBody extends ConsumerWidget {
  final PageModel _page;

  /// コンストラクタ
  const ShowDetailPageBody({
    super.key,
    required PageModel page,
  }): _page = page;

  /// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(showDetailPageViewModelProvider(_page));
    final viewModel = ref.read(showDetailPageViewModelProvider(_page).notifier);

    return SingleChildScrollView(
      child: Column(
        children: [
          Image.file(
            File(_page.imagePath),
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
      ),
    );
  }
}

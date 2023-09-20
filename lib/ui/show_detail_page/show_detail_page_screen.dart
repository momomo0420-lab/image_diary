import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_body.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_view_model.dart';

/// 日記の詳細画面
class ShowDetailPageScreen extends ConsumerWidget {
  final PageModel _page;

  /// コンストラクタ
  const ShowDetailPageScreen({
    super.key,
    required PageModel page,
  }): _page = page;


/// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(showDetailPageViewModelProvider(_page));

    return Scaffold(
      appBar: AppBar(title: const Text('日記の詳細ページ')),
      body: ShowDetailPageBody(
        page: state.page,
      ),
    );
  }
}



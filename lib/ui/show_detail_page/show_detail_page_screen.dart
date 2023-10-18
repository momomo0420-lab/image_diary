import 'package:flutter/material.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_body.dart';

/// 日記の詳細画面
class ShowDetailPageScreen extends StatelessWidget {
  /// コンストラクタ
  const ShowDetailPageScreen({super.key});

  /// メイン
  @override
  Widget build(BuildContext context) {
    // 渡されたページを使用し、状態を作成
    final page = ModalRoute.of(context)!.settings.arguments as PageModel;

    return Scaffold(
      appBar: AppBar(title: const Text('日記の詳細ページ')),
      body: ShowDetailPageBody(page: page),
    );
  }
}

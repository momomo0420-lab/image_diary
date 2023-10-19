import 'package:flutter/material.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_body.dart';

/// 日記のリスト表示画面
class ShowPageListScreen extends StatelessWidget {
  // 詳細画面への遷移
  final Function(PageModel)? _navigateToShowDetailPage;
  // ページ追加画面への遷移
  final Function()? _navigateToAddPage;

  ///コンストラクタ
  const ShowPageListScreen({
    super.key,
    Function(PageModel page)? navigateToShowDetailPage,
    Function()? navigateToAddPage,
  }): _navigateToShowDetailPage = navigateToShowDetailPage,
      _navigateToAddPage = navigateToAddPage;

  /// メイン
  @override
  Widget build(BuildContext context) {
    debugPrint('ShowPageListScreen: build start');

    return Scaffold(
      appBar: AppBar(title: const Text('画像日記アプリ')),
      body: ShowPageListBody(
        onPageCard: _navigateToShowDetailPage,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddPage,
        child: const Icon(Icons.add),
      ),
    );
  }
}
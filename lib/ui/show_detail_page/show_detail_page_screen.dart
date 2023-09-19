import 'package:flutter/material.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_body.dart';

/// 日記の詳細画面
class ShowDetailPageScreen extends StatefulWidget {
  final PageModel _page;

  /// コンストラクタ
  const ShowDetailPageScreen({
    super.key,
    required PageModel page,
  }): _page = page;

  @override
  State<ShowDetailPageScreen> createState() => _ShowDetailPageScreenState();
}

class _ShowDetailPageScreenState extends State<ShowDetailPageScreen> {
  /// メイン
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('日記の詳細ページ')),
      body: ShowDetailPageBody(
        page: widget._page,
      ),
    );
  }
}

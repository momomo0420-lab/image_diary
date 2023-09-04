import 'package:flutter/material.dart';
import 'package:image_diary/model/diary_page.dart';
import 'package:image_diary/model/diary_page_repository.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_body.dart';

/// 日記の詳細画面
class ShowDetailPageScreen extends StatefulWidget {
  // 日記取得用のリポジトリ
  final DiaryPageRepository _repository;

  /// コンストラクタ
  const ShowDetailPageScreen({
    super.key,
    required repository,
  }): _repository = repository;

  @override
  State<ShowDetailPageScreen> createState() => _ShowDetailPageScreenState();
}

class _ShowDetailPageScreenState extends State<ShowDetailPageScreen> {
  /// 日記の詳細ページ
  late final Future<DiaryPage> _page;

  /// 状態の初期化
  @override
  void initState() {
    super.initState();

    _page = _getDiaryPage();
  }

  /// 詳細表示するページの取得
  ///
  /// @return ページ
  Future<DiaryPage> _getDiaryPage() async {
    return await widget._repository.findBy(0);
  }

  /// メイン
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('日記の詳細ページ')),
      body: FutureBuilder(
        future: _page,
        builder: (context, page) {
          return ShowDetailPageBody(
            title: 'タイトル',
            content: '本文',
            date: DateTime.now(),
            image: page.hasData ? page.requireData.image : null,
          );
        },
      ),
    );
  }

}

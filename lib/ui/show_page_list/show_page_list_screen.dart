import 'package:flutter/material.dart';
import 'package:image_diary/model/page_item.dart';
import 'package:image_diary/model/page_item_repository.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_body.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// 日記のリスト表示画面
class ShowPageListScreen extends StatefulWidget {
  // ページ取得用リポジトリ
  final PageItemRepository _repository;
  // 詳細画面への遷移
  final Function(PageModel) _navigateToShowDetailPage;
  // ページ追加画面への遷移
  final Function() _navigateToAddAddPage;

  ///コンストラクタ
  const ShowPageListScreen({
    super.key,
    required repository,
    required navigateToShowDetailPage,
    required navigateToAddPage,
  }): _repository = repository,
    _navigateToShowDetailPage = navigateToShowDetailPage,
    _navigateToAddAddPage = navigateToAddPage;

  @override
  State<ShowPageListScreen> createState() => _ShowPageListScreenState();
}

class _ShowPageListScreenState extends State<ShowPageListScreen> {
  // 日記のページリスト
  late final Future<List<PageModel>> _pageList;


  /// 状態の初期化
  @override
  void initState() {
    super.initState();
    _pageList = _fetchPageList();
  }

  // 日記のページリスト取得
  Future<List<PageModel>> _fetchPageList() async {
    final list = await widget._repository.findAll();

    return list;
  }

  /// メイン
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('画像日記アプリ')),
      backgroundColor: Colors.limeAccent,
      body: FutureBuilder(
        future: _pageList,
        builder: (context, pageList) {
          return ShowPageListBody(
              pageList: pageList.hasData ? pageList.requireData : null,
              onPageCard: (page) {
                widget._navigateToShowDetailPage(page);
              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => widget._navigateToAddAddPage(),
        child: const Icon(Icons.add),
      ),
    );
  }
}

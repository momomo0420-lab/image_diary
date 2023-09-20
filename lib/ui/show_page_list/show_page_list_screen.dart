import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_body.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_view_model.dart';

/// 日記のリスト表示画面
class ShowPageListScreen extends ConsumerWidget {
  // 詳細画面への遷移
  final Function(PageModel) _navigateToShowDetailPage;
  // ページ追加画面への遷移
  final Function() _navigateToAddAddPage;

  ///コンストラクタ
  const ShowPageListScreen({
    super.key,
    required navigateToShowDetailPage,
    required navigateToAddPage,
  }): _navigateToShowDetailPage = navigateToShowDetailPage,
    _navigateToAddAddPage = navigateToAddPage;


  /// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(showPageListViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('画像日記アプリ')),
      backgroundColor: Colors.limeAccent,
      body: state.when(
          data: (state) => onFetchPageListSuccessful(state.pageList),
          error: (error, stack) => onFetchPageListFailed(),
          loading: () => onFetchPageListLoading(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddAddPage(),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget onFetchPageListSuccessful(List<PageModel> pageList) {
    return ShowPageListBody(
        pageList: pageList,
        onPageCard: (page) => _navigateToShowDetailPage(page),
    );
  }

  Widget onFetchPageListFailed() {
    return const Text('データの取得に失敗しました');
  }

  Widget onFetchPageListLoading() {
    return const Text('Now Loading...');
  }

}



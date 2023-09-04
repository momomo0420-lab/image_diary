import 'package:flutter/material.dart';
import 'package:image_diary/model/diary_page_repository.dart';

/// 日記のリスト表示画面
class ShowPageListScreen extends StatefulWidget {
  // ページ取得用リポジトリ
  final DiaryPageRepository _repository;
  // 詳細画面への遷移処理
  final Function() _navigateToShowDetailPage;
  // ページ追加画面への追加処理
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
  /// メイン
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

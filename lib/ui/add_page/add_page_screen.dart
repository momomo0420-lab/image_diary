import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_diary/ui/add_page/add_page_body.dart';
import 'package:image_diary/ui/add_page/add_page_view_model.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_view_model.dart';

/// ページ追加用画面
class AddPageScreen extends ConsumerWidget {
  // 書き込み完了後の遷移先
  final Function() _navigateToNextScreen;

  /// コンストラクタ
  const AddPageScreen({
    super.key,
    required Function() navigateToNextScreen,
  }): _navigateToNextScreen = navigateToNextScreen;


  /// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addPageViewModelProvider);
    final viewModel = ref.read(addPageViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('日記を書く')),
      body: AddPageBody(
        viewModel: viewModel,
        state: state,
        navigateToNextScreen: () {
          final showPageListViewModel = ref.read(showPageListViewModelProvider.notifier);
          showPageListViewModel.loadPageList();
          _navigateToNextScreen();
        },
      ),
    );
  }
}

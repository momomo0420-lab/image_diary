import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_body.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_view_model.dart';

/// 日記の詳細画面
class ShowDetailPageScreen extends ConsumerWidget {
  /// コンストラクタ
  const ShowDetailPageScreen({super.key});

  /// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 渡されたページを使用し、状態を作成
    final page = ModalRoute.of(context)!.settings.arguments as PageModel;
    //todo: ここ同じところ参照してるのかね？
    final state = ref.watch(showDetailPageViewModelProvider(page));
    final viewModel = ref.read(showDetailPageViewModelProvider(page).notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('日記の詳細ページ')),
      body: ShowDetailPageBody(
        viewModel: viewModel,
        state: state,
      ),
    );
  }
}

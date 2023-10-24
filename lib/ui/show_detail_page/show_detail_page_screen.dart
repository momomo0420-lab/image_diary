import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_diary/data/page_model.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_body.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_view_model.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_view_model.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// 日記の詳細画面
class ShowDetailPageScreen extends ConsumerWidget {
  final Function()? _navigateToNextScreen;

  /// コンストラクタ
  const ShowDetailPageScreen({
    super.key,
    Function()? navigateToNextScreen,
  }): _navigateToNextScreen = navigateToNextScreen;

  /// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 渡されたページを使用し、状態を作成
    final page = ModalRoute.of(context)!.settings.arguments as PageModel;

    final viewModel = ref.read(showDetailPageViewModelProvider(page).notifier);
    final state = ref.watch(showDetailPageViewModelProvider(page));

    return Scaffold(
      appBar: AppBar(
        title: Text(state.page.getFormattedDate()),
        actions: [
          IconButton(
            onPressed: () => onDeleteIconPressed(context, viewModel, ref),
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ShowDetailPageBody(
            viewModel: viewModel,
            state: state,
            onUpdateButtonPressed: () => navigateToNextScreen(ref),
          ),
        ),
      ),
    );
  }

  void onDeleteIconPressed(
    BuildContext context,
    ShowDetailPageViewModel viewModel,
    WidgetRef ref,
  ) {
    showDeleteConfirmationDialog(
      context: context,
      onPositivePressed: (context) {
        viewModel.delete(
          onLoading: () => context.loaderOverlay.show(),
          onSuccess: () {
            context.loaderOverlay.hide();
            navigateToNextScreen(ref);
          },
        );
      },
      onNegativePressed: (context) => Navigator.of(context).pop(),
    );
  }

  void showDeleteConfirmationDialog({
    required BuildContext context,
    Function(BuildContext context)? onPositivePressed,
    Function(BuildContext context)? onNegativePressed,
  }) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('削除確認'),
        content: const Text('日記を削除しますか'),
        actions: [
          TextButton(
            onPressed: () {
              if(onNegativePressed != null) onNegativePressed(context);
            },
            child: const Text('いいえ'),
          ),
          TextButton(
            onPressed: () {
              if(onPositivePressed != null) onPositivePressed(context);
            },
            child: const Text('はい'),
          ),
        ],
      ),
    );
  }

  void navigateToNextScreen(WidgetRef ref) {
    final showPageListViewModel = ref.read(showPageListViewModelProvider.notifier);
    showPageListViewModel.clearPageList();
    if(_navigateToNextScreen != null) _navigateToNextScreen!();
  }
}

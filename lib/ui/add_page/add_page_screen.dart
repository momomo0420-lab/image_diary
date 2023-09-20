import 'package:cross_file/src/types/interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_diary/ui/add_page/add_page_body.dart';
import 'package:image_diary/ui/add_page/add_page_view_model.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// ページ追加用画面
class AddPageScreen extends ConsumerWidget {
  // 書き込み完了後の遷移先
  final Function() _destinationAfterWriting;

  /// コンストラクタ
  const AddPageScreen({
    super.key,
    required Function() destinationAfterWriting,
  }): _destinationAfterWriting = destinationAfterWriting;


  /// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(addPageViewModelProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('日記を書く')),
      body: LoaderOverlay(
        child: AddPageBody(
          titleController: state.titleController,
          contentController: state.contentController,
          image: state.image,
          onImageContainer: () => _onImageContainer(context, ref),
          onWritingButton: () => _onWritingButton(context, ref),
        ),
      ),
    );
  }

  /// 画像コンテナを押下された際の処理
  ///
  /// @param context  コンテキスト
  Future<void> _onImageContainer(
      BuildContext context,
      WidgetRef ref
  ) async {
    final viewModel = ref.read(addPageViewModelProvider.notifier);
    await viewModel.selectImage();
  }

  /// [書き込み]ボタンを押下された際の処理
  ///
  /// @param context  コンテキスト
  Future<void> _onWritingButton(
      BuildContext context,
      WidgetRef ref
  ) async {
    final viewModel = ref.read(addPageViewModelProvider.notifier);

    // 入力された内容に不備が無いか確認する
    // 不備がある場合はスナックバーを表示後、情報入力継続
    if(!viewModel.hasRequiredData()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('入力されていない項目があります。'))
      );
      return;
    }

    // ページを登録し、次の画面へ遷移
    await viewModel.registerPage();
    _destinationAfterWriting();
  }
}

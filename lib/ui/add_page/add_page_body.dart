import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_diary/ui/add_page/add_page_view_model.dart';
import 'package:image_diary/ui/widget/image_container.dart';
import 'package:image_diary/ui/widget/multiple_lines_text_field.dart';
import 'package:image_diary/ui/widget/one_line_text_field.dart';
import 'package:loader_overlay/loader_overlay.dart';


/// ページ追加用スクリーンのメイン
class AddPageBody extends ConsumerWidget {
  final Function() _onWritingButtonPressed;

  /// コンストラクタ
  const AddPageBody({
    super.key,
    required Function() onWritingButtonPressed,
  }): _onWritingButtonPressed = onWritingButtonPressed;

  /// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.read(addPageViewModelProvider.notifier);
    final state = ref.watch(addPageViewModelProvider);

    return Column(
      children: [
        ImageContainer(
          image: state.image,
          onTap: () => viewModel.pickImage(),
        ),
        const SizedBox(height: 10),

        // 題名の入力フォーム
        OneLineTextField(
          label: '題名',
          hint: 'ここに題名を入力してください。',
          onChanged: (title) => viewModel.setTitle(title),
          onClear: () => viewModel.setTitle(''),
        ),
        const SizedBox(height: 10),

        // 内容の入力フォーム
        MultipleLinesTextField(
          label: '内容',
          hint: 'ここに内容を入力してください。',
          onChanged: (content) => viewModel.setContent(content),
        ),
        const SizedBox(height: 10),

        Center(
          child: ElevatedButton(
            onPressed: !viewModel.isWritable() ? null :
              () => viewModel.addPage(
                onLoading: () => context.loaderOverlay.show(),
                onSuccess: () {
                  context.loaderOverlay.hide();
                  _onWritingButtonPressed();
                },
              ),
            child: const Text('書き込む'),
          ),
        )
      ],
    );
  }
}

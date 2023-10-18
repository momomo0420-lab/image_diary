import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_diary/ui/add_page/add_page_view_model.dart';
import 'package:image_diary/ui/add_page/add_page_view_model_state.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// ページ追加用スクリーンのメイン
class AddPageBody extends HookConsumerWidget {
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

    final titleController = useTextEditingController(text: '');
    final contentController = useTextEditingController(text: '');

    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            _buildImageContainer(
              state: state,
              viewModel: viewModel,
            ),
            const SizedBox(height: 10),

            _buildTitleTextField(
              controller: titleController,
              onChanged: (title) => viewModel.setTitle(title),
              onClear: () => viewModel.setTitle(''),
            ),
            const SizedBox(height: 10),

            _buildContentTextField(
              controller: contentController,
              onChanged: (content) => viewModel.setContent(content),
            ),
            const SizedBox(height: 10),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                OutlinedButton(
                    onPressed: () {
                      contentController.clear();
                      viewModel.setContent('');
                    },
                    child: const Text('本文を消す'),
                ),
                const SizedBox(width: 20,),

                ElevatedButton(
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
              ],
            )
          ],
        ),
      ),
    );
  }

  /// 画像用コンテナを読み込む
  ///
  /// @return 画像用コンテナ
  Widget _buildImageContainer({
    required AddPageViewModelState state,
    required AddPageViewModel viewModel,
  }) {
    return InkWell(
      onTap: () => viewModel.pickImage(),
      child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.grey,
        child: _buildImageContainerDetail(state),
      ),
    );
  }

  Widget _buildImageContainerDetail(
    AddPageViewModelState state
  ) {
    final image = state.image;
    if(image != null) {
      return Image.file(File(image.path));
    }

    return const Center(
        child: Text('ここをタップして写真を選択',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        )
    );
  }

  /// タイトル入力フォームを読み込む
  ///
  /// @return タイトル入力フォーム
  Widget _buildTitleTextField({
    required TextEditingController controller,
    Function(String title)? onChanged,
    Function()? onClear,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.start,
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: '題名',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  controller.clear();
                  if(onClear != null) onClear();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
            onChanged: (title) {
              if(onChanged != null) onChanged(title);
            },
          ),
        ),
      ],
    );
  }

  /// 本文入力フォームの読み込み
  ///
  /// @return 本文入力フォーム
  Widget _buildContentTextField({
    required TextEditingController controller,
    Function(String title)? onChanged,
  }) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: const TextStyle(
              fontSize: 25
            ),
            textAlign: TextAlign.start,
            controller: controller,
            maxLines: 7,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: 'ここに本文を入力',
              border: OutlineInputBorder(),
            ),
            onChanged: (content) {
              if(onChanged != null) onChanged(content);
            },
          ),
        ),
      ],
    );
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_diary/ui/add_page/add_page_view_model.dart';
import 'package:image_diary/ui/add_page/add_page_view_model_state.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// ページ追加用スクリーンのメイン
class AddPageBody extends StatelessWidget {
  final AddPageViewModelState _state;
  final AddPageViewModel _viewModel;
  final Function() _onWritingButtonPressed;

  /// コンストラクタ
  const AddPageBody({
    super.key,
    required AddPageViewModel viewModel,
    required AddPageViewModelState state,
    required Function() onWritingButtonPressed,
  }): _viewModel = viewModel,
      _state = state,
      _onWritingButtonPressed = onWritingButtonPressed;

  /// メイン
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildImageContainer(),
              const SizedBox(height: 10),

              _buildTitleTextField(),
              const SizedBox(height: 10,),

              _buildContentTextField(),
              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () => _state.contentController.clear(),
                      child: const Text('本文を消す'),
                  ),
                  const SizedBox(width: 20,),

                  ElevatedButton(
                    onPressed: () => _viewModel.addPage(
                      onLoading: () => context.loaderOverlay.show(),
                      onSuccess: () {
                        context.loaderOverlay.hide();
                        _onWritingButtonPressed();
                      },
                      onFailure: () => _showFailureSnackBar(context),
                    ),
                    child: const Text('書き込む'),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  /// 画像用コンテナを読み込む
  ///
  /// @return 画像用コンテナ
  Widget _buildImageContainer() {
    return InkWell(
      onTap: () => _viewModel.pickImage(),
      child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.grey,
        child: _viewModel.buildImageContainerContent(
          hasImage: (path) => Image.file(File(path)),
          noImage: () => _showRequestingImageSelection(),
        ),
      ),
    );
  }

  Widget _showRequestingImageSelection() {
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
  Widget _buildTitleTextField() {
    final titleController = _state.titleController;

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.start,
            controller: titleController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: '題名',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  titleController.clear();
                },
                icon: const Icon(Icons.clear),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// 本文入力フォームの読み込み
  ///
  /// @return 本文入力フォーム
  Widget _buildContentTextField() {
    final contentController = _state.contentController;

    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: const TextStyle(
                fontSize: 25
            ),
            textAlign: TextAlign.start,
            controller: contentController,
            maxLines: 7,
            keyboardType: TextInputType.multiline,
            decoration: const InputDecoration(
              hintText: 'ここに本文を入力',
              border: OutlineInputBorder(),
            ),
          ),
        ),
      ],
    );
  }

  void _showFailureSnackBar(
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('入力されていない項目があります。'))
    );
  }
}

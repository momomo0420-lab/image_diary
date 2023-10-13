import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_diary/ui/add_page/add_page_view_model.dart';
import 'package:image_diary/ui/add_page/add_page_view_model_state.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// ページ追加用スクリーンのメイン
class AddPageBody extends StatelessWidget {
  final AddPageViewModelState _state;
  final AddPageViewModel _viewModel;
  final Function() _navigateToNextScreen;

  /// コンストラクタ
  const AddPageBody({
    super.key,
    required AddPageViewModel viewModel,
    required AddPageViewModelState state,
    required Function() navigateToNextScreen,
  }): _viewModel = viewModel,
      _state = state,
      _navigateToNextScreen = navigateToNextScreen;

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
                    onPressed: () => _onWritingButton(context),
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
        child: _buildImageOrText(),
      ),
    );
  }

  /// コンテキストに表示する内容を読み込む
  ///
  /// @return 表示する画像がある場合 - 表示する画像データウィジット
  ///         表示する画像が無い場合 - 画像の選択を促す文字列
  Widget _buildImageOrText() {
    Widget widget;

    final image = _state.image;

    if(image == null) {
      widget = const Center(
        child: Text('ここをタップして写真を選択',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        )
      );
    } else {
      widget = Image.file(File(image.path));
    }
    return widget;
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

  /// [書き込み]ボタンを押下された際の処理
  ///
  /// @param context  コンテキスト
  Future<void> _onWritingButton(
    BuildContext context,
  ) async {
    // 入力された内容に不備が無いか確認する
    // 不備がある場合はスナックバーを表示後、情報入力継続
    if(!_viewModel.hasRequiredData()) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('入力されていない項目があります。'))
      );
      return;
    }

    // ページを登録し、遷移後のページリストを更新した後、次の画面へ遷移
    context.loaderOverlay.show();
    await _viewModel.addPage();
    // ignore: use_build_context_synchronously
    context.loaderOverlay.hide();

    _navigateToNextScreen();
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// ページ追加用スクリーンのメイン
class AddPageBody extends StatelessWidget {
  // タイトル入力用のコントローラー
  final TextEditingController _titleController;
  // 本文入力用のコントローラー
  final TextEditingController _contentController;
  // 画面表示する画像（nullの場合は[ここをタップして写真を選択]を表示）
  final XFile? _image;
  // 画像部分が押された場合の処理
  final Function() _onImageContainer;
  // [書き込み]ボタンが押された場合の処理
  final Function(String title, String content, XFile? image) _onWritingButton;

  /// コンストラクタ
  const AddPageBody({
    super.key,
    required titleController,
    required contentController,
    required image,
    required onImageContainer,
    required onWritingButton,
  }): _titleController = titleController,
        _contentController = contentController,
        _image = image,
        _onImageContainer = onImageContainer,
        _onWritingButton = onWritingButton;

  /// メイン
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _loadImageContainer(),
              const SizedBox(height: 10),

              _loadTitleTextField(),
              const SizedBox(height: 10,),

              _loadContentTextField(),
              const SizedBox(height: 10,),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton(
                      onPressed: () => _contentController.clear(),
                      child: const Text('本文を消す'),
                  ),
                  const SizedBox(width: 20,),

                  ElevatedButton(
                    onPressed: () {
                      _onWritingButton(
                        _titleController.text,
                        _contentController.text,
                        _image
                      );
                    },
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
  Widget _loadImageContainer() {
    return InkWell(
      onTap: () => _onImageContainer(),
      child: Container(
        height: 200,
        width: double.infinity,
        color: Colors.grey,
        child: _loadImageOrText(),
      ),
    );
  }

  /// コンテキストに表示する内容を読み込む
  ///
  /// @return 表示する画像がある場合 - 表示する画像データウィジット
  ///         表示する画像が無い場合 - 画像の選択を促す文字列
  Widget _loadImageOrText() {
    Widget widget;

    if(_image == null) {
      widget = const Center(
          child: Text('ここをタップして写真を選択',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          )
      );
    } else {
      widget = Image.file(File(_image!.path));
    }
    return widget;
  }

  /// タイトル入力フォームを読み込む
  ///
  /// @return タイトル入力フォーム
  Widget _loadTitleTextField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: const TextStyle(fontSize: 25),
            textAlign: TextAlign.start,
            controller: _titleController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: '題名',
              border: const OutlineInputBorder(),
              suffixIcon: IconButton(
                onPressed: () {
                  _titleController.clear();
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
  Widget _loadContentTextField() {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            style: const TextStyle(
                fontSize: 25
            ),
            textAlign: TextAlign.start,
            controller: _contentController,
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
}

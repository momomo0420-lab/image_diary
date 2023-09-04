import 'package:flutter/material.dart';
import 'package:image_diary/ui/widgets/content_text_field.dart';
import 'package:image_diary/ui/widgets/image_container.dart';
import 'package:image_diary/ui/widgets/title_text_field.dart';
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
              ImageContainer(
                image: _image,
                onImageContainer: _onImageContainer,
              ),
              const SizedBox(height: 10),

              TitleTextField(
                controller: _titleController,
              ),
              const SizedBox(height: 10,),

              ContentTextField(
                controller: _contentController,
              ),
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
}

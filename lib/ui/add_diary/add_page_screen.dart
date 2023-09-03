import 'package:flutter/material.dart';
import 'package:image_diary/model/diary_page_repository.dart';
import 'package:image_diary/model/diary_page.dart';
import 'package:image_diary/ui/add_diary/add_page_body.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// ページ追加用画面
class AddPageScreen extends StatefulWidget {
  // 日記のページ操作用リポジトリ
  final DiaryPageRepository _repository;
  // 次の画面への遷移先
  final Function() _navigateToNextScreen;

  // コンストラクタ
  const AddPageScreen({
    super.key,
    required repository,
    required navigateToNextScreen,
  }): _repository = repository,
    _navigateToNextScreen = navigateToNextScreen;

  @override
  State<AddPageScreen> createState() => _AddPageScreenState();
}

class _AddPageScreenState extends State<AddPageScreen> {
  // タイトル用のコントローラー
  final _titleController = TextEditingController();
  // 本文用のコントローラー
  final _contentController = TextEditingController();
  // イメージピッカー
  final _imagePicker = ImagePicker();
  // 画面に表示する画像
  XFile? _image;

  // メイン
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('日記を書く')),
      body: LoaderOverlay(
        child: AddPageBody(
          titleController: _titleController,
          contentController: _contentController,
          image: _image,
          onImageContainer: () => _onImageContainer(context),
          onWritingButton: (title, content, image) => _onWritingButton(context, title, content, image),
        ),
      ),
    );
  }

  /// 画像コンテナを押下された際の処理
  ///
  /// @param context  コンテキスト
  Future<void> _onImageContainer(BuildContext context) async {
    // 画面を暗転し、ユーザーに画像を選択してもらう
    context.loaderOverlay.show();
    final pickedFile = await _imagePicker.pickImage(source: ImageSource.gallery);

    // ユーザーが画面選択後、画面の暗転を解除する
    if(!mounted) return;
    context.loaderOverlay.hide();

    // 選択された画像を状態保存
    setState(() {
      if(pickedFile != null) {
        _image = XFile(pickedFile.path);
      }
    });
  }

  /// [書き込み]ボタンを押下された際の処理
  ///
  /// @param context  コンテキスト
  /// @param title    タイトル
  /// @param content  本文
  /// @param image    画像
  Future<void> _onWritingButton(
      BuildContext context,
      String title,
      String content,
      XFile? image
  ) async {

    // 入力された内容に不備が無いか確認する
    // 不備がある場合はスナックバーを表示後、情報入力継続
    if(!_hasRequiredData(title, content, image)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('入力されていない項目があります。'))
      );
      return;
    }

    // 画面を暗転後、ページの登録を行う
    context.loaderOverlay.show();
    final page = DiaryPage(title: title, content: content, date: DateTime.now(), image: image!);

    await widget._repository.insert(page);

    // 登録完了後、暗転を解除し次の画面へ遷移
    if(!mounted) return;
    context.loaderOverlay.hide();

    widget._navigateToNextScreen();
  }

  /// ページ登録のために必要なデータが揃っているか確認する処理
  ///
  /// @param title    タイトル
  /// @param content  本文
  /// @param image    画像
  ///
  /// @return ture  過不足なく入力されている
  ///         false 入力項目に不備がある
  bool _hasRequiredData(
      String title,
      String content,
      XFile? image
  ) {
    bool result = true;

    if((title == "") ||
        (content == "") ||
        (image == null)) {
      result = false;
    }

    return result;
  }
}

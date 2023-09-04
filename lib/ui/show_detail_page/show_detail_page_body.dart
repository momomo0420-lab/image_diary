import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

/// 詳細画面のメイン
class ShowDetailPageBody extends StatelessWidget {
  // タイトル
  final String    _title;
  // 本文
  final String    _content;
  // 時刻
  final DateTime  _date;
  // 表示する画像
  final XFile?    _image;

  /// コンストラクタ
  const ShowDetailPageBody({
    super.key,
    required String   title,
    required String   content,
    required DateTime date,
    required XFile?   image,
  }): _title = title,
    _content = content,
    _date = date,
    _image = image;

  /// メイン
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 200,
            width: double.infinity,
            color: Colors.grey,
            child: _showContentInContainer(_image),
          ),
          const SizedBox(height: 16,),

          Text(_title, style: const TextStyle(fontSize: 40)),
          const SizedBox(height: 16,),

          Text(_getFormattedDate(_date), style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 16,),
          
          Text(_content, style: const TextStyle(fontSize: 30)),
          const SizedBox(height: 16,),
        ],
      )
    );
  }

  /// フォーマットされた日付を取得する
  ///
  /// @param  date  日付データ
  /// @return フォーマットされた日付（例： 2023年09月04日）
  String _getFormattedDate(DateTime date) {
    return DateFormat('yyyy年MM月dd日').format(date);
  }

  /// コンテナに表示する内容を決める
  ///
  /// @param  image 画像データ
  /// @return 表示するするウィジェット
  ///         画像がある場合 - その画像
  ///         画像が無い場合 - [No Image.]の文字列
  Widget _showContentInContainer(XFile? image) {
    Widget widget = const Center(child: Text('画像データの読み込み中...'));

    if(image != null) {
      widget = Image.file(File(image.path));
    }

    return widget;
  }
}

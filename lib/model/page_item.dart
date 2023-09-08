import 'dart:io';
import 'dart:typed_data';

import 'package:image_diary/model/db/page_columns.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class PageItem {
  // タイトル
  final String title;
  // 本文
  final String content;
  // 日付
  final DateTime date;
  // 画像
  final XFile image;
  // 画像の名前
  final String imageName;

  const PageItem({
    required this.title,
    required this.content,
    required this.date,
    required this.image,
    required this.imageName,
  });

  /// マップデータからページを作成する
  ///
  /// @param map  マップデータ
  /// @return ページ
  static Future<PageItem> createFromMap(Map<String, dynamic> map) async {
    final title = map[PageColumns.title.column] as String;
    final content = map[PageColumns.content.column] as String;
    final date = map[PageColumns.date.column] as int;
    final image = map[PageColumns.image.column] as Uint8List;
    final imageName = map[PageColumns.imageName.column] as String;

    return PageItem(
      title: title,
      content: content,
      date: DateTime.fromMillisecondsSinceEpoch(date),
      image: await _convertUint8ListToXFile(image, imageName),
      imageName: imageName,
    );
  }

  /// Uint8List型のデータを画像に復元する
  ///
  /// @param  Uint8List型の画像データ
  /// @return 画像
  static Future<XFile> _convertUint8ListToXFile(
    Uint8List bytes,
    String imageName
  ) async {
    final path = (await getTemporaryDirectory()).path;
    final file = File('$path/$imageName');
    await file.writeAsBytes(bytes);

    return XFile(file.path);
  }

  /// ページからマップデータへ変換する
  ///
  /// 注意：データベースに保管するために画像をUint8List型に変換する
  /// @return マップデータ
  Future<Map<String, dynamic>> toMap() async {
    return {
      PageColumns.title.column: title,
      PageColumns.content.column: content,
      PageColumns.date.column: date.millisecondsSinceEpoch,
      PageColumns.image.column: await _convertXFileToUint8List(image),
      PageColumns.imageName.column: imageName,
    };
  }

  /// 画像をUint8List型へ変換する
  ///
  /// @param 画像
  /// @return Uint8List型へ変換された画像
  Future<Uint8List> _convertXFileToUint8List(XFile image) async {
    File file = File(image.path);
    List<int> bytes = await file.readAsBytes();

    return Uint8List.fromList(bytes);
  }

  /// 時刻（DateTime）を文字列に変換する
  String getFormattedDate() {
    return DateFormat('yyyy年MM月dd日').format(date);
  }
}
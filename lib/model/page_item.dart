import 'dart:io';
import 'dart:typed_data';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

enum PageItemColumns {
  id,
  title,
  content,
  date,
  image,
}

class PageItem {
  // タイトル
  final String title;
  // 本文
  final String content;
  // 日付
  final DateTime date;
  // 画像
  final XFile image;

  const PageItem({
    required this.title,
    required this.content,
    required this.date,
    required this.image,
  });

  /// マップデータからページを作成する
  ///
  /// @param map  マップデータ
  /// @return ページ
  static Future<PageItem> createFromMap(Map<String, dynamic> map) async {
    final title = map[PageItemColumns.title.name] as String;
    final content = map[PageItemColumns.content.name] as String;
    final date = map[PageItemColumns.date.name] as int;
    final image = map[PageItemColumns.image.name] as Uint8List;
    // final imageName = map[PageItemColumns.imageName.name] as String;

    return PageItem(
      title: title,
      content: content,
      date: DateTime.fromMillisecondsSinceEpoch(date),
      image: await _convertUint8ListToXFile(image, title),
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
      PageItemColumns.title.name: title,
      PageItemColumns.content.name: content,
      PageItemColumns.date.name: date.millisecondsSinceEpoch,
      PageItemColumns.image.name: await convertXFileToUint8List(image)
    };
  }

  /// 画像をUint8List型へ変換する
  ///
  /// @param 画像
  /// @return Uint8List型へ変換された画像
  Future<Uint8List> convertXFileToUint8List(XFile image) async {
    File file = File(image.path);
    List<int> bytes = await file.readAsBytes();

    return Uint8List.fromList(bytes);
  }

  /// 時刻（DateTime）を文字列に変換する
  String getFormattedDate() {
    return DateFormat('yyyy年MM月dd日').format(date);
  }
}
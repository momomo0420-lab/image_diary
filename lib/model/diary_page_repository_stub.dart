import 'dart:io';

import 'package:flutter/services.dart';
import 'package:image_diary/model/diary_page.dart';
import 'package:image_diary/model/diary_page_repository.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

/// 日記ページ操作用リポジトリ
class DiaryPageRepositoryStub implements DiaryPageRepository {
  @override
  Future<List<DiaryPage>> findAll() async {
    await Future.delayed(const Duration(seconds: 5));
    return await _generateTestDiaryPageList();
  }

  @override
  Future<DiaryPage> findBy(int id) async {
    await Future.delayed(const Duration(seconds: 5));
    return await _generateTestDiaryPage();
  }

  @override
  Future<void> insert(DiaryPage page) async {
    await Future.delayed(const Duration(seconds: 5));
  }

  /// 日記ページ用のテストデータを作成する（複数件）
  ///
  /// @return ページ用テストデータ（複数件）
  Future<List<DiaryPage>> _generateTestDiaryPageList() async {
    List<DiaryPage> pages = [];

    final path = (await getApplicationDocumentsDirectory()).path;

    for(int i = 1; i <= 5; i++) {
      String fileName = '$i.png';
      var file = File('$path/$fileName');

      var byteData = await rootBundle.load('images/$fileName');
      await file.writeAsBytes(
        byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)
      );

      pages.add(
        DiaryPage(
            title: 'title: $i',
            content: 'content: $i',
            date: DateTime.now().add(Duration(days: i)),
            image: XFile(file.path),
        )
      );
    }

    return pages;
  }

  /// 日記ページ用のテストデータを作成する
  ///
  /// @return ページ用テストデータ
  Future<DiaryPage> _generateTestDiaryPage() async {
    final path = (await getApplicationDocumentsDirectory()).path;
    String fileName = '1.png';
    var file = File('$path/$fileName');

    var byteData = await rootBundle.load('images/$fileName');
    await file.writeAsBytes(
      byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)
    );

    return DiaryPage(
        title: 'title',
        content: 'content',
        date: DateTime.now(),
        image: XFile(file.path),
    );
  }
}
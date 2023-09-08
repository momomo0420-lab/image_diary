// import 'dart:io';
//
// import 'package:flutter/services.dart';
// import 'package:image_diary/model/page_item.dart';
// import 'package:image_diary/model/page_item_repository.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
//
// /// 日記ページ操作用リポジトリ
// class PageItemRepositoryStub implements PageItemRepository {
//   @override
//   Future<List<PageItem>> findAll() async {
//     await Future.delayed(const Duration(seconds: 5));
//     return await _generateTestDiaryPageList();
//   }
//
//   @override
//   Future<PageItem> findBy(int id) async {
//     await Future.delayed(const Duration(seconds: 5));
//     return await _generateTestDiaryPage();
//   }
//
//   @override
//   Future<void> insert(PageItem page) async {
//     await Future.delayed(const Duration(seconds: 5));
//   }
//
//   /// 日記ページ用のテストデータを作成する（複数件）
//   ///
//   /// @return ページ用テストデータ（複数件）
//   Future<List<PageItem>> _generateTestDiaryPageList() async {
//     List<PageItem> pages = [];
//
//     final path = (await getApplicationDocumentsDirectory()).path;
//
//     for(int i = 1; i <= 5; i++) {
//       String fileName = '$i.png';
//       var file = File('$path/$fileName');
//
//       var byteData = await rootBundle.load('images/$fileName');
//       await file.writeAsBytes(
//         byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)
//       );
//
//       pages.add(
//         PageItem(
//           title: 'title: $i',
//           content: 'content: $i',
//           date: DateTime.now().add(Duration(days: i)),
//           image: XFile(file.path),
//           imageName: fileName,
//         )
//       );
//     }
//
//     return pages;
//   }
//
//   /// 日記ページ用のテストデータを作成する
//   ///
//   /// @return ページ用テストデータ
//   Future<PageItem> _generateTestDiaryPage() async {
//     final path = (await getApplicationDocumentsDirectory()).path;
//     String fileName = '1.png';
//     var file = File('$path/$fileName');
//
//     var byteData = await rootBundle.load('images/$fileName');
//     await file.writeAsBytes(
//       byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)
//     );
//
//     return PageItem(
//       title: 'title',
//       content: 'content',
//       date: DateTime.now(),
//       image: XFile(file.path),
//       imageName: fileName,
//     );
//   }
// }
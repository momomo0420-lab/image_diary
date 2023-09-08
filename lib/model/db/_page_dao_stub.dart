// import 'dart:io';
//
// import 'package:flutter/services.dart';
// import 'package:image_diary/model/db/page_columns.dart';
// import 'package:image_diary/model/db/page_dao.dart';
// import 'package:path_provider/path_provider.dart';
//
// final List<String> imageNamesForTest = [
//   '1.png',
//   '2.png',
//   '3.png',
//   '4.png',
//   '5.png',
// ];
//
//
// class PageDaoStub implements PageDao {
//   @override
//   Future<void> deleteBy(int id) {
//     // TODO: implement deleteBy
//     throw UnimplementedError();
//   }
//
//   // TODO: implement findAll
//   @override
//   Future<List<Map<String, dynamic>>> findAll() async {
//     await Future.delayed(const Duration(seconds: 5));
//
//     List<Map<String, dynamic>> pageMaps = [];
//
//     final path = (await getApplicationDocumentsDirectory()).path;
//
//     int count = 0;
//     for(var imageName in imageNamesForTest) {
//       File file = File('$path/$imageName');
//
//       var byteData = await rootBundle.load('images/$imageName');
//       file.writeAsBytes(
//         byteData.buffer.asUint8List(byteData.offsetInBytes, byteData.lengthInBytes)
//       );
//
//       pageMaps.add(
//         {
//           PageColumns.title.column: 'title(dao) $count',
//           PageColumns.content.column: 'content(dao) $count',
//           PageColumns.date.column: DateTime.now().add(Duration(days: count)).millisecondsSinceEpoch,
//           PageColumns.image.column: await file.readAsBytes(),
//           PageColumns.imageName.column: imageName,
//         }
//       );
//
//       count++;
//     }
//
//     return pageMaps;
//   }
//
//   @override
//   Future<void> insert(Map<String, dynamic> page) async {
//     await Future.delayed(const Duration(seconds: 5));
//   }
//
//   @override
//   Future<void> update(Map<String, dynamic> page) async {
//     // TODO: implement update
//     throw UnimplementedError();
//   }
// }
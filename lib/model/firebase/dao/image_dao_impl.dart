import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_diary/model/firebase/dao/image_dao.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class ImageDaoImpl extends ImageDao {
  static const path = "images/";
  static const baseName = "image_";

  /// [url]を基にCloud Storageからローカルへ画像を保存する。
  /// 保存後は保存したローカルパスを返却する。
  @override
  Future<String> loadFrom(String url) async {
    final ref = FirebaseStorage.instance.refFromURL(url);

    // 保存先のファイルパスを作成
    final fileName = ref.name;
    final directory = await getApplicationDocumentsDirectory();
    final filePath = "${directory.path}/$fileName";
    final file = File(filePath);

    // データをCloud Storageから取得する
    try {
      final data = await ref.getData();
      final bytes = data?.toList() ?? [];
      await file.writeAsBytes(bytes);
    } on FirebaseException catch(e) {
      debugPrint("ErrorCode: ${e.message}");
    }

    return file.path;
  }

  /// [file]をCloud Storageへ保存する
  @override
  Future<String> save(File file) async {
    final fileName = _createFileName(file);

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child("$path$fileName");
    try {
      await imageRef.putFile(file);
    } on FirebaseException catch (e) {
      debugPrint('ErrorMessage: ${e.message}');
    }

    return await imageRef.getDownloadURL();
  }

  /// 現在時刻と[file]を基に、保存用のファイル名を作成する。
  ///
  /// 現在時刻が23432552で拡張子.jpgの場合     => image_23432552.jpg
  String _createFileName(File file) {
    final date = DateTime.now().millisecondsSinceEpoch.toString();
    final fileExtension = extension(file.path);

    return baseName + date + fileExtension;
  }

  @override
  Future<String> update(String url) async {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<void> delete(String fileName) async {
    final storageRef = FirebaseStorage.instance.ref();
    final imageRef = storageRef.child(path + fileName);
    await imageRef.delete();
  }
}
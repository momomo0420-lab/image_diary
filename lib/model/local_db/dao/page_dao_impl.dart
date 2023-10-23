import 'package:flutter/cupertino.dart';
import 'package:image_diary/model/db/database_helper.dart';
import 'package:image_diary/model/db/page_dao.dart';
import 'package:sqflite/sqflite.dart';

class PageDaoImpl implements PageDao {
  final dbHelper = DatabaseHelper();

  @override
  Future<void> deleteBy(int date) async {
    // TODO: implement deleteBy
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> findAll() async {
    final db = await dbHelper.db;

    return await db.query(DatabaseHelper.tableName);
  }

  @override
  Future<void> insert(Map<String, dynamic> page) async {
    final db = await dbHelper.db;
    final id = await db.insert(
      DatabaseHelper.tableName,
      page,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint('id: $id');
  }

  @override
  Future<void> update(Map<String, dynamic> page) async {
    // TODO: implement update
    throw UnimplementedError();
  }
}
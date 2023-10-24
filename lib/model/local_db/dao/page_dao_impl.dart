import 'package:flutter/cupertino.dart';
import 'package:image_diary/model/local_db/dao/database_helper.dart';
import 'package:image_diary/model/local_db/dao/page_columns.dart';
import 'package:image_diary/model/local_db/dao/page_dao.dart';
import 'package:sqflite/sqflite.dart';

class PageDaoImpl implements PageDao {
  final _dbHelper = DatabaseHelper();

  @override
  Future<List<Map<String, dynamic>>> findAll() async {
    final db = await _dbHelper.db;

    return await db.query(
      DatabaseHelper.tableName,
      orderBy: '${PageColumns.date.column} DESC',
    );
  }

  @override
  Future<void> insert(Map<String, dynamic> page) async {
    final db = await _dbHelper.db;
    final id = await db.insert(
      DatabaseHelper.tableName,
      page,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    debugPrint('id: $id');
  }

  @override
  Future<void> update(int id, Map<String, dynamic> page) async {
    debugPrint('ImageDiaryApp[PageDaoImpl]: update - start');
    final db = await _dbHelper.db;
    await db.update(
      DatabaseHelper.tableName,
      page,
      where: '${PageColumns.id.column} = ?',
      whereArgs: [id],
    );
    debugPrint('ImageDiaryApp[PageDaoImpl]: update - end');
  }

  @override
  Future<void> deleteBy(int id) async {
    final db = await _dbHelper.db;

    await db.delete(
      DatabaseHelper.tableName,
      where: '${PageColumns.id.column} = ?',
      whereArgs: [id],
    );
  }
}
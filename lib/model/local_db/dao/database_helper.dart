import 'package:image_diary/model/local_db/dao/page_columns.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  // シングルトン管理
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;

  static const databaseName = 'image_diary.db';
  static const databaseVer = 1;
  static const tableName = 'page_table';

  // データベース
  static Database? _db;
  Future<Database> get db async {
    // 初期化が完了しているなら保持しているデータベースを返却
    if(_db != null) {
      return _db!;
    }

    // 初期化を行い、データベースを返却
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, databaseName);
    _db = await openDatabase(
      path,
      version: databaseVer,
      onCreate: _onCreate,
    );

    return _db!;
  }

  /// テーブル作成
  ///
  /// @param データベース
  /// @param バージョン
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        ${PageColumns.id.column} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${PageColumns.title.column} TEXT,
        ${PageColumns.content.column} TEXT,
        ${PageColumns.date.column} INTEGER,
        ${PageColumns.imagePath.column} TEXT
      )
    ''');
  }
}
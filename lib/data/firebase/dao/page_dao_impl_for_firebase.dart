import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_diary/data/local_db/dao/page_columns.dart';
import 'package:image_diary/data/local_db/dao/page_dao.dart';

class PageDaoImplForFirebase extends PageDao {
  static const collectionName = 'page_list';

  /// ページリストの取得
  ///
  /// @return ページリスト
  @override
  Future<List<Map<String, dynamic>>> findAll() async {
    List<Map<String, dynamic>> pageList = [];

    // ページリストを取得
    final db = FirebaseFirestore.instance;
    final ref = await db
        .collection(collectionName)
        .orderBy('date', descending: true)
        .get();

    // QueryDocumentSnapshot形式で取れているためMap形式へ変換
    for(var page in ref.docs) {
      pageList.add(page.data());
    }

    return pageList;
  }

  // Future<List<Map<String, dynamic>>> findBy(int date) async {
  //   List<Map<String, dynamic>> pageList = [];
  //
  //   final db = FirebaseFirestore.instance;
  //
  // }
  //
  @override
  Future<void> insert(Map<String, dynamic> page) async {
    final db = FirebaseFirestore.instance;
    await db.collection(collectionName).add(page);
  }

  @override
  Future<void> deleteBy(int date) async {
    final db = FirebaseFirestore.instance;
    final ref = await db.collection(collectionName)
        .where(PageColumns.date.column, isEqualTo: date).get();

    for(var page in ref.docs) {
      await page.reference.delete();
    }
  }

  @override
  Future<void> update(int id, Map<String, dynamic> page) async {
    // TODO: implement update
    throw UnimplementedError();
  }

}
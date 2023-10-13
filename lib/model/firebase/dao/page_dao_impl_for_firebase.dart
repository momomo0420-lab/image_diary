import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_diary/model/db/page_dao.dart';

class PageDaoImplForFirebase extends PageDao {
  static const collectionName = 'page_list';

  @override
  Future<void> deleteBy(int id) async {
    // TODO: implement deleteBy
    throw UnimplementedError();
  }

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

  @override
  Future<void> insert(Map<String, dynamic> page) async {
    final db = FirebaseFirestore.instance;
    final ref = await db.collection(collectionName).add(page);
  }

  @override
  Future<void> update(Map<String, dynamic> page) async {
    // TODO: implement update
    throw UnimplementedError();
  }

}
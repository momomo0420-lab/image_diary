import 'package:image_diary/model/db/page_dao.dart';
import 'package:image_diary/model/page_item.dart';

class PageDaoStub implements PageDao {
  @override
  Future<void> deleteBy(int id) {
    // TODO: implement deleteBy
    throw UnimplementedError();
  }

  @override
  Future<List<Map<String, dynamic>>> findAll() {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<void> insert(Map<String, dynamic> page) {
    // TODO: implement insert
    throw UnimplementedError();
  }

  @override
  Future<void> update(Map<String, dynamic> page) {
    // TODO: implement update
    throw UnimplementedError();
  }
}
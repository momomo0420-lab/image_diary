import 'package:flutter/cupertino.dart';
import 'package:image_diary/model/local_db/dao/page_dao.dart';
import 'package:image_diary/model/local_db/repository/page_repository.dart';
import 'package:image_diary/model/page_model.dart';

/// ページ操作用のリポジトリ
class PageRepositoryImpl implements PageRepository {
  final PageDao _dao;

  /// コンストラクタ
  const PageRepositoryImpl({
    required PageDao dao
  }): _dao = dao;

  @override
  Future<List<PageModel>> findAll() async {
    debugPrint('ImageDiaryApp[PageRepositoryImpl]: findAll - start');
    final maps = await _dao.findAll();

    // MapでDAOから取得される為、PageItem（List）に変換する
    final List<PageModel> pageList = [];

    for (var map in maps) {
      final page = PageModel.fromJson(map);
      pageList.add(page);
    }

    debugPrint('ImageDiaryApp[PageRepositoryImpl]: findAll - end');
    return pageList;
  }

  @override
  Future<PageModel> findBy(int id) async {
    // TODO: implement findBy
    throw UnimplementedError();
  }

  @override
  Future<void> insert(PageModel page) async {
    final map = page.toJson();
    await _dao.insert(map);
  }

  @override
  Future<void> delete(PageModel page) async {
    _dao.deleteBy(page.id!);
  }

  @override
  Future<void> update(PageModel page) async {
    debugPrint('ImageDiaryApp[PageRepositoryImpl]: update - start');
    await _dao.update(page.id!, page.toJson());
    debugPrint('ImageDiaryApp[PageRepositoryImpl]: update - end');
  }
}
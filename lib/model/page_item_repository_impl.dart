import 'package:image_diary/model/db/page_dao.dart';
import 'package:image_diary/model/page_item.dart';
import 'package:image_diary/model/page_item_repository.dart';

/// ページ操作用のリポジトリ
class PageItemRepositoryImpl implements PageItemRepository {
  final PageDao _dao;

  /// コンストラクタ
  const PageItemRepositoryImpl({
    required PageDao dao
  }): _dao = dao;

  @override
  Future<List<PageItem>> findAll() async {
    final maps = await _dao.findAll();

    // MapでDAOから取得される為、PageItem（List）に変換する
    final List<PageItem> pageList = [];

    for (var map in maps) {
      final page = await PageItem.createFromMap(map);
      pageList.add(page);
    }

    return pageList;
  }

  @override
  Future<PageItem> findBy(int id) async {
    // TODO: implement findBy
    throw UnimplementedError();
  }

  @override
  Future<void> insert(PageItem page) async {
    final map = await page.toMap();
    await _dao.insert(map);
  }
}
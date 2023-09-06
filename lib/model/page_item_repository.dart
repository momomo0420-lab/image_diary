import 'package:image_diary/model/page_item.dart';

abstract class PageItemRepository {
  Future<List<PageItem>> findAll();
  Future<PageItem> findBy(int id);
  Future<void> insert(PageItem page);
}
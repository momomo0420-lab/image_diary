import 'package:image_diary/data/page_model.dart';

abstract class PageRepository {
  Future<List<PageModel>> findAll();
  Future<PageModel> findBy(int id);
  Future<void> insert(PageModel page);
  Future<void> update(PageModel page);
  Future<void> delete(PageModel page);
}
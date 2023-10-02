import 'dart:io';

import 'package:image_diary/model/db/image_dao.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/model/page_repository.dart';

import 'db/page_dao.dart';

class PageRepositoryImplForFirebase extends PageRepository {
  final PageDao _pageDao;
  final ImageDao _imageDao;

  PageRepositoryImplForFirebase({
    required PageDao pageDao,
    required ImageDao imageDao,
  }): _pageDao = pageDao,
    _imageDao = imageDao;

  @override
  Future<List<PageModel>> findAll() async {
    final maps = await _pageDao.findAll();

    // MapでDAOから取得される為、PageItem（List）に変換する
    final List<PageModel> pageList = [];

    for (var map in maps) {
      // Jsonを変換した後、画像を保存する。
      // その後、画像のパスをローカルの物に更新する。
      var page = PageModel.fromJson(map);
      final path = await _imageDao.loadFrom(page.imagePath);
      page = page.copyWith(imagePath: path);
      pageList.add(page);
    }

    return pageList;
  }

  @override
  Future<PageModel> findBy(int id) async {
    // TODO: implement findBy
    throw UnimplementedError();
  }

  @override
  Future<void> insert(PageModel page) async {
    final file = File(page.imagePath);

    final url = await _imageDao.save(file);
    page = page.copyWith(imagePath: url);

    await _pageDao.insert(page.toJson());
  }

}
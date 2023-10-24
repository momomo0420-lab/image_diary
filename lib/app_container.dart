import 'package:image_diary/data/local_db/dao/page_dao.dart';
import 'package:image_diary/data/local_db/dao/page_dao_impl.dart';
import 'package:image_diary/data/local_db/repository/page_repository.dart';
import 'package:image_diary/data/local_db/repository/page_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_container.g.dart';

@riverpod
PageDao pageDao(PageDaoRef ref) {
  return PageDaoImpl();
}

@riverpod
PageRepository pageRepository(PageRepositoryRef ref){
  return PageRepositoryImpl(dao: ref.read(pageDaoProvider));
}

// @riverpod
// PageDao pageDao(PageDaoRef ref){
//   // return PageDaoImpl();
//   return PageDaoImplForFirebase();
// }
//
// @riverpod
// ImageDao imageDao(ImageDaoRef ref) {
//   return ImageDaoImpl();
// }
//
// @riverpod
// PageRepository pageRepository(PageRepositoryRef ref){
//   // return PageRepositoryImpl(dao: ref.watch(pageDaoProvider));
//   return PageRepositoryImplForFirebase(
//       pageDao: ref.read(pageDaoProvider),
//       imageDao: ref.read(imageDaoProvider)
//   );
// }

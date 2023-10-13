import 'package:image_diary/model/db/image_dao.dart';
import 'package:image_diary/model/firebase/dao/image_dao_impl.dart';
import 'package:image_diary/model/db/page_dao.dart';
import 'package:image_diary/model/firebase/dao/page_dao_impl_for_firebase.dart';
import 'package:image_diary/model/page_repository.dart';
import 'package:image_diary/model/firebase/page_repository_impl_for_firebase.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_container.g.dart';

@riverpod
PageDao pageDao(PageDaoRef ref){
  // return PageDaoImpl();
  return PageDaoImplForFirebase();
}

@riverpod
ImageDao imageDao(ImageDaoRef ref) {
  return ImageDaoImpl();
}

@riverpod
PageRepository pageRepository(PageRepositoryRef ref){
  // return PageRepositoryImpl(dao: ref.watch(pageDaoProvider));
  return PageRepositoryImplForFirebase(
      pageDao: ref.read(pageDaoProvider),
      imageDao: ref.read(imageDaoProvider)
  );
}
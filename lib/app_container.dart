import 'package:image_diary/model/db/page_dao.dart';
import 'package:image_diary/model/db/page_dao_impl.dart';
import 'package:image_diary/model/db/page_dao_impl_with_cf.dart';
import 'package:image_diary/model/page_repository.dart';
import 'package:image_diary/model/page_repository_impl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_container.g.dart';

@riverpod
PageDao pageDao(PageDaoRef ref){
  // return PageDaoImpl();
  return PageDaoImplWithCF();
}

@riverpod
PageRepository pageRepository(PageRepositoryRef ref){
  return PageRepositoryImpl(dao: ref.watch(pageDaoProvider));
}
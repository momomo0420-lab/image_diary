import 'package:image_diary/model/diary_page.dart';
import 'package:image_diary/model/diary_page_repository.dart';

class DiaryPageRepositoryStub implements DiaryPageRepository {
  @override
  Future<List<DiaryPage>?> findAll() async {
    // TODO: implement findAll
    throw UnimplementedError();
  }

  @override
  Future<DiaryPage?> findBy(int id) async {
    // TODO: implement findBy
    throw UnimplementedError();
  }

  @override
  Future<void> insert(DiaryPage page) async {
    await Future.delayed(const Duration(seconds: 5));
  }
}
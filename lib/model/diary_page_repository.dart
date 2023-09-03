import 'package:image_diary/model/diary_page.dart';

abstract class DiaryPageRepository {
  Future<List<DiaryPage>?> findAll();
  Future<DiaryPage?> findBy(int id);
  Future<void> insert(DiaryPage imageDiary);
}
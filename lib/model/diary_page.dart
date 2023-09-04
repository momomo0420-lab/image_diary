import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class DiaryPage {
  // final int id;
  final String title;
  final String content;
  final DateTime date;
  final XFile image;

  const DiaryPage({
    // required this.id,
    required this.title,
    required this.content,
    required this.date,
    required this.image
  });

  factory DiaryPage.from(
      String title,
      String content,
      DateTime date,
      XFile image
  ) {
    return DiaryPage(
      title: title,
      content: content,
      date: date,
      image: image
    );
  }

  String getFormattedDate() {
    return DateFormat('yyyy年MM月dd日').format(date);
  }


// Future<Diary> toDiary() async {
  //   return Diary(
  //     id: id,
  //     title: title,
  //     content: content,
  //     date: date.microsecondsSinceEpoch,
  //     image: await image.readAsBytes(),
  //   );
  // }
  //
  // factory Diary.from(Diary diary) {
  //   return Diary(
  //     id: diary.id,
  //     title: diary.title,
  //     content: diary.content,
  //     date: DateTime.fromMillisecondsSinceEpoch(diary.date),
  //     image: XFile.fromData(diary.image),
  //   );
  // }
}
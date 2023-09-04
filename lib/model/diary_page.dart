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

  String getFormattedDate() {
    return DateFormat('yyyy年MM月dd日').format(date);
  }
}
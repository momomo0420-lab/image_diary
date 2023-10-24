import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_diary/data/local_db/model/page_model.dart';
import 'package:image_picker/image_picker.dart';

part 'show_detail_page_view_mode_state.freezed.dart';

@freezed
class ShowDetailPageViewModelState with _$ShowDetailPageViewModelState {
  const factory ShowDetailPageViewModelState ({
    required PageModel page,
    @Default('')
    String title,
    @Default('')
    String content,
    @Default(null)
    XFile? image,
  }) = _ShowDetailPageViewModelState;
}
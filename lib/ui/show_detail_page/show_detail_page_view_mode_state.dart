import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_diary/model/page_model.dart';

part 'show_detail_page_view_mode_state.freezed.dart';

@freezed
class ShowDetailPageViewModelState with _$ShowDetailPageViewModelState {
  const factory ShowDetailPageViewModelState ({
    required PageModel page,
  }) = _ShowDetailPageViewModelState;
}
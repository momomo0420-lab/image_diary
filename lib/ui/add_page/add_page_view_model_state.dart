import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

part 'add_page_view_model_state.freezed.dart';

@freezed
class AddPageViewModelState with _$AddPageViewModelState {
  const factory AddPageViewModelState({
    @Default('')
    String title,
    @Default('')
    String content,
    @Default(null)
    XFile? image,
  }) = _AddPageViewModelState;
}

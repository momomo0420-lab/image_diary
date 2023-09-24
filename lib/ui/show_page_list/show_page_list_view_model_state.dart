import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_diary/model/page_model.dart';

part 'show_page_list_view_model_state.freezed.dart';

@freezed
class ShowPageListViewModelState with _$ShowPageListViewModelState {
  const factory ShowPageListViewModelState ({
    @Default(null)
    List<PageModel>? pageList,
  }) = _ShowPageListViewModelState;
}
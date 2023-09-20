import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_view_mode_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_detail_page_view_model.g.dart';

@riverpod
class ShowDetailPageViewModel extends _$ShowDetailPageViewModel {
  @override
  ShowDetailPageViewModelState build(PageModel page) {
    return ShowDetailPageViewModelState(page: page);
  }
}
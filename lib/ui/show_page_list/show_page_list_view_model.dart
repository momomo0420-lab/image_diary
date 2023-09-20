import 'package:image_diary/app_container.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_view_model_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_page_list_view_model.g.dart';

@riverpod
class ShowPageListViewModel extends _$ShowPageListViewModel {
  @override
  Future<ShowPageListViewModelState> build() async {
    final repository = ref.watch(pageRepositoryProvider);
    final pageList = await repository.findAll();

    return ShowPageListViewModelState(pageList: pageList);
  }
}
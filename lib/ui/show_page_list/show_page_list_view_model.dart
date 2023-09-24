import 'package:flutter/cupertino.dart';
import 'package:image_diary/app_container.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_view_model_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'show_page_list_view_model.g.dart';

@riverpod
class ShowPageListViewModel extends _$ShowPageListViewModel {
  @override
  ShowPageListViewModelState build() {
    debugPrint('ShowPageListViewModel: build start');

    loadPageList();

    return const ShowPageListViewModelState(pageList: null);
  }

  Future<void> loadPageList() async {
    final repository = ref.read(pageRepositoryProvider);
    final pageList = await repository.findAll();

    state = state.copyWith(pageList: pageList);
  }
}
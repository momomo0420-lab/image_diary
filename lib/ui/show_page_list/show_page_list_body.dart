import 'package:flutter/material.dart';
import 'package:image_diary/data/local_db/model/page_model.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_view_model.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_view_model_state.dart';
import 'package:image_diary/ui/widget/diary_card_list.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// 日記ページリスト表示画面のメイン
class ShowPageListBody extends StatelessWidget {
  final ShowPageListViewModel _viewModel;
  final ShowPageListViewModelState _state;
  final Function(PageModel)? _onPageCard;

  /// コンストラクタ
  const ShowPageListBody({
    super.key,
    required ShowPageListViewModel viewModel,
    required ShowPageListViewModelState state,
    Function(PageModel page)? onPageCard,
  }): _viewModel = viewModel,
        _state = state,
        _onPageCard = onPageCard;

  /// メイン
  @override
  Widget build(BuildContext context) {
    final pageList = _state.pageList;
    if(pageList == null) {
      _viewModel.loadPageList(
        onLoading: () => context.loaderOverlay.show(),
        onSuccess: (_) => context.loaderOverlay.hide(),
      );
      return const Placeholder();
    }

    return DiaryCardList(
      pageList: pageList,
      onPageCard: _onPageCard,
    );
  }
}

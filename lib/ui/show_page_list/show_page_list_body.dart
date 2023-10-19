import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_view_model.dart';
import 'package:image_diary/ui/widget/diary_card_list.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// 日記ページリスト表示画面のメイン
class ShowPageListBody extends ConsumerWidget {
  final Function(PageModel)? _onPageCard;

  /// コンストラクタ
  const ShowPageListBody({
    super.key,
    Function(PageModel page)? onPageCard,
  }): _onPageCard = onPageCard;

  /// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(showPageListViewModelProvider);
    final viewModel = ref.read(showPageListViewModelProvider.notifier);

    final pageList = state.pageList;
    if(pageList == null) {
      viewModel.loadPageList(
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

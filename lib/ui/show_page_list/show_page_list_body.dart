import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_view_model.dart';
import 'package:image_diary/ui/widget/diary_card.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// 日記ページリスト表示画面のメイン
class ShowPageListBody extends ConsumerWidget {
  final Function(PageModel) _onPageCard;

  /// コンストラクタ
  const ShowPageListBody({
    super.key,
    required Function(PageModel page) onPageCard,
  }): _onPageCard = onPageCard;

  /// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(showPageListViewModelProvider);
    final viewModel = ref.read(showPageListViewModelProvider.notifier);

    if(state.pageList == null) {
      viewModel.loadPageList(
        onLoading: () => context.loaderOverlay.show(),
        onSuccess: (_) => context.loaderOverlay.hide(),
      );
      return const Placeholder();
    }

    // 表示する内容を1件ずつカード化し、リストに保存する
    List<Widget> diaryPageCardList = [];
    for(var page in state.pageList!) {
      diaryPageCardList.add(
          DiaryCard(
            page: page,
            onTap: (page) => _onPageCard(page),
          )
      );
    }

    // カード化した内容のリストを返却する
    return ListView.builder(
      itemCount: diaryPageCardList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => diaryPageCardList[index],
    );
  }
}

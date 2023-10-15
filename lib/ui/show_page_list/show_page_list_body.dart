import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_diary/model/page_model.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_view_model.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_view_model_state.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// 日記ページリスト表示画面のメイン
class ShowPageListBody extends StatelessWidget {
  final ShowPageListViewModel _viewModel;
  final ShowPageListViewModelState _state;
  final Function(PageModel) _onPageCard;

  /// コンストラクタ
  const ShowPageListBody({
    super.key,
    required ShowPageListViewModel viewModel,
    required ShowPageListViewModelState state,
    required Function(PageModel page) onPageCard,
  }): _viewModel = viewModel,
      _state = state,
      _onPageCard = onPageCard;

  /// メイン
  @override
  Widget build(BuildContext context) {
    if(_state.pageList == null) {
      _viewModel.loadPageList(
        onLoading: () => context.loaderOverlay.show(),
        onSuccess: (_) => context.loaderOverlay.hide(),
      );
      return const Placeholder();
    }

    // 表示する内容を1件ずつカード化し、リストに保存する
    List<Widget> diaryPageCardList = [];
    for(var page in _state.pageList!) {
      diaryPageCardList.add(
          _buildDiaryCard(page)
      );
    }

    // カード化した内容のリストを返却する
    return ListView.builder(
      itemCount: diaryPageCardList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => diaryPageCardList[index],
    );
  }

  /// 日記のページをカード化して読み込む
  ///
  /// @param  日記のページ用データ
  /// @return カード化した日記のページ
  Widget _buildDiaryCard(PageModel page) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        height: 280,
        child: Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),

          child: InkWell(
            splashColor: Colors.blue.withAlpha(30),
            onTap: () => _onPageCard(page),
            child: Column(
              children: [
                Image.file(
                  File(page.imagePath),
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(20),
                  child: Text(
                    page.getFormattedDate(),
                    style: const TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
          )
        ),
      ),
    );
  }
}

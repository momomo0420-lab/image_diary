import 'package:flutter/material.dart';
import 'package:image_diary/model/diary_page.dart';
import 'package:image_diary/ui/widgets/diary_page_card.dart';
import 'package:loader_overlay/loader_overlay.dart';

/// 日記ページリスト表示画面のメイン
class ShowPageListBody extends StatelessWidget {
  // 日記用のページリスト
  final List<DiaryPage>?  _pageList;
  // ページカードを押下された際の処理
  final Function(DiaryPage) _onPageCard;

  /// コンストラクタ
  const ShowPageListBody({
    super.key,
    required List<DiaryPage>? pageList,
    required Function(DiaryPage)  onPageCard,
  }): _pageList = pageList,
    _onPageCard = onPageCard;

  /// メイン
  @override
  Widget build(BuildContext context) {
    return Center(child: decideDisplayingWidget());
  }

  /// 画面に表示する内容を決定する
  ///
  /// @return ページリストが無い or 読み込みが完了していない場合  [Now Loading...]を表示するテキストを返却
  ///         ページリストがある場合　カードに変換後、リスト化し返却
  Widget decideDisplayingWidget() {
    if(_pageList == null) {
      return const Text('Now Loading...');
    }

    List<DiaryPageCard> diaryPageCardList = [];

    for(var page in _pageList!) {
      diaryPageCardList.add(
        DiaryPageCard(
          page: page,
          onTap: (page) => _onPageCard(page)
        )
      );
    }

    return ListView.builder(
      itemCount: diaryPageCardList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => diaryPageCardList[index],
    );
  }
}

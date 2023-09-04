import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_diary/model/diary_page.dart';

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
    return Center(child: _decideDisplayingWidget());
  }

  /// 画面に表示する内容を決定する
  ///
  /// @return ページリストが無い or 読み込みが完了していない場合  [Now Loading...]を表示するテキストを返却
  ///         ページリストがある場合　カードに変換後、リスト化し返却
  Widget _decideDisplayingWidget() {
    // 画面に表示するに内容があるか確認し、無ければ表示するテキストを返却する
    if(_pageList == null) {
      return const Text('Now Loading...');
    }

    // 表示する内容を1件ずつカード化し、リストに保存する
    List<Widget> diaryPageCardList = [];
    for(var page in _pageList!) {
      diaryPageCardList.add(
        _loadDiaryPageCard(page)
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
  Widget _loadDiaryPageCard(DiaryPage page) {
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
                    File(page.image.path),
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

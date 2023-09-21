import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_diary/model/page_model.dart';

/// 日記ページリスト表示画面のメイン
class ShowPageListBody extends StatelessWidget {
  // 日記用のページリスト
  final List<PageModel>  _pageList;
  // ページカードを押下された際の処理
  final Function(PageModel) _onPageCard;

  /// コンストラクタ
  const ShowPageListBody({
    super.key,
    required List<PageModel> pageList,
    required Function(PageModel)  onPageCard,
  }): _pageList = pageList,
    _onPageCard = onPageCard;

  /// メイン
  @override
  Widget build(BuildContext context) {
    // 表示する内容を1件ずつカード化し、リストに保存する
    List<Widget> diaryPageCardList = [];
    for(var page in _pageList) {
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
  Widget _loadDiaryPageCard(PageModel page) {
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
                  Image.memory(
                    Uint8List.fromList(page.image),
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

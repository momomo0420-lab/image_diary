import 'package:flutter/material.dart';
import 'package:image_diary/data/page_model.dart';
import 'package:image_diary/ui/widget/diary_card.dart';

class DiaryCardList extends StatelessWidget {
  final List<PageModel> _pageList;
  final Function(PageModel)? _onPageCard;

  const DiaryCardList({
    super.key,
    required List<PageModel> pageList,
    Function(PageModel)? onPageCard,
  }): _pageList = pageList,
        _onPageCard = onPageCard;

  @override
  Widget build(BuildContext context) {
    // 表示する内容を1件ずつカード化し、リストに保存する
    List<Widget> diaryCardList = [];
    for(var page in _pageList) {
      final diaryCard = Padding(
        padding: const EdgeInsets.all(8.0),
        child: DiaryCard(
          page: page,
          onTap: _onPageCard,
        ),
      );
      diaryCardList.add(diaryCard);
    }

    // カード化した内容のリストを返却する
    return ListView.builder(
      itemCount: diaryCardList.length,
      shrinkWrap: true,
      itemBuilder: (context, index) => diaryCardList[index],
    );
  }
}

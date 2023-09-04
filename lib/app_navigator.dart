import 'package:flutter/material.dart';
import 'package:image_diary/model/diary_page_repository_stub.dart';
import 'package:image_diary/ui/add_page/add_page_screen.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_screen.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_screen.dart';

enum ImageDiaryScreens {
  start,
  addPage,
  detailPage,
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  // TODO: リポジトリは後日実装予定
  // 日記ページ操作用のリポジトリ
  final _repository = DiaryPageRepositoryStub();

  /// メイン
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '画像日記アプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      routes: <String, WidgetBuilder> {
        // スタート画面
        ImageDiaryScreens.start.name: (BuildContext context) {
          return ShowPageListScreen(
            repository: _repository,
            navigateToAddPage: () => Navigator.of(context).pushNamed(
                ImageDiaryScreens.addPage.name
            ),
            // TODO: 選択されたページを詳細画面に送れるようにする必要あり
            navigateToShowDetailPage: (page) => Navigator.of(context).pushNamed(
                ImageDiaryScreens.detailPage.name,
            ),
          );
        },

        // TODO: 選択されたページを受け取れるようにする必要あり
        // 日記の詳細画面
        ImageDiaryScreens.detailPage.name: (BuildContext context) {
          return ShowDetailPageScreen(
              repository: _repository,
          );
        },

        // ページ追加用画面
        ImageDiaryScreens.addPage.name: (BuildContext context) {
          return AddPageScreen(
            repository: _repository,
            destinationAfterWriting: () => Navigator.of(context).pop()
          );
        }
      },
      initialRoute: ImageDiaryScreens.start.name,
    );
  }
}

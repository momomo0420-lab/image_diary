import 'package:flutter/material.dart';
import 'package:image_diary/ui/add_page/add_page_screen.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_screen.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_screen.dart';

/// 画像日記アプリの全画面構成
enum ImageDiaryScreens {
  start('/start'),
  addPage('/add_page'),
  detailPage('/detail_page'),
  ;

  final String screen;

  const ImageDiaryScreens(this.screen);
}

/// ナビゲーター
class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

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
        ImageDiaryScreens.start.screen: (BuildContext context) {
          return ShowPageListScreen(
            navigateToAddPage: () => Navigator.of(context).pushNamed(
                ImageDiaryScreens.addPage.screen
            ),
            navigateToShowDetailPage: (page) => Navigator.of(context).pushNamed(
              ImageDiaryScreens.detailPage.screen,
              arguments: page
            ),
          );
        },

        // 日記の詳細画面
        ImageDiaryScreens.detailPage.screen: (BuildContext context) {
          return const ShowDetailPageScreen();
        },

        // ページ追加用画面
        ImageDiaryScreens.addPage.screen: (BuildContext context) {
          return AddPageScreen(
            destinationAfterWriting: () => Navigator.of(context).pushNamedAndRemoveUntil(
              ImageDiaryScreens.start.screen,
              (_) => false
            )
          );
        }
      },
      initialRoute: ImageDiaryScreens.start.screen,
    );
  }
}



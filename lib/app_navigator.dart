import 'package:flutter/material.dart';
import 'package:image_diary/model/db/page_dao_impl.dart';
import 'package:image_diary/model/page_item.dart';
import 'package:image_diary/model/page_item_repository_impl.dart';
import 'package:image_diary/ui/add_page/add_page_screen.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_screen.dart';
import 'package:image_diary/ui/show_page_list/show_page_list_screen.dart';

/// 画像日記アプリの全画面構成
enum ImageDiaryScreens {
  start,
  addPage,
  detailPage,
}

/// ナビゲーター
class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  // TODO: リポジトリは後日実装予定
  // 日記ページ操作用のリポジトリ
  final _repository = PageItemRepositoryImpl(dao: PageDaoImpl());

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
            navigateToShowDetailPage: (page) => Navigator.of(context).pushNamed(
              ImageDiaryScreens.detailPage.name,
              arguments: page
            ),
          );
        },

        // 日記の詳細画面
        ImageDiaryScreens.detailPage.name: (BuildContext context) {
          final page = ModalRoute.of(context)!.settings.arguments as PageItem;
          return ShowDetailPageScreen(
              page: page,
          );
        },

        // ページ追加用画面
        ImageDiaryScreens.addPage.name: (BuildContext context) {
          return AddPageScreen(
            repository: _repository,
            destinationAfterWriting: () => Navigator.of(context).pushNamedAndRemoveUntil(
              ImageDiaryScreens.start.name,
              (_) => false
            )
          );
        }
      },
      initialRoute: ImageDiaryScreens.start.name,
    );
  }
}

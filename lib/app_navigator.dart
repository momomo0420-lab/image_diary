import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_diary/model/page_model.dart';
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
class AppNavigator extends ConsumerWidget {
  const AppNavigator({super.key});


/// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          final page = ModalRoute.of(context)!.settings.arguments as PageModel;
          return ShowDetailPageScreen(
              page: page,
          );
        },

        // ページ追加用画面
        ImageDiaryScreens.addPage.name: (BuildContext context) {
          return AddPageScreen(
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



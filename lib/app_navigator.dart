import 'package:flutter/material.dart';
import 'package:image_diary/model/diary_page_repository_stub.dart';
import 'package:image_diary/ui/add_page/add_page_screen.dart';
import 'package:image_diary/ui/show_detail_page/show_detail_page_screen.dart';

enum ImageDiaryScreens {
  addPage,
  showPageList,
  detailPage,
}

class AppNavigator extends StatefulWidget {
  const AppNavigator({super.key});

  @override
  State<AppNavigator> createState() => _AppNavigatorState();
}

class _AppNavigatorState extends State<AppNavigator> {
  final _repository = DiaryPageRepositoryStub();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '画像日記アプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      routes: <String, WidgetBuilder> {
        // ImageDiaryScreens.start.name: (BuildContext context) => DiaryListScreen(repository: repository.requireData),

        ImageDiaryScreens.detailPage.name: (BuildContext context) {
          return ShowDetailPageScreen(
              repository: _repository,
          );
        },

        ImageDiaryScreens.addPage.name: (BuildContext context) {
          return AddPageScreen(
            repository: _repository,
            navigateToNextScreen: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('画面遷移機能は準備中です'))
              );
            },
          );
        }
      },
      initialRoute: ImageDiaryScreens.detailPage.name,
    );
  }
}

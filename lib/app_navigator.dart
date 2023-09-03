import 'package:flutter/material.dart';
import 'package:image_diary/model/diary_page_repository.dart';
import 'package:image_diary/model/diary_page_repository_stub.dart';
import 'package:image_diary/ui/add_diary/add_page_screen.dart';

enum ImageDiaryScreens {
  add,
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
        // ImageDiaryScreen.start.name: (BuildContext context) => DiaryListScreen(repository: repository.requireData),
        // ImageDiaryScreen.detail.name: (BuildContext context) => const DetailDiaryScreen(),
        ImageDiaryScreens.add.name: (BuildContext context) {
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
      initialRoute: ImageDiaryScreens.add.name,
    );
  }
}

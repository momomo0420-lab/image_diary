import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app_navigator.dart';

// void main() async {
//   // Firebaseの初期化
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//
//   // メイン
//   runApp(
//     const ProviderScope(
//       child:  AppNavigator()
//     )
//   );
// }
void main() {
  // メイン
  runApp(
    const ProviderScope(
      child:  AppNavigator()
    )
  );
}

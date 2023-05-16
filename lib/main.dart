import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_example/ui/auth/sign_in.dart';
import 'package:firebase_example/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
// Firebaseを使うときのお決まりの設定を書く
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Firebase CLIを使用する場合はこちらの書き方は変わる
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // StreamBuilderを使用して、認証状態を監視させる
      home: StreamBuilder<User?>(
        // authStateChangesを使用してログイン状態を維持することができる
        // ユーザーがログインしていれば、ログインしているページへ画面遷移する
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // スプラッシュ画面などに書き換えても良い
              return const SizedBox();
            }
            if (snapshot.hasData) {
              // User が null でなない、つまりサインイン済みのホーム画面へ
              return const MyHomePage();
            }
            // User が null である、つまり未サインインのサインイン画面へ
            return const SignInPage();
          },
        ),
      );
  }
}

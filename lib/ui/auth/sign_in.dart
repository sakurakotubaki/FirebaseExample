import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/ui/auth/sign_up.dart';
import 'package:firebase_example/ui/pages/home_page.dart';
import 'package:flutter/material.dart';

// ログインをするページ
class SignInPage extends StatelessWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // FirebaseAuthの機能を使えるように、インスタンス化をする。これでログインを含む認証機能に必要なメソッドを使用できる。
    final auth = FirebaseAuth.instance;
    final email = TextEditingController();
    final password = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignIn'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
            ),
            TextField(
              controller: password,
            ),
            // 非同期処理をするときは、async, awaitを使う。時間のかかる処理で使うと覚えれば大丈夫
            ElevatedButton(
                onPressed: () async {
                  // ログインをするメソッド
                  await auth.signInWithEmailAndPassword(
                      email: email.text, password: password.text);
                  if (context.mounted) {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()),
                        (route) => false);
                  }
                },
                child: const Text('ログイン')),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignUpPage()));
                },
                child: const Text('新規登録はこちら'))
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/ui/pages/home_page.dart';
import 'package:flutter/material.dart';
// 新規登録するページ
class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final email = TextEditingController();
    final password = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp'),
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
                  // ユーザーのアカウントを作成する
                  await auth.createUserWithEmailAndPassword(
                      email: email.text, password: password.text);
                  if (context.mounted) {
                    // ログイン後のページへ画面遷移するコード
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage()),
                        (route) => false);
                  }
                },
                child: const Text('新規登録')),
          ],
        ),
      ),
    );
  }
}

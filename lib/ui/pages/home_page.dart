import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_example/ui/auth/sign_in.dart';
import 'package:flutter/material.dart';
// ログイン後のページ
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  // 今回は単純に数字をコレクションのフィールドに保存するだけ

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    // Cloud Firestoreをインスタンス化する。これで、Firestoreを操作するメソッド使用できる
    final store = FirebaseFirestore.instance;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () async {
                // ログアウトを行うsignOutメソッド
                // ログアウトするとログインページへ画面遷移する
                await auth.signOut();
                if (context.mounted) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SignInPage()),
                      (route) => false);
                }
              },
              icon: const Icon(Icons.logout))
        ],
        title: const Text('Counter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _incrementCounter();
          // どのユーザーか特定するのに、FirebaseAuthのuidを使用する
          // ログインしていれば取得することができる
          final uid = auth.currentUser?.uid;
          // データを保存するときは、Map型で書く。'count': 100,左が、String型で、
          // 右は、String, int, bool保存したいデータを使う
          await store.collection('counter').doc(uid).set({
            'count': 100,
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

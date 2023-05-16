# firebase_example

## 新規登録の方法
Firebaseで新規登録をするには、createUserWithEmailAndPasswordメソッドを使います。
if (context.mounted) {}は、非同期処理のコードの中にBuildContextを
使うコードを書くと、リントの警告が出てくるのを消すのに使います。画面遷移のコード以外だと、スナックバーやダイアログがあります。

```dart
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
```

## ログインする方法
ユーザーがログインをするには、signInWithEmailAndPasswordメソッドを使用します。
```dart
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
```

どちらのメソッドにも認証機能を使うのに、必要なメールアドレスとパスワードを入力フォームから渡しています。

## ログアウトする方法
ログインしたページから、ユーザーがログアウトするには、signOutメソッドを使用します。

```dart
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
```

## ユーザーのログイン状態を判定する
ユーザーがログインしているかいないかで、アプリを起動したときに、表示する画面を変えることができます。わかりやすく言うと、ログインした状態を維持することができるようになります。

```dart
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
```
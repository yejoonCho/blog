import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    final errorNotifier = ValueNotifier<String>('');
    return Dialog(
      child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Login'),
            SizedBox(height: 10),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 10),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 30),
            TextButton(
              child: Text(
                'Log in',
                style: TextStyle(color: Colors.white),
              ),
              style: TextButton.styleFrom(backgroundColor: Colors.blueAccent),
              onPressed: () {
                final email = emailController.text;
                final password = passwordController.text;
                if (email.isEmpty || password.isEmpty) {
                  errorNotifier.value = 'Fill in the empty fields';
                } else {
                  FirebaseAuth.instance
                      .signInWithEmailAndPassword(
                          email: email, password: password)
                      .then((_) => Navigator.of(context).pop())
                      .catchError((error) {
                    if (error is FirebaseAuthException) {
                      errorNotifier.value = error.message!;
                    }
                  });
                }
              },
            ),
            SizedBox(height: 10),
            ValueListenableBuilder<String>(
              valueListenable: errorNotifier,
              builder: (context, value, child) {
                return Provider<String>.value(
                  value: value,
                  child: TextError(),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}

class TextError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final value = Provider.of<String>(context);
    return Text(value);
  }
}

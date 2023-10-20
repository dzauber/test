import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ForgaotPasswordPage extends StatefulWidget {
  final controller;

  const ForgaotPasswordPage({super.key, this.controller});

  @override
  State<ForgaotPasswordPage> createState() => _ForgaotPasswordPageState();
}

class _ForgaotPasswordPageState extends State<ForgaotPasswordPage> {
  final _emailControler = TextEditingController();

  @override
  void dispose() {
    _emailControler.dispose();
    super.dispose();
  }

  Future<void> passwordReset(BuildContext context) async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailControler.text.trim());
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text('Passwort wird zugesendet!!!!'),
          );
        },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: Text(e.message.toString()),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              'Trage deine E-Mail ein, dann senden wir dir eine Wiederherstellunglink zu erhalten!!!!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: TextField(
              controller: _emailControler,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.deepPurple),
                  borderRadius: BorderRadius.circular(12),
                ),
                hintText: 'Email',
                fillColor: Colors.grey[200],
                filled: true,
              ),
            ),
          ),
          const SizedBox(height: 10),
          MaterialButton(
            onPressed: () {
              HapticFeedback.heavyImpact(); // Add haptic feedback
              passwordReset(context);
            },
            child: Text('Passwort Zurücksetzen'),
            color: Colors.deepPurple[200],
          ),
        ],
      ),
    );
  }
}

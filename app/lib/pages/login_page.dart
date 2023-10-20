import 'package:app/components/my_button.dart';
import 'package:app/components/my_textfild.dart';
import 'package:app/components/square_tile.dart';
import 'package:app/pages/forgot_pw_page.dart';
import 'package:app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Text Controler
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  // Login method
  void loginUser() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // show error massage
      showErrorMessage(e.code);
    }
  }

  // erro to user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              const SizedBox(height: 50),

              //  logo
              const Icon(
                Icons.lock,
                size: 50,
              ),

              const SizedBox(height: 25),

              // Willkommen zurück!
              Text(
                'Wilkommen zurück',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),
              // username email
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obsureText: false,
              ),
              const SizedBox(height: 10),
              // passwort
              MyTextField(
                controller: passwordController,
                hintText: 'Passwort',
                obsureText: true,
              ),

              const SizedBox(height: 10),
              // passwort vergessen
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) {
                            return ForgaotPasswordPage();
                          },
                        ));
                      },
                      child: Text(
                        'Passwort vergessen?',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
              // login
              MyButton(
                text: "Anmelden",
                onTap: loginUser,
              ),

              const SizedBox(height: 50),
              // weiter mit
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Text(
                        'Weiter mit',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 0.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 50),
              // google + apple login
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //google
                  SquareTile(
                    onTap: () {
                      HapticFeedback.mediumImpact(); // Add haptic feedback
                      AuthService().signInWithGoogle();
                    },
                    imagePath: 'lib/images/google.png',
                  ),

                  // ERST AUSKLAMMERN WENN APPLE GEWOLLT UND GEHT
                  // const SizedBox(width: 25),
                  // apple

                  // SquareTile(onTap: () {}, imagePath: 'lib/images/apple.png'),
                ],
              ),

              const SizedBox(height: 50),
              // registrieren
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Kein Mitglied',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: () {
                      HapticFeedback.heavyImpact(); // Add haptic feedback
                      widget.onTap!();
                    },
                    child: const Text(
                      'Jetzt Registrieren',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

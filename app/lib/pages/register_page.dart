import 'package:app/components/my_button.dart';
import 'package:app/components/my_textfild.dart';
import 'package:app/components/square_tile.dart';
import 'package:app/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Text Controler
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Login method
  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    // try casting th user
    try {
      if(passwordController.text == confirmPasswordController.text){
         await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
          );
      } else {
        showErrorMessage("Passwort stimmt nicht Überein");
      }
    
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      // ignore: use_build_context_synchronously
     // Navigator.pop(context);
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
              const SizedBox(height: 25),

              //  logo
              const Icon(
                Icons.lock,
                size: 50,
              ),

              const SizedBox(height: 25),

              // Willkommen zurück!
              Text(
                'Jetzt Account Erstellen!',
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

              // Passwort bestätigen
              MyTextField(
                controller: confirmPasswordController,
                hintText: 'Passwort Bestätigen',
                obsureText: true,
              ),

              const SizedBox(height: 25),
              // login
              MyButton(
                text: "Registrieren",
                onTap: signUserUp,
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
              // googel + apple login
               Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //googel
                  SquareTile(
                     onTap: () => AuthService().signInWithGoogle(),
                    imagePath: 'lib/images/google.png'),

                  const SizedBox(width: 25),
                  //apple

                  SquareTile(
                     onTap:  () {

                      
                    },
                    imagePath: 'lib/images/apple.png'),
                ],
              ),

              const SizedBox(height: 50),
              // registrieren
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Hab schon ein Account',
                    style: TextStyle(color: Colors.grey[700]),
                  ),
                  const SizedBox(width: 4),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      'Jetzt Anmelden',
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

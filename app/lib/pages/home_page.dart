import 'package:app/components/menu_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'learning_page.dart';
import 'gottesdienst_qr.dart';
import 'song_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final user = FirebaseAuth.instance.currentUser!;

  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  gottesdienst(context) {
    return () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const Gottesdienst()));
    };
  }

  lernstoff(context) {
    return () {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const LearningPage()));
    };
  }

  lieder(context) {
    return () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const SongPage()));
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: signUserOut,
              tooltip: 'Logout',
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
                size: 30.0,
              ),
            )
          ],
          title: const Row(children: [
            Icon(Icons.home_filled, color: Colors.white, size: 30.0),
            Text('Home',
                style: TextStyle(
                    fontSize: 30.0,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
          ]),
        ),
        body: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Temp zum zeigen das es geht
            //Text("LOOGT IN ALS: ${user.email!}"),
            MenuButton(
                onTap: gottesdienst(context),
                icon: Icons.church,
                text: 'Gottesdienst'),
            MenuButton(
                onTap: lernstoff(context),
                icon: Icons.content_paste_outlined,
                text: 'Lernstoff'),
            MenuButton(
                onTap: lieder(context),
                icon: Icons.music_note_rounded,
                text: 'Lieder')
          ],
        )),
        backgroundColor: Colors.grey[300]);
  }
}

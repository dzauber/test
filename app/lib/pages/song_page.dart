import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class SongPage extends StatelessWidget {
  const SongPage({Key? key}) : super(key: key); // Hier war ein Fehler bei "key"

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              title: const Row(children: [
                Icon(Icons.music_note_rounded, color: Colors.white, size: 30.0),
                Text(' Lieder',
                    style: TextStyle(
                        fontSize: 30.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ]),
            ),
            body: SfPdfViewer.network('https://t.ly/z0FsP')));
  }
}

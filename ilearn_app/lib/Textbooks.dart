
// TextbooksScreen.dart
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class TextbooksScreen extends StatelessWidget {
  const TextbooksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Textbooks')),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('textbooks').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            children: snapshot.data!.docs.map((doc) {
              return ListTile(
                title: Text(doc['title']),
                subtitle: Text(doc['subject']),
                trailing: const Icon(Icons.picture_as_pdf, color: Colors.red),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PDFViewerScreen(pdfUrl: doc['pdfUrl']),
                    ),
                  );
                },
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

// PDF Viewer
class PDFViewerScreen extends StatelessWidget {
  final String pdfUrl;
  const PDFViewerScreen({super.key, required this.pdfUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View PDF')),
      body: PDFView(
        filePath: pdfUrl,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import '../../domain/entities/report.dart';

class ResultPage extends StatelessWidget {
  final Report report;

  const ResultPage({Key? key, required this.report}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Finkey Type'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  report.summary,
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
            ),
            SizedBox(height: 16.0),
            ElevatedButton.icon(
              onPressed: _shareReport,
              icon: Icon(Icons.share),
              label: Text('Share Your Report'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _shareReport() {
    Share.share('Check out my Finkey Type report: ${report.summary}');
  }
}

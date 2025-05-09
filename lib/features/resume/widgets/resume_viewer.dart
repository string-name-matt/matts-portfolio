// Renders the Markdown resume file for authorized users using gpt_markdown

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class ResumeViewer extends StatefulWidget {
  const ResumeViewer({super.key});

  @override
  State<ResumeViewer> createState() => _ResumeViewerState();
}

class _ResumeViewerState extends State<ResumeViewer> {
  String _markdownContent = '';

  @override
  void initState() {
    super.initState();
    _loadResume();
  }

  // Loads resume.md from assets
  Future<void> _loadResume() async {
    final content = await rootBundle.loadString('assets/resume.md');
    setState(() {
      _markdownContent = content;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _markdownContent.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : GptMarkdown(
      _markdownContent,
      style: const TextStyle(fontSize: 16),
    );
  }
}

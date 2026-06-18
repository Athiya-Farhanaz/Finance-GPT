import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const TextSummarizationApp());
}

class TextSummarizationApp extends StatelessWidget {
  const TextSummarizationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const TextSummarizationScreen(),
    );
  }
}

class TextSummarizationScreen extends StatefulWidget {
  const TextSummarizationScreen({super.key});

  @override
  _TextSummarizationScreenState createState() => _TextSummarizationScreenState();
}

class _TextSummarizationScreenState extends State<TextSummarizationScreen> {
  final TextEditingController _textController = TextEditingController();
  String _summary = "Enter text to summarize";
  bool _isLoading = false;
  final String apiUrl = "http://192.168.59.23:5000/summarize"; // Update with your Flask server IP

  Future<void> _summarizeText() async {
    if (_textController.text.isEmpty) {
      setState(() {
        _summary = "Please enter some text";
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _summary = "Generating summary...";
    });

    try {
      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": _textController.text}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          _summary = jsonResponse['summary'] ?? "No summary received";
          _isLoading = false;
        });
      } else {
        setState(() {
          _summary = "API Error: ${response.statusCode}";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _summary = "Error: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Text Summarization")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Enter Text to Summarize:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _textController,
                maxLines: 10,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Paste your text here...",
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _summarizeText,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text("Generate Summary"),
              ),
              const SizedBox(height: 20),
              const Text(
                "Summary:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _summary,
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
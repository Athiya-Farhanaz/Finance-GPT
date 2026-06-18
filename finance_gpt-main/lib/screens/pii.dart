// // // import 'dart:convert';
// // // import 'dart:io';
// // // import 'package:flutter/material.dart';
// // // import 'package:http/http.dart' as http;
// // // import 'package:file_picker/file_picker.dart';
// // // import 'package:path_provider/path_provider.dart';
// // // import 'package:open_file/open_file.dart'; // For opening the output file
// // // import 'package:share_plus/share_plus.dart'; // For sharing the file
// // // import 'package:path/path.dart' as path; // For extracting filename

// // // void main() {
// // //   runApp(const MyApp());
// // // }

// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       debugShowCheckedModeBanner: false,
// // //       theme: ThemeData(
// // //         scaffoldBackgroundColor: Colors.transparent, // For gradient background
// // //       ),
// // //       home: const PIIMaskingScreen(),
// // //     );
// // //   }
// // // }

// // // class PIIMaskingScreen extends StatefulWidget {
// // //   const PIIMaskingScreen({super.key});

// // //   @override
// // //   _PIIMaskingScreenState createState() => _PIIMaskingScreenState();
// // // }

// // // class _PIIMaskingScreenState extends State<PIIMaskingScreen> {
// // //   String _inputFileName = "No file selected";
// // //   String _statusMessage = "...";
// // //   String? _outputFilePath; // To store the output file path (kept private)
// // //   bool _isLoading = false;
// // //   final String baseUrl = "http://192.168.238.23:5000/api/predict";

// // //   Future<void> _pickFileAndMask() async {
// // //     try {
// // //       // Step 1: Pick the input text file
// // //       FilePickerResult? result = await FilePicker.platform.pickFiles(
// // //         type: FileType.custom,
// // //         allowedExtensions: ['txt'],
// // //       );

// // //       if (result == null || result.files.single.path == null) {
// // //         setState(() {
// // //           _statusMessage = "⚠ No file selected";
// // //         });
// // //         return;
// // //       }

// // //       String fullPath = result.files.single.path!;
// // //       setState(() {
// // //         _inputFileName = path.basename(fullPath); // Extract only the filename
// // //         _isLoading = true;
// // //         _statusMessage = "Processing...";
// // //       });

// // //       // Step 2: Extract text from the file
// // //       String fileContent = await File(fullPath).readAsString();

// // //       // Step 3: Send the text to the API for masking
// // //       var response = await http.post(
// // //         Uri.parse(baseUrl),
// // //         headers: {"Content-Type": "application/json"},
// // //         body: jsonEncode({"text": fileContent}),
// // //       );

// // //       if (response.statusCode == 200) {
// // //         var jsonResponse = jsonDecode(response.body);
// // //         String maskedText = jsonResponse['masked_text'] ?? "No masked text received";

// // //         // Step 4: Create a new text file with the masked content
// // //         final directory = await getApplicationDocumentsDirectory();
// // //         final outputFile = File('${directory.path}/masked_${path.basenameWithoutExtension(fullPath)}_output.txt');
// // //         await outputFile.writeAsString(maskedText);

// // //         setState(() {
// // //           _outputFilePath = outputFile.path;
// // //           _statusMessage = "✅ File processed successfully";
// // //         });
// // //       } else {
// // //         setState(() {
// // //           _statusMessage = "❌ API Error: ${response.statusCode}";
// // //         });
// // //       }
// // //     } catch (e) {
// // //       setState(() {
// // //         _statusMessage = "❌ Error: $e";
// // //       });
// // //     } finally {
// // //       setState(() => _isLoading = false);
// // //     }
// // //   }

// // //   // Open the output file
// // //   void _openOutputFile() {
// // //     if (_outputFilePath != null) {
// // //       OpenFile.open(_outputFilePath!);
// // //     } else {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text("No output file available yet")),
// // //       );
// // //     }
// // //   }

// // //   // Share the output file
// // //   void _shareOutputFile() {
// // //     if (_outputFilePath != null) {
// // //       Share.shareFiles([_outputFilePath!], text: 'Here is your PII-masked file');
// // //     } else {
// // //       ScaffoldMessenger.of(context).showSnackBar(
// // //         const SnackBar(content: Text("No output file available yet")),
// // //       );
// // //     }
// // //   }

// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return Scaffold(
// // //       body: Container(
// // //         decoration: const BoxDecoration(
// // //           gradient: LinearGradient(
// // //             begin: Alignment.topCenter,
// // //             end: Alignment.bottomCenter,
// // //             colors: [Colors.black, Colors.green],
// // //           ),
// // //         ),
// // //         child: Center(
// // //           child: SingleChildScrollView(
// // //             child: Padding(
// // //               padding: const EdgeInsets.all(16.0),
// // //               child: Column(
// // //                 mainAxisAlignment: MainAxisAlignment.center,
// // //                 children: [
// // //                   // Display selected input file (only filename)
// // //                   Container(
// // //                     padding: const EdgeInsets.all(12),
// // //                     decoration: BoxDecoration(
// // //                       border: Border.all(color: Colors.yellow),
// // //                       borderRadius: BorderRadius.circular(8),
// // //                       color: Colors.black.withOpacity(0.7),
// // //                     ),
// // //                     child: Text(
// // //                       "Selected File: $_inputFileName",
// // //                       style: const TextStyle(color: Colors.yellow),
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 20),

// // //                   // Button to pick file and mask PII
// // //                   ElevatedButton(
// // //                     onPressed: _isLoading ? null : _pickFileAndMask,
// // //                     style: ElevatedButton.styleFrom(
// // //                       backgroundColor: Colors.yellow,
// // //                       foregroundColor: Colors.black,
// // //                       padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
// // //                     ),
// // //                     child: _isLoading
// // //                         ? const CircularProgressIndicator(color: Colors.black)
// // //                         : const Text("Select File & Mask PII"),
// // //                   ),
// // //                   const SizedBox(height: 20),

// // //                   // Status message display (no file path)
// // //                   Container(
// // //                     padding: const EdgeInsets.all(12),
// // //                     decoration: BoxDecoration(
// // //                       border: Border.all(color: Colors.yellow),
// // //                       borderRadius: BorderRadius.circular(8),
// // //                       color: Colors.black.withOpacity(0.7),
// // //                     ),
// // //                     child: Text(
// // //                       _statusMessage,
// // //                       style: const TextStyle(
// // //                         fontSize: 16,
// // //                         fontWeight: FontWeight.bold,
// // //                         color: Colors.yellow,
// // //                       ),
// // //                       textAlign: TextAlign.left,
// // //                     ),
// // //                   ),
// // //                   const SizedBox(height: 20),

// // //                   // Button to open the output file
// // //                   if (_outputFilePath != null)
// // //                     ElevatedButton(
// // //                       onPressed: _openOutputFile,
// // //                       style: ElevatedButton.styleFrom(
// // //                         backgroundColor: Colors.yellow,
// // //                         foregroundColor: Colors.black,
// // //                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
// // //                       ),
// // //                       child: const Text("View PII Masked File"),
// // //                     ),
// // //                   const SizedBox(height: 10),

// // //                   // Button to share the output file
// // //                   if (_outputFilePath != null)
// // //                     ElevatedButton(
// // //                       onPressed: _shareOutputFile,
// // //                       style: ElevatedButton.styleFrom(
// // //                         backgroundColor: Colors.yellow,
// // //                         foregroundColor: Colors.black,
// // //                         padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
// // //                       ),
// // //                       child: const Text("Share PII Masked File"),
// // //                     ),
// // //                 ],
// // //               ),
// // //             ),
// // //           ),
// // //         ),
// // //       ),
// // //     );
// // //   }
// // // }

// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:file_picker/file_picker.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:open_file/open_file.dart';
// // import 'package:share_plus/share_plus.dart';
// // import 'package:path/path.dart' as path;

// // void main() {
// //   runApp(const PIIMaskingApp());
// // }

// // class PIIMaskingApp extends StatelessWidget {
// //   const PIIMaskingApp({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
// //       home: const PIIMaskingScreen(),
// //     );
// //   }
// // }

// // class PIIMaskingScreen extends StatefulWidget {
// //   const PIIMaskingScreen({super.key});

// //   @override
// //   _PIIMaskingScreenState createState() => _PIIMaskingScreenState();
// // }

// // class _PIIMaskingScreenState extends State<PIIMaskingScreen> {
// //   String _inputFileName = "No file selected";
// //   String _statusMessage = "Waiting for file...";
// //   String? _outputFilePath;
// //   bool _isLoading = false;
// //   final String apiUrl = "http://192.168.198.23:5000/mask"; // Update with your Flask server IP

// //   Future<void> _pickFileAndMask() async {
// //     try {
// //       FilePickerResult? result = await FilePicker.platform.pickFiles(
// //         type: FileType.custom,
// //         allowedExtensions: ['txt'],
// //       );

// //       if (result == null || result.files.single.path == null) {
// //         setState(() {
// //           _statusMessage = "No file selected";
// //         });
// //         return;
// //       }

// //       String fullPath = result.files.single.path!;
// //       setState(() {
// //         _inputFileName = path.basename(fullPath);
// //         _isLoading = true;
// //         _statusMessage = "Processing...";
// //       });

// //       String fileContent = await File(fullPath).readAsString();

// //       var response = await http.post(
// //         Uri.parse(apiUrl),
// //         headers: {"Content-Type": "application/json"},
// //         body: jsonEncode({"text": fileContent}),
// //       );

// //       if (response.statusCode == 200) {
// //         var jsonResponse = jsonDecode(response.body);
// //         String maskedText = jsonResponse['masked_text'] ?? "No masked text received";

// //         final directory = await getApplicationDocumentsDirectory();
// //         final outputFile = File('${directory.path}/masked_${path.basenameWithoutExtension(fullPath)}_output.txt');
// //         await outputFile.writeAsString(maskedText);

// //         setState(() {
// //           _outputFilePath = outputFile.path;
// //           _statusMessage = "File processed successfully";
// //           _isLoading = false;
// //         });
// //       } else {
// //         setState(() {
// //           _statusMessage = "API Error: ${response.statusCode}";
// //           _isLoading = false;
// //         });
// //       }
// //     } catch (e) {
// //       setState(() {
// //         _statusMessage = "Error: $e";
// //         _isLoading = false;
// //       });
// //     }
// //   }

// //   void _openOutputFile() {
// //     if (_outputFilePath != null) {
// //       OpenFile.open(_outputFilePath!);
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("No output file available")),
// //       );
// //     }
// //   }

// //   void _shareOutputFile() {
// //     if (_outputFilePath != null) {
// //       Share.shareFiles([_outputFilePath!], text: 'Here is your PII-masked file');
// //     } else {
// //       ScaffoldMessenger.of(context).showSnackBar(
// //         const SnackBar(content: Text("No output file available")),
// //       );
// //     }
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         decoration: const BoxDecoration(
// //           gradient: LinearGradient(
// //             begin: Alignment.topCenter,
// //             end: Alignment.bottomCenter,
// //             colors: [Colors.blue, Colors.white],
// //           ),
// //         ),
// //         child: Center(
// //           child: SingleChildScrollView(
// //             child: Padding(
// //               padding: const EdgeInsets.all(16.0),
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Container(
// //                     padding: const EdgeInsets.all(12),
// //                     decoration: BoxDecoration(
// //                       border: Border.all(color: Colors.black),
// //                       borderRadius: BorderRadius.circular(8),
// //                       color: Colors.white.withOpacity(0.8),
// //                     ),
// //                     child: Text(
// //                       "Selected File: $_inputFileName",
// //                       style: const TextStyle(color: Colors.black),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   ElevatedButton(
// //                     onPressed: _isLoading ? null : _pickFileAndMask,
// //                     style: ElevatedButton.styleFrom(
// //                       backgroundColor: Colors.blue,
// //                       foregroundColor: Colors.white,
// //                     ),
// //                     child: _isLoading
// //                         ? const CircularProgressIndicator(color: Colors.white)
// //                         : const Text("Select File & Mask PII"),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   Container(
// //                     padding: const EdgeInsets.all(12),
// //                     decoration: BoxDecoration(
// //                       border: Border.all(color: Colors.black),
// //                       borderRadius: BorderRadius.circular(8),
// //                       color: Colors.white.withOpacity(0.8),
// //                     ),
// //                     child: Text(
// //                       _statusMessage,
// //                       style: const TextStyle(fontSize: 16, color: Colors.black),
// //                     ),
// //                   ),
// //                   const SizedBox(height: 20),
// //                   if (_outputFilePath != null) ...[
// //                     ElevatedButton(
// //                       onPressed: _openOutputFile,
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.blue,
// //                         foregroundColor: Colors.white,
// //                       ),
// //                       child: const Text("View Masked File"),
// //                     ),
// //                     const SizedBox(height: 10),
// //                     ElevatedButton(
// //                       onPressed: _shareOutputFile,
// //                       style: ElevatedButton.styleFrom(
// //                         backgroundColor: Colors.blue,
// //                         foregroundColor: Colors.white,
// //                       ),
// //                       child: const Text("Share Masked File"),
// //                     ),
// //                   ],
// //                 ],
// //               ),
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:file_picker/file_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:open_file/open_file.dart';
// import 'package:share_plus/share_plus.dart';
// import 'package:path/path.dart' as path;

// void main() {
//   runApp(const PIIMaskingApp());
// }

// class PIIMaskingApp extends StatelessWidget {
//   const PIIMaskingApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
//       home: const PIIMaskingScreen(),
//     );
//   }
// }

// class PIIMaskingScreen extends StatefulWidget {
//   const PIIMaskingScreen({super.key});

//   @override
//   _PIIMaskingScreenState createState() => _PIIMaskingScreenState();
// }

// class _PIIMaskingScreenState extends State<PIIMaskingScreen> {
//   String _inputFileName = "No file selected";
//   String _statusMessage = "Waiting for file...";
//   String? _outputFilePath;
//   String? _originalFilePath; // To store the original file path
//   bool _isLoading = false;
//   final String apiUrl = "http://192.168.198.23:5000/mask";

//   Future<void> _pickFileAndMask() async {
//     try {
//       FilePickerResult? result = await FilePicker.platform.pickFiles(
//         type: FileType.custom,
//         allowedExtensions: ['txt'],
//       );

//       if (result == null || result.files.single.path == null) {
//         setState(() {
//           _statusMessage = "No file selected";
//         });
//         return;
//       }

//       String fullPath = result.files.single.path!;
//       setState(() {
//         _inputFileName = path.basename(fullPath);
//         _originalFilePath = fullPath; // Store the original file path
//         _isLoading = true;
//         _statusMessage = "Processing...";
//       });

//       String fileContent = await File(fullPath).readAsString();

//       var response = await http.post(
//         Uri.parse(apiUrl),
//         headers: {"Content-Type": "application/json"},
//         body: jsonEncode({"text": fileContent}),
//       );

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(response.body);
//         String maskedText = jsonResponse['masked_text'] ?? "No masked text received";

//         final directory = await getApplicationDocumentsDirectory();
//         final outputFile = File('${directory.path}/masked_${path.basenameWithoutExtension(fullPath)}_output.txt');
//         await outputFile.writeAsString(maskedText);

//         setState(() {
//           _outputFilePath = outputFile.path;
//           _statusMessage = "File processed successfully";
//           _isLoading = false;
//         });
//       } else {
//         setState(() {
//           _statusMessage = "API Error: ${response.statusCode}";
//           _isLoading = false;
//         });
//       }
//     } catch (e) {
//       setState(() {
//         _statusMessage = "Error: $e";
//         _isLoading = false;
//       });
//     }
//   }

//   void _openOriginalFile() {
//     if (_originalFilePath != null) {
//       OpenFile.open(_originalFilePath!);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("No original file available")),
//       );
//     }
//   }

//   void _openOutputFile() {
//     if (_outputFilePath != null) {
//       OpenFile.open(_outputFilePath!);
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("No output file available")),
//       );
//     }
//   }

//   void _shareOutputFile() {
//     if (_outputFilePath != null) {
//       Share.shareFiles([_outputFilePath!], text: 'Here is your PII-masked file');
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("No output file available")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Container(
//         decoration: const BoxDecoration(
//           gradient: LinearGradient(
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             colors: [Colors.blue, Colors.white],
//           ),
//         ),
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black),
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.white.withOpacity(0.8),
//                     ),
//                     child: Text(
//                       "Selected File: $_inputFileName",
//                       style: const TextStyle(color: Colors.black),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   ElevatedButton(
//                     onPressed: _isLoading ? null : _pickFileAndMask,
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blue,
//                       foregroundColor: Colors.white,
//                     ),
//                     child: _isLoading
//                         ? const CircularProgressIndicator(color: Colors.white)
//                         : const Text("Select File & Mask PII"),
//                   ),
//                   const SizedBox(height: 20),
//                   Container(
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.black),
//                       borderRadius: BorderRadius.circular(8),
//                       color: Colors.white.withOpacity(0.8),
//                     ),
//                     child: Text(
//                       _statusMessage,
//                       style: const TextStyle(fontSize: 16, color: Colors.black),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                   if (_originalFilePath != null || _outputFilePath != null) ...[
//                     ElevatedButton(
//                       onPressed: _openOriginalFile,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                       ),
//                       child: const Text("View Original File"),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: _openOutputFile,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.blue,
//                         foregroundColor: Colors.white,
//                       ),
//                       child: const Text("View Masked File"),
//                     ),
//                     const SizedBox(height: 10),
//                     ElevatedButton(
//                       onPressed: _shareOutputFile,
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color.fromARGB(255, 100, 243, 33),
//                         foregroundColor: Colors.white,
//                       ),
//                       child: const Text("Share Masked File"),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path/path.dart' as path;

void main() {
  runApp(const PIIMaskingApp());
}

class PIIMaskingApp extends StatelessWidget {
  const PIIMaskingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.transparent),
      home: const PIIMaskingScreen(),
    );
  }
}

class PIIMaskingScreen extends StatefulWidget {
  const PIIMaskingScreen({super.key});

  @override
  _PIIMaskingScreenState createState() => _PIIMaskingScreenState();
}

class _PIIMaskingScreenState extends State<PIIMaskingScreen> {
  String _inputFileName = "No file selected";
  String _statusMessage = "Waiting for file...";
  String? _outputFilePath;
  String? _originalFilePath;
  bool _isLoading = false;
  final String apiUrl = "http://192.168.59.23:5000/mask";

  Future<void> _pickFileAndMask() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['txt'],
      );

      if (result == null || result.files.single.path == null) {
        setState(() {
          _statusMessage = "No file selected";
        });
        return;
      }

      String fullPath = result.files.single.path!;
      setState(() {
        _inputFileName = path.basename(fullPath);
        _originalFilePath = fullPath;
        _isLoading = true;
        _statusMessage = "Processing...";
      });

      String fileContent = await File(fullPath).readAsString();

      var response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode({"text": fileContent}),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        String maskedText = jsonResponse['masked_text'] ?? "No masked text received";

        final directory = await getApplicationDocumentsDirectory();
        final outputFile = File('${directory.path}/masked_${path.basenameWithoutExtension(fullPath)}_output.txt');
        
        // Combine original and masked content with spacing
        String combinedContent = "Original Content:\n\n$fileContent\n\n\n"
            "Masked Content:\n\n$maskedText";
        await outputFile.writeAsString(combinedContent);

        setState(() {
          _outputFilePath = outputFile.path;
          _statusMessage = "File processed successfully";
          _isLoading = false;
        });
      } else {
        setState(() {
          _statusMessage = "API Error: ${response.statusCode}";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _statusMessage = "Error: $e";
        _isLoading = false;
      });
    }
  }

  void _openOriginalFile() {
    if (_originalFilePath != null) {
      OpenFile.open(_originalFilePath!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No original file available")),
      );
    }
  }

  void _openOutputFile() {
    if (_outputFilePath != null) {
      OpenFile.open(_outputFilePath!);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No output file available")),
      );
    }
  }

  void _shareOutputFile() {
    if (_outputFilePath != null) {
      Share.shareFiles([_outputFilePath!], text: 'Here is your PII-masked file');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("No output file available")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.white],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: Text(
                      "Selected File: $_inputFileName",
                      style: const TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _isLoading ? null : _pickFileAndMask,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white,
                    ),
                    child: _isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text("Select File & Mask PII"),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: Text(
                      _statusMessage,
                      style: const TextStyle(fontSize: 16, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 20),
                  if (_originalFilePath != null || _outputFilePath != null) ...[
                    ElevatedButton(
                      onPressed: _openOriginalFile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("View Original File"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _openOutputFile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("View Combined File"),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: _shareOutputFile,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Share Combined File"),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
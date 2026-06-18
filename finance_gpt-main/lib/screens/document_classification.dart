// import 'dart:convert';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:http/http.dart' as http;

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: ImageClassificationScreen(),
//     );
//   }
// }

// class ImageClassificationScreen extends StatefulWidget {
//   const ImageClassificationScreen({super.key});

//   @override
//   _ImageClassificationScreenState createState() =>
//       _ImageClassificationScreenState();
// }

// class _ImageClassificationScreenState extends State<ImageClassificationScreen> {
//   File? _image;
//   String _prediction = "No image selected";

//   Future<void> _pickImage() async {
//     final pickedFile = await ImagePicker().pickImage(
//       source: ImageSource.gallery,
//     );
//     if (pickedFile != null) {
//       setState(() {
//         _image = File(pickedFile.path);
//         _prediction = "Processing...";
//       });
//       _classifyImage(_image!);
//     }
//   }

//   Future<void> _classifyImage(File image) async {
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse("http://192.168.195.23:4000/predict"), // FastAPI endpoint
//     );
//     request.files.add(await http.MultipartFile.fromPath('image', image.path));

//     try {
//       var response = await request.send();
//       var responseData = await response.stream.bytesToString();
//       print("🖥 Server Response: $responseData"); // Debugging log

//       if (response.statusCode == 200) {
//         var jsonResponse = jsonDecode(responseData);
//         print("✅ Model connected successfully!"); // Log when model is connected
//         setState(() {
//           _prediction =
//               " Predicted Class : ${jsonResponse['predicted_class']} ";
//         });
//       } else {
//         setState(() {
//           _prediction = "Error: Failed to classify image";
//         });
//       }
//     } catch (e) {
//       print("❌ Error sending image: $e");
//       setState(() {
//         _prediction = "Error: $e";
//       });
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("ViT Image Classification")),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _image == null
//                 ? Text("Select an image")
//                 : Image.file(_image!, height: 200),
//             SizedBox(height: 20),
//             Text(
//               _prediction,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 20),
//             ElevatedButton(onPressed: _pickImage, child: Text("Select Image")),
//           ],
//         ),
//       ),
//     );
//   }
// }


import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const ImageClassificationApp());
}

class ImageClassificationApp extends StatelessWidget {
  const ImageClassificationApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const ImageClassificationScreen(),
    );
  }
}

class ImageClassificationScreen extends StatefulWidget {
  const ImageClassificationScreen({super.key});

  @override
  _ImageClassificationScreenState createState() => _ImageClassificationScreenState();
}

class _ImageClassificationScreenState extends State<ImageClassificationScreen> {
  File? _image;
  String _prediction = "No image selected";
  bool _isLoading = false;
  final String apiUrl = "http://192.168.59.23:5000/classify"; // Update with your Flask server IP

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
        _prediction = "Processing...";
        _isLoading = true;
      });
      await _classifyImage(_image!);
    }
  }

  Future<void> _classifyImage(File image) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
      request.files.add(await http.MultipartFile.fromPath('image', image.path));
      var response = await request.send();
      var responseData = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(responseData);
        setState(() {
          _prediction = "Predicted Class: ${jsonResponse['predicted_class']}";
          _isLoading = false;
        });
      } else {
        setState(() {
          _prediction = "Error: Failed to classify image";
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _prediction = "Error: $e";
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Image Classification")),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _image == null
                  ? const Text("Select an image to classify")
                  : Image.file(_image!, height: 200, fit: BoxFit.cover),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : Text(
                      _prediction,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _isLoading ? null : _pickImage,
                child: const Text("Select Image"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
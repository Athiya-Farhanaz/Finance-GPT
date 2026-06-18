import 'dart:math';
import 'package:flutter/material.dart';
import 'twilio_service.dart'; // Ensure you have this service implemented

class PhoneVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  const PhoneVerificationScreen({Key? key, required this.phoneNumber}) : super(key: key);

  @override
  _PhoneVerificationScreenState createState() => _PhoneVerificationScreenState();
}

class _PhoneVerificationScreenState extends State<PhoneVerificationScreen> {
  final TextEditingController otpController = TextEditingController();
  String generatedOtp = "";
  final TwilioService twilioService = TwilioService();

  @override
  void initState() {
    super.initState();
    _sendOtp(); // Send OTP when the screen loads
  }

  /// Sends OTP using Twilio
  void _sendOtp() async {
    final random = Random();
    generatedOtp = (100000 + random.nextInt(900000)).toString();
    bool otpSent = await twilioService.sendOtp(widget.phoneNumber, generatedOtp);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(otpSent ? "OTP sent to ${widget.phoneNumber}" : "Failed to send OTP. Try again."),
        ),
      );
    });
  }

  /// Verifies the entered OTP
  void _verifyOtp() {
    if (otpController.text.trim() == generatedOtp) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Phone verified successfully!")),
        );
      });
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Invalid OTP, try again.")),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.black, Color.fromARGB(255, 183, 58, 73)],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Enter OTP sent to your phone",
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: otpController,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: const InputDecoration(
                  labelText: "Enter OTP",
                  labelStyle: TextStyle(color: Colors.white),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
                  focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.yellow)),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _verifyOtp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
                child: const Text("Verify OTP"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

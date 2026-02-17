import 'package:flutter/material.dart';
import 'package:logbook_app_084/features/auth/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> { 
  int _step = 1;

  final List<String> _desc = [
    "Selamat Datang di Logbook App!",
    "Catat setiap aktivitasmu dengan mudah.",
    "Data aman dan terorganisir dengan rapi."
  ];

  void _nextStep() {
    setState(() {
      if (_step < 3) {
        _step++;  
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginView()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$_step",
                style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              const SizedBox(height: 20),
              Text(
                _desc[_step - 1],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 50),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _nextStep,
                  child: Text(_step < 3 ? "Lanjut" : "Mulai Sekarang"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
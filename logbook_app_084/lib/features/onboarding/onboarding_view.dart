import 'package:flutter/material.dart';
// Import LoginView agar bisa berpindah halaman setelah onboarding selesai
import 'package:logbook_app_084/features/auth/login_view.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  // Variabel int step = 1 sesuai konsep Modul 2 
  int _step = 1;

  // List gambar atau teks untuk konten onboarding (Homework Enhancement)
  final List<String> _desc = [
    "Selamat Datang di Logbook App!",
    "Catat setiap aktivitasmu dengan mudah.",
    "Data aman dan terorganisir dengan rapi."
  ];

  void _nextStep() {
    setState(() {
      if (_step < 3) {
        _step++; // Logika: Jika tombol ditekan, step++ 
      } else {
        // Logika: Jika step > 3, pindah ke LoginView [cite: 90]
        // Menggunakan pushReplacement agar user tidak bisa kembali ke onboarding 
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
              // Menampilkan Angka Step (Bisa diganti gambar untuk Homework) [cite: 328, 386]
              Text(
                "$_step",
                style: const TextStyle(fontSize: 100, fontWeight: FontWeight.bold, color: Colors.indigo),
              ),
              const SizedBox(height: 20),
              // Menampilkan deskripsi berdasarkan step saat ini
              Text(
                _desc[_step - 1],
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 50),
              // Tombol "Lanjut" atau "Next" [cite: 292, 293]
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
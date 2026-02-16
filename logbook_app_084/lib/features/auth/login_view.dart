import 'dart:async'; 
import 'package:flutter/material.dart';
import 'login_controller.dart';
import '../logbook/counter_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final LoginController _controller = LoginController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  bool _isObscure = true; 
  bool _isBtnDisabled = false;  

  void _handleLogin() {
    String user = _userController.text;
    String pass = _passController.text;

    if (user.isEmpty || pass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Username dan Password tidak boleh kosong!")),
      );
      return;
    }

    if (_controller.login(user, pass)) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => CounterView(username: user)),
      );
    } else {
      if (_controller.isLocked) {
        setState(() => _isBtnDisabled = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Salah 3x! Tombol mati 10 detik.")),
        );
                Timer(const Duration(seconds: 10), () {
          setState(() {
            _isBtnDisabled = false;
            _controller.resetSalahLog();
          });
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Gagal! Akun salah.")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login Portal")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(controller: _userController, decoration: const InputDecoration(labelText: "Username")),
            TextField(
              controller: _passController,
              obscureText: _isObscure, 
              decoration: InputDecoration(
                labelText: "Password",
                suffixIcon: IconButton(
                  icon: Icon(_isObscure ? Icons.visibility_off : Icons.visibility),
                  onPressed: () => setState(() => _isObscure = !_isObscure),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isBtnDisabled ? null : _handleLogin,  
              child: Text(_isBtnDisabled ? "Terkunci (10s)" : "Masuk"),
            ),
          ],
        ),
      ),
    );
  }
}
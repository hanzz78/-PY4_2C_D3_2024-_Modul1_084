import 'package:flutter/material.dart';
import 'counter_view.dart'; // Mengarahkan ke file tampilan

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Counter_View(),
  ));
}
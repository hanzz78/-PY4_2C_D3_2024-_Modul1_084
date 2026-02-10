import 'package:flutter/material.dart';
import 'counter_controller.dart';

class Counter_View extends StatefulWidget {
  const Counter_View({super.key});

  @override
  State<Counter_View> createState() => _CounterViewState();
}

class _CounterViewState extends State<Counter_View> {
  final Counter_Controller _controller = Counter_Controller();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 1: Multi-Step Counter")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Nilai Counter:"),
            Text(
              '${_controller.value}',
              style: const TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            TextField(
              decoration: const InputDecoration(
                labelText: "Nilai Step",
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _controller.setStep(int.tryParse(value) ?? 1);
                });
              },
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _controller.decrement()),
                  child: const Text("-"),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _controller.reset()),
                  child: const Text("Reset"),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _controller.increment()),
                  child: const Text("+"),
                ),
              ],
            ),
          ],
        ),
        
      ),
    );
  }
}
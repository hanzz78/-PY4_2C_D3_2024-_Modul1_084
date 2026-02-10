import 'package:flutter/material.dart';
import 'counter_controller.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Task 2: Counter with History")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            TextField(
              decoration: const InputDecoration(labelText: "Nilai Step"),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _controller.setStep(int.tryParse(value) ?? 1);
                });
              },
            ),
            const SizedBox(height: 20),
            
            
            const Text("Total:"),
            Text(
              '${_controller.value}',
              style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),

            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() => _controller.decrement()),
                  child: const Text("-"),
                ),
                ElevatedButton(
                  onPressed: () => setState(() => _controller.increment()),
                  child: const Text("+"),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {
                setState(() => _controller.reset());
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Riwayat di-reset")),
                );
              },
              child: const Text("Reset"),
            ),
            
            const Divider(),
            const Text("Riwayat :", style: TextStyle(fontWeight: FontWeight.bold)),
            
           
            Expanded(
              child: ListView.builder(
                itemCount: _controller.history.length,
                itemBuilder: (context, index) {
                  return Text(_controller.history[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
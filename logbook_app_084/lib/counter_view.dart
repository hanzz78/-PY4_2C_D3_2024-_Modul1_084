import 'package:flutter/material.dart';
import 'counter_controller.dart';

class CounterView extends StatefulWidget {
  const CounterView({super.key});
  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();

  // FUNGSI UNTUK KONFIRMASI RESET (UX Improvement)
  void _tampilkanDialogKonfirmasi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Reset"),
          content: const Text("Hapus semua hitungan dan riwayat?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), // Tutup dialog jika Batal
              child: const Text("BATAL"),
            ),
            TextButton(
              onPressed: () {
                setState(() => _controller.reset());
                Navigator.pop(context); // Tutup dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Data berhasil dibersihkan!"),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              child: const Text("YA, RESET", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Counter Pro: Task 2 & HW")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: "Nilai Step",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.input),
              ),
              keyboardType: TextInputType.number,
              onChanged: (v) => setState(() => _controller.setStep(int.tryParse(v) ?? 1)),
            ),
            const SizedBox(height: 20),
            const Text("Total Hitungan:"),
            Text(
              '${_controller.value}',
              style: TextStyle(
                fontSize: 80,
                fontWeight: FontWeight.bold,
                color: _controller.value % 2 == 0 ? Colors.blue : Colors.red,
              ),
            ),
            const Divider(thickness: 2),
            const Text("5 Riwayat Terakhir:", style: TextStyle(fontWeight: FontWeight.bold)),
            
            // LISTVIEW DENGAN WARNA (UI Polishing)
            Expanded(
              child: ListView.builder(
                itemCount: _controller.history.length,
                itemBuilder: (context, index) {
                  String item = _controller.history[index];
                  Color warnaTeks = Colors.black;

                  if (item.startsWith("TAMBAH")) warnaTeks = Colors.green;
                  if (item.startsWith("KURANG")) warnaTeks = Colors.red;

                  return ListTile(
                    leading: Icon(Icons.circle, color: warnaTeks, size: 12),
                    title: Text(
                      item
                          .replaceFirst("TAMBAH: ", "")
                          .replaceFirst("KURANG: ", "")
                          .replaceFirst("RESET: ", ""),
                      style: TextStyle(color: warnaTeks, fontWeight: FontWeight.w500),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text("TAMBAH"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => setState(() => _controller.increment()),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.remove),
                label: const Text("KURANG"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => setState(() => _controller.decrement()),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.refresh),
                label: const Text("RESET"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  foregroundColor: Colors.white,
                ),
                // MENGGUNAKAN DIALOG KONFIRMASI (UX Improvement)
                onPressed: _tampilkanDialogKonfirmasi, 
              ),
            ),
          ],
        ),
      ),
    );
  }
}
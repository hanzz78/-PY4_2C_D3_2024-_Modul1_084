import 'package:flutter/material.dart';
import 'counter_controller.dart';
import '../onboarding/onboarding_view.dart'; 

class CounterView extends StatefulWidget {
  final String username;
  const CounterView({super.key, required this.username});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  final CounterController _controller = CounterController();

  @override
  void initState() {
    super.initState();
    _initData(); 
  }

  void _initData() async {
    await _controller.loadData(widget.username);
    if (mounted) {
      setState(() {}); 
    }
  }

  String _getSalam() {
    int hour = DateTime.now().hour;
    if (hour >= 5 && hour < 11) return "Selamat Pagi";
    if (hour >= 11 && hour < 15) return "Selamat Siang";
    if (hour >= 15 && hour < 18) return "Selamat Sore";
    return "Selamat Malam";
  }

  void _tampilkanDialogKonfirmasi() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Reset"),
          content: const Text("Hapus semua hitungan dan riwayat?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("BATAL"),
            ),
            TextButton(
              onPressed: () {
                setState(() => _controller.reset());
                Navigator.pop(context); 
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

  void _tampilkanDialogLogout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Konfirmasi Logout"),
          content: const Text("Apakah Anda yakin ingin keluar?"), 
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context), 
              child: const Text("Batal"), 
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context); 
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const OnboardingView()), 
                  (route) => false, 
                );
              },
              child: const Text("Ya, Keluar", style: TextStyle(color: Colors.red)), 
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Logbook: ${widget.username}"),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: _tampilkanDialogLogout,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(15),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "${_getSalam()}, ${widget.username}!",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18, 
                  fontWeight: FontWeight.bold, 
                  color: Colors.blueAccent
                ),
              ),
            ),
            const SizedBox(height: 20),
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
            Expanded(
              child: ListView.builder(
                itemCount: _controller.history.length,
                itemBuilder: (context, index) {
                  String item = _controller.history[index];
                  String itemCheck = item.toLowerCase().trim();
                  Color warnaTeks = Colors.black;

                  if (itemCheck.contains("menambah")) {
                    warnaTeks = Colors.green;
                  } else if (itemCheck.contains("mengurangi")) {
                    warnaTeks = Colors.red;
                  }

                  return ListTile(
                    leading: Icon(Icons.circle, color: warnaTeks, size: 12),
                    title: Text(
                      item,
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
            _buildActionButon(
              icon: Icons.add, 
              label: "TAMBAH", 
              color: Colors.green, 
              onTap: () => setState(() => _controller.increment(widget.username))
            ),
            const SizedBox(height: 10),
            _buildActionButon(
              icon: Icons.remove, 
              label: "KURANG", 
              color: Colors.redAccent, 
              onTap: () => setState(() => _controller.decrement(widget.username))
            ),
            const SizedBox(height: 10),
            _buildActionButon(
              icon: Icons.refresh, 
              label: "RESET", 
              color: Colors.orange, 
              onTap: _tampilkanDialogKonfirmasi
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButon({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton.icon(
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
        ),
        onPressed: onTap,
      ),
    );
  }
}
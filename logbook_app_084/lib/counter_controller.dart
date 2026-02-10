class CounterController {
  int _counter = 0;
  int _step = 1;
  final List<String> _history = [];

  int get value => _counter;
  int get step => _step;
  List<String> get history => _history;

  void setStep(int newValue) {
    _step = newValue > 0 ? newValue : 1; 
  }

  
  String _getWaktu() {
    final n = DateTime.now();
    return "${n.hour.toString().padLeft(2, '0')}:${n.minute.toString().padLeft(2, '0')}:${n.second.toString().padLeft(2, '0')}";
  }

  
  void _cekBatasRiwayat() {
    if (_history.length > 5) {
      _history.removeLast();
    }
  }

  void increment() {
    _counter += _step;
    _history.insert(0, "[${_getWaktu()}] Ditambah $_step (Total: $_counter)");
    _cekBatasRiwayat();
  }

  void decrement() {
    if (_counter >= _step) {
      _counter -= _step;
      _history.insert(0, "[${_getWaktu()}] Dikurang $_step (Total: $_counter)");
    } else {
      _counter = 0;
      _history.insert(0, "[${_getWaktu()}] Reset ke 0 (Batas Bawah)");
    }
    _cekBatasRiwayat();
  }

  void reset() {
    _counter = 0;
    _history.clear();
  }
}
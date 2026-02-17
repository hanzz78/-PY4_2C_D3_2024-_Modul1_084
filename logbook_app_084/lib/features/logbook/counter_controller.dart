import 'package:shared_preferences/shared_preferences.dart';

class CounterController {
  int _counter = 0;
  int _step = 1;
  String _currentUser = "";
  final List<String> _history = [];

  int get value => _counter;
  int get step => _step;
  List<String> get history => _history;

Future<void> _saveData() async {
  if (_currentUser.isEmpty) return;
  
  final prefs = await SharedPreferences.getInstance(); 
  await prefs.setInt('${_currentUser}_last_counter', _counter); 
  await prefs.setStringList('${_currentUser}_history_log', _history); 
}
  
Future<void> loadData(String username) async {
  _currentUser = username; 
  final prefs = await SharedPreferences.getInstance();
  _counter = prefs.getInt('${_currentUser}_last_counter') ?? 0; 
  
  List<String>? savedHistory = prefs.getStringList('${_currentUser}_history_log'); 
  if (savedHistory != null) {
    _history.clear();
    _history.addAll(savedHistory);
  } else {
    _history.clear(); 
  }
}

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

void increment(String user) {
  _counter += _step;
  _history.insert(0, "User $user menambah +$_step pada jam ${_getWaktu()}");
  _cekBatasRiwayat();
  _saveData();
}

void decrement(String user) {
  if (_counter >= _step) {
    _counter -= _step;
    _history.insert(0, "User $user mengurangi -$_step pada jam ${_getWaktu()}");
  } else {
    _counter = 0;
    _history.insert(0, "Sudah mencapai batas minimum");
  }
  _cekBatasRiwayat();
  _saveData();
}

  void reset() {
    _counter = 0;
    _history.clear();
    _saveData(); 
  }
}
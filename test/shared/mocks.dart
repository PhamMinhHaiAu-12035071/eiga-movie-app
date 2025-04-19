import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

// HTTP client mocks
class MockHttpClient extends Mock implements http.Client {}

// Storage mocks
class MockLocalStorage extends Mock {
  final Map<String, dynamic> _storage = {};

  dynamic get(String key) {
    return _storage[key];
  }

  void set(String key, dynamic value) {
    _storage[key] = value;
  }

  void remove(String key) {
    _storage.remove(key);
  }

  void clear() {
    _storage.clear();
  }

  bool containsKey(String key) {
    return _storage.containsKey(key);
  }
}

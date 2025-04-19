import 'dart:io';
import 'package:path/path.dart' as p;

/// Reads and returns the content of a fixture file
///
/// The [name] should be the relative path from the fixtures folder
/// e.g. 'onboarding/slides.json'
String fixture(String name) {
  final path = p.join('test', 'shared', 'fixtures', name);
  return File(path).readAsStringSync();
}

/// Asynchronously reads and returns the content of a fixture file
///
/// The [name] should be the relative path from the fixtures folder
/// e.g. 'onboarding/slides.json'
Future<String> loadFixture(String name) async {
  final path = p.join('test', 'shared', 'fixtures', name);
  return File(path).readAsString();
}

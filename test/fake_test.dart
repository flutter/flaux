import 'dart:io';

import 'package:test/expect.dart';
import 'package:test/scaffolding.dart';
import 'package:path/path.dart' as path;

main() {
  
  String delayInSeconds = String.fromEnvironment('test_delay', defaultValue: "0.0");
  final seconds = double.parse(delayInSeconds);
  final testDelay = Duration(seconds: seconds.toInt(), milliseconds: (seconds.remainder(1) * 1000).toInt());

  tearDown(() async {
    print('waiting $testDelay');
    await Future.delayed(testDelay);
  });

  test('passes', () {
    print('this test should pass');
    expect(true, true);
  });

  test('fails if "fail.dart" present', () async {
    final dir = Directory('lib');
    if (!await dir.exists()) {
      return;
    }
    final files = await dir.list().toList();
    expect(files.any((f) {
      if (f is! File) return false;
      return path.equals('lib/fail.dart', f.path);
    }), isFalse);
  });
}

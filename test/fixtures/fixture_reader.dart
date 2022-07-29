import 'dart:io';

String readFixture(String name) {
  return File("test/fixtures/$name").readAsStringSync();
}

import 'dart:async';
import 'dart:io';
import 'package:lcov/lcov.dart';

/// Formats coverage data as LCOV report.
void formatReport() {
  var lineCoverage = LineCoverage(2, 2, [
    LineData(6, executionCount: 2, checksum: 'PF4Rz2r7RTliO9u6bZ7h6g'),
    LineData(7, executionCount: 2, checksum: 'yGMB6FhEEAd8OyASe3Ni1w')
  ]);

  var record = Record('/home/cedx/lcov.dart/fixture.dart')
    ..functions = FunctionCoverage(1, 1)
    ..lines = lineCoverage;

  var report = Report('Example', [record]);
  print(report);
}

/// Parses a LCOV report to coverage data.
Future<void> parseReport() async {
  var coverage = await File('lcov.info').readAsString();

  try {
    var report = Report.fromCoverage(coverage);
    print('The coverage report contains ${report.records.length} records:');
    print(report.toJson());
  }

  on LcovException catch (err) {
    print('An error occurred: ${err.message}');
  }
}

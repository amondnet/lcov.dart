# LCOV Reports for Dart
![Runtime](https://img.shields.io/badge/dart-%3E%3D1.24-brightgreen.svg) ![Release](https://img.shields.io/pub/v/lcov.svg) ![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg) ![Coverage](https://coveralls.io/repos/github/cedx/lcov.dart/badge.svg) ![Build](https://travis-ci.org/cedx/lcov.dart.svg)

Parse and format [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) coverage reports, in [Dart](https://www.dartlang.org).

## Requirements
The latest [Dart SDK](https://www.dartlang.org) and [Pub](https://pub.dartlang.org) versions.
If you plan to play with the sources, you will also need the latest [Grinder](http://google.github.io/grinder.dart) version.

## Installing via [Pub](https://pub.dartlang.org)

### 1. Depend on it
Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  lcov: *
```

### 2. Install it
Install this package and its dependencies from a command prompt:

```shell
$ pub get
```

### 3. Import it
Now in your [Dart](https://www.dartlang.org) code, you can use:

```dart
import 'package:lcov/lcov.dart';
```

## Usage
This package provides a set of classes representing a coverage report and its data.
The [`Report`](https://github.com/cedx/lcov.dart/blob/master/lib/src/report.dart) class, the main one, provides the parsing and formatting features.

### Parse coverage data from a [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) file
The `Report.fromCoverage()` constructor parses a coverage report provided as string, and creates a `Report` instance giving detailed information about this coverage report:

```dart
try {
  var coverage = await new File('lcov.info').readAsString();
  var report = new Report.fromCoverage(coverage);
  print('The coverage report contains ${report.records.length} records:');
  print(report.toJson());
}

on FormatException {
  print('The LCOV report has an invalid format.');
}
```

The `Report.toJson()` instance method will return a map like this:

```dart
{
  "testName": "Example",
  "records": [
    {
      "sourceFile": "/home/cedx/lcov.dart/fixture.dart",
      "branches": {
        "data": [],
        "found": 0,
        "hit": 0
      },
      "functions": {
        "data": [
          {"executionCount": 2, "functionName": "main", "lineNumber": 4}
        ],
        "found": 1,
        "hit": 1
      },
      "lines": {
        "data": [
          {"checksum": "PF4Rz2r7RTliO9u6bZ7h6g", "executionCount": 2, "lineNumber": 6},
          {"checksum": "y7GE3Y4FyXCeXcrtqgSVzw", "executionCount": 2, "lineNumber": 9}
        ],
        "found": 2,
        "hit": 2
      }
    }
  ]
}
```

### Format coverage data to the [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) format
Each provided class has a dedicated `toString()` instance method returning the corresponding data formatted as LCOV string.
All you have to do is to create the adequate structure using these different classes, and to export the final result:

```dart
var lineCoverage = new LineCoverage(2, 2, [
  new LineData(6, 2, 'PF4Rz2r7RTliO9u6bZ7h6g'),
  new LineData(7, 2, 'yGMB6FhEEAd8OyASe3Ni1w')
]);

var record = new Record('/home/cedx/lcov.dart/fixture.dart')
  ..functions = new FunctionCoverage(1, 1)
  ..lines = lineCoverage;

var report = new Report('Example', [record]);
print(report);
```

The `Report.toString()` method will return a LCOV report formatted like this:

```
TN:Example
SF:/home/cedx/lcov.dart/fixture.dart
FNF:1
FNH:1
DA:6,2,PF4Rz2r7RTliO9u6bZ7h6g
DA:7,2,yGMB6FhEEAd8OyASe3Ni1w
LF:2
LH:2
end_of_record
```

## See also
- [API reference](https://cedx.github.io/lcov.dart)
- [Code coverage](https://coveralls.io/github/cedx/lcov.dart)
- [Continuous integration](https://travis-ci.org/cedx/lcov.dart)

## License
[LCOV Reports for Dart](https://github.com/cedx/lcov.dart) is distributed under the Apache License, version 2.0.

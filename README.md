# LCOV Reports for Dart
![Release](https://img.shields.io/pub/v/lcov.svg) ![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg) ![Build](https://travis-ci.org/cedx/lcov.dart.svg)

Parse and format [LCOV](http://ltp.sourceforge.net/lcov.php) coverage reports, in [Dart](https://www.dartlang.org).

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

The main class is the [`Report`](https://github.com/cedx/lcov.dart/blob/master/lib/src/report.dart) one: it provides the parsing and formatting features of this package.

### Parse coverage data from a LCOV file

```dart
try {
  var coverage = await new File('lcov.info').readAsString();
  var report = Report.parse(coverage);
  print(report.toJson());
}

on FormatException {
  print('The LCOV report has an invalid format.');
}
```

### Format coverage data to the LCOV format

```dart
var lineCoverage = new LineCoverage(
  found: 1,
  hit: 1,
  data: [new LineData(
    executionCount: 9,
    lineNumber: 127
  )]
);

var record = new Record(
  sourceFile: '/home/cedx/lcov.dart',
  lines: lineCoverage
);

var report = new Report(
  testName: 'FooTest',
  records: [record]
);

print(report.toString());
```

## See also
- [API reference](https://cedx.github.io/lcov.dart)
- [Code coverage](https://coveralls.io/github/cedx/lcov.dart)
- [Continuous integration](https://travis-ci.org/cedx/lcov.dart)

## License
[LCOV Reports for Dart](https://github.com/cedx/lcov.dart) is distributed under the Apache License, version 2.0.

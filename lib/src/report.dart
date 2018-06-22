part of lcov;
// ignore_for_file: invariant_booleans

/// An exception caused by a parsing error.
class LcovException extends FormatException {

  /// Creates a new LCOV exception.
  LcovException(String message, [source, int offset]): super(message, source, offset);
}

/// Represents a trace file, that is a coverage report.
class Report {

  /// Creates a new report.
  Report([this.testName = '', Iterable<Record> records]): records = List<Record>.from(records ?? const <Record>[]);

  /// Parses the specified [coverage] data in [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) format.
  /// Throws a [LcovException] if a parsing error occurred.
  Report.fromCoverage(String coverage): records = [], testName = '' {
    try {
      Record record;
      for (var line in coverage.split(RegExp(r'\r?\n'))) {
        line = line.trim();
        if (line.isEmpty) continue;

        var parts = line.split(':');
        if (parts.length < 2 && parts.first != Token.endOfRecord) throw Exception('Invalid token format');

        var data = parts.skip(1).join(':').split(',');
        switch (parts.first) {
          case Token.testName:
            testName = data.first;
            break;

          case Token.sourceFile:
            record = Record(data.first)
              ..branches = BranchCoverage()
              ..functions = FunctionCoverage()
              ..lines = LineCoverage();
            break;

          case Token.functionName:
            if (data.length < 2) throw Exception('Invalid function name');
            record.functions.data.add(FunctionData(data[1], int.parse(data.first, radix: 10)));
            break;

          case Token.functionData:
            if (data.length < 2) throw Exception('Invalid function data');
            record.functions.data.firstWhere((item) => item.functionName == data[1])
              .executionCount = int.parse(data.first, radix: 10);
            break;

          case Token.functionsFound:
            record.functions.found = int.parse(data.first, radix: 10);
            break;

          case Token.functionsHit:
            record.functions.hit = int.parse(data.first, radix: 10);
            break;

          case Token.branchData:
            if (data.length < 4) throw Exception('Invalid branch data');
            record.branches.data.add(BranchData(
              int.parse(data[0], radix: 10),
              int.parse(data[1], radix: 10),
              int.parse(data[2], radix: 10),
              taken: data[3] == '-' ? 0 : int.parse(data[3], radix: 10)
            ));
            break;

          case Token.branchesFound:
            record.branches.found = int.parse(data.first, radix: 10);
            break;

          case Token.branchesHit:
            record.branches.hit = int.parse(data.first, radix: 10);
            break;

          case Token.lineData:
            if (data.length < 2) throw Exception('Invalid line data');
            record.lines.data.add(LineData(
              int.parse(data[0], radix: 10),
              executionCount: int.parse(data[1], radix: 10),
              checksum: data.length >= 3 ? data[2] : ''
            ));
            break;

          case Token.linesFound:
            record.lines.found = int.parse(data.first, radix: 10);
            break;

          case Token.linesHit:
            record.lines.hit = int.parse(data.first, radix: 10);
            break;

          case Token.endOfRecord:
            records.add(record);
            break;
        }
      }
    }

    on Exception {
      throw LcovException('The coverage data has an invalid LCOV format', coverage);
    }

    if (records.isEmpty) throw LcovException('The coverage data is empty', coverage);
  }

  /// Creates a new record from the specified [map] in JSON format.
  Report.fromJson(Map<String, dynamic> map):
    records = map['records'] is List<Map<String, dynamic>> ? map['records'].map((item) => Record.fromJson(item)).cast<Record>().toList() : <Record>[],
    testName = map['testName'] is String ? map['testName'] : '';

  /// The record list.
  final List<Record> records;

  /// The test name.
  String testName;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => <String, dynamic>{
    'testName': testName,
    'records': records.map((item) => item.toJson()).toList()
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var buffer = StringBuffer();
    if (testName.isNotEmpty) {
      buffer.write('${Token.testName}:$testName');
      if (records.isNotEmpty) buffer.writeln();
    }

    buffer.writeAll(records, '\n');
    return buffer.toString();
  }
}

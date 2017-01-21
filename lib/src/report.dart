part of lcov;

/// Represents a trace file, that is a coverage report.
class Report {

  /// Creates a new report.
  Report();

  /// Creates a new record from the specified [map] in JSON format.
  Report.fromJson(Map<String, dynamic> map) {
    if (map['records'] is List<Map<String, dynamic>>) records.addAll(map['records'].map((item) => new Record.fromJson(item)));
    if (map['testName'] is String) testName = map['testName'];
  }

  /// The record list.
  final List<Record> records = [];

  /// The test name.
  String testName = '';

  /// Parses the specified [coverage] data in [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) format.
  /// Throws a [FormatException] if a parsing error occurred.
  static Report parse(String coverage) {
    assert(coverage != null);
    var report = new Report();

    try {
      var record = new Record()
        ..branches = new BranchCoverage()
        ..functions = new FunctionCoverage()
        ..lines = new LineCoverage();

      for (var line in coverage.split(new RegExp(r'\r?\n'))) {
        line = line.trim();
        if (line.isEmpty) continue;

        var parts = line.split(':');
        if (parts.length < 2 && parts.first != Token.endOfRecord) throw new Exception('Invalid token format.');

        var data = parts.skip(1).join(':').split(',');
        switch (parts.first) {
          case Token.testName:
            report.testName = data.first;
            break;

          case Token.sourceFile:
            record.sourceFile = data.first;
            break;

          case Token.functionName:
            if (data.length < 2) throw new Exception('Invalid function name.');
            record.functions.data.add(new FunctionData()
              ..functionName = data[1]
              ..lineNumber = int.parse(data.first, radix: 10));
            break;

          case Token.functionData:
            if (data.length < 2) throw new Exception('Invalid function data.');
            var functionData = record.functions.data.firstWhere((item) => item.functionName == data[1]);
            functionData.executionCount = int.parse(data.first, radix: 10);
            break;

          case Token.functionsFound:
            record.functions.found = int.parse(data.first, radix: 10);
            break;

          case Token.functionsHit:
            record.functions.hit = int.parse(data.first, radix: 10);
            break;

          case Token.branchData:
            if (data.length < 4) throw new Exception('Invalid branch data.');
            record.branches.data.add(new BranchData()
              ..lineNumber = int.parse(data[0], radix: 10)
              ..blockNumber = int.parse(data[1], radix: 10)
              ..branchNumber = int.parse(data[2], radix: 10)
              ..taken = data[3] == '-' ? 0 : int.parse(data[3], radix: 10));
            break;

          case Token.branchesFound:
            record.branches.found = int.parse(data.first, radix: 10);
            break;

          case Token.branchesHit:
            record.branches.hit = int.parse(data.first, radix: 10);
            break;

          case Token.lineData:
            if (data.length < 3) throw new Exception('Invalid line data.');
            record.lines.data.add(new LineData()
              ..lineNumber = int.parse(data[0], radix: 10)
              ..executionCount = int.parse(data[1], radix: 10)
              ..checksum = data.length >= 3 ? data[2] : '');
            break;

          case Token.linesFound:
            record.lines.found = int.parse(data.first, radix: 10);
            break;

          case Token.linesHit:
            record.lines.hit = int.parse(data.first, radix: 10);
            break;

          case Token.endOfRecord:
            report.records.add(record);
            record = new Record()
              ..branches = new BranchCoverage()
              ..functions = new FunctionCoverage()
              ..lines = new LineCoverage();
            break;
        }
      }
    }

    catch (e) {
      throw new FormatException('The coverage data has an invalid LCOV format.', coverage);
    }

    if (report.records.isEmpty) throw new FormatException('The coverage data is empty.', coverage);
    return report;
  }

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'testName': testName,
    'records': records.map((item) => item.toJson()).toList()
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var buffer = new StringBuffer('${Token.testName}:$testName');
    if (records.isNotEmpty) buffer..writeln()..writeAll(records, '\n');
    return buffer.toString();
  }
}

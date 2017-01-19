part of lcov;

/// Represents a trace file, that is a coverage report.
class Report {

  /// Creates a new report.
  Report({List<Record> records, this.testName}): records = records ?? [];

  /// Creates a new record from the specified [map] in JSON format.
  Report.fromJson(Map<String, dynamic> map):
    records = map['records'] is List<Map<String, dynamic>> ? map['records'].map((item) => new Record.fromJson(item)).toList() : [],
    testName = map['testName']?.toString();

  /// The record list.
  final List<Record> records;

  /// The test name.
  String testName;

  /// Parses the specified [coverage] data in [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) format.
  /// Throws a [FormatException] if a parsing error occurred.
  static Report parse(String coverage) {
    assert(coverage != null);
    var report = new Report();

    try {
      var record = new Record(
        branches: new BranchCoverage(),
        functions: new FunctionCoverage(),
        lines: new LineCoverage()
      );

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
            record.functions.data.add(new FunctionData(
              functionName: data[1],
              lineNumber: int.parse(data.first)
            ));
            break;

          case Token.functionData:
            if (data.length < 2) throw new Exception('Invalid function data.');
            var functionData = record.functions.data.firstWhere((item) => item.functionName == data[1]);
            functionData.executionCount = int.parse(data.first);
            break;

          case Token.functionsFound:
            record.functions.found = int.parse(data.first);
            break;

          case Token.functionsHit:
            record.functions.hit = int.parse(data.first);
            break;

          case Token.branchData:
            if (data.length < 4) throw new Exception('Invalid branch data.');
            record.branches.data.add(new BranchData(
              lineNumber: int.parse(data[0]),
              blockNumber: int.parse(data[1]),
              branchNumber: int.parse(data[2]),
              taken: data[3] == '-' ? 0 : int.parse(data[3])
            ));
            break;

          case Token.branchesFound:
            record.branches.found = int.parse(data.first);
            break;

          case Token.branchesHit:
            record.branches.hit = int.parse(data.first);
            break;

          case Token.lineData:
            if (data.length < 3) throw new Exception('Invalid line data.');
            record.lines.data.add(new LineData(
              lineNumber: int.parse(data[0]),
              executionCount: int.parse(data[1]),
              checksum: data.length >= 3 ? data[2] : null
            ));
            break;

          case Token.linesFound:
            record.lines.found = int.parse(data.first);
            break;

          case Token.linesHit:
            record.lines.hit = int.parse(data.first);
            break;

          case Token.endOfRecord:
            report.records.add(record);
            record = new Record(
              branches: new BranchCoverage(),
              functions: new FunctionCoverage(),
              lines: new LineCoverage()
            );
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

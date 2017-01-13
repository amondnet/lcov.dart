part of lcov;

/// Parses the specified coverage data in [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) format,
/// and returns the parsing result as a [Report].
///
/// Throws a [FormatException] if a parsing error occurred.
Future<Report> parse(String coverage) async {
  var report = new Report();
  var record = new Record(
    branches: new BranchCoverage(),
    functions: new FunctionCoverage(),
    lines: new LineCoverage()
  );

  try {
    for(var line in coverage.split(new RegExp(r'\r?\n'))) {
      var parts = line.trim().split(':');
      var data = parts.sublist(1).join(':').split(',');

      switch (parts[0].toUpperCase()) {
        case Token.testName:
          report.testName = data[0];
          break;

        case Token.sourceFile:
          record.sourceFile = data[0];
          break;

        case Token.functionName:
          record.functions.data.add(new FunctionData(
            functionName: data[1],
            lineNumber: int.parse(data[0])
          ));
          break;

        case Token.functionData:
          var functionData = record.functions.data.firstWhere((functionData) => functionData.functionName == data[1]);
          functionData.executionCount = int.parse(data[0]);
          break;

        case Token.functionsFound:
          record.functions.found = int.parse(data[0]);
          break;

        case Token.functionsHit:
          record.functions.hit = int.parse(data[0]);
          break;

        case Token.branchData:
          record.branches.data.add(new BranchData(
            lineNumber: int.parse(data[0]),
            blockNumber: int.parse(data[1]),
            branchNumber: int.parse(data[2]),
            taken: data[3] == '-' ? 0 : int.parse(data[3])
          ));
          break;

        case Token.branchesFound:
          record.branches.found = int.parse(data[0]);
          break;

        case Token.branchesHit:
          record.branches.hit = int.parse(data[0]);
          break;

        case Token.lineData:
          record.lines.data.add(new LineData(
            lineNumber: int.parse(data[0]),
            executionCount: int.parse(data[1]),
            checksum: data.length >= 3 ? data[2] : null
          ));
          break;

        case Token.linesFound:
          record.lines.found = int.parse(data[0]);
          break;

        case Token.linesHit:
          record.lines.hit = int.parse(data[0]);
          break;

        case Token.endOfRecord:
          report.records.add(record);
          record = new Record();
          break;
      }
    }
  }

  catch (e) {
    throw new FormatException('The coverage data has an invalid LCOV format.', coverage);
  }

  return report;
}

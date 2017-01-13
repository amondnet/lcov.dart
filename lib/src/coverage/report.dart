part of lcov;

/// Represents a trace file, that is a coverage report.
class Report {

  /// Creates a new report.
  Report({this.records = const [], this.testName});

  /// Creates a new record from the specified [map] in JSON format.
  Report.fromJson(Map<String, dynamic> map):
    records = map['records'] is List<Map<String, dynamic>> ? map['records'].map((item) => new Record.fromJson(item)).toList() : [],
    testName = map['test']?.toString();

  /// The record list.
  List<Record> records;

  /// The test name.
  String testName;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'test': testName,
    'records': records
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var buffer = new StringBuffer('${Token.testName}:$testName');
    if (records != null && records.isNotEmpty) buffer..writeln()..writeAll(records, '\n');
    return buffer.toString();
  }
}

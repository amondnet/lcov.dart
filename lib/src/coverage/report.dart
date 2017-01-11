part of lcov;

/// Represents a trace file, that is a coverage report.
class Report {

  /// Creates a new report.
  Report({this.records = const [], this.testName});

  /// Creates a new record from the specified [map] in JSON format.
  Report.fromJson(Map<String, dynamic> map):
    records = map['records'] is List<Map<String, dynamic>> ? map['records'].map((item) => new Record.fromJson(item)).toList() : [],
    testName = map['test'] != null ? map['test'].toString() : null;

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
    var lines = ['${Token.testName}:$testName'];
    if (records != null) lines.addAll(records.map((item) => item.toString()));
    return lines.join('\n');
  }
}

part of lcov;

/// Represents a trace file, that is a coverage report.
class Report {

  /// Creates a new report.
  Report([this.testName]);

  /// Creates a new record from the specified [map] in JSON format.
  Report.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    testName = map['testName'] != null ? map['testName'].toString() : null;

    var items = map['records'] as List<Map<String, dynamic>>;
    if (items != null) records = items.map((map) => new Record.fromJson(map)).toList();
  }

  /// The record list.
  List<Record> records = [];

  /// The test name.
  String testName;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'records': records,
    'testName': testName,
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var lines = ['${Token.testName}:$testName'];
    if (records != null) lines.addAll(records.map((item) => item.toString()));
    return lines.join('\n');
  }
}

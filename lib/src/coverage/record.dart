part of lcov;

/// Provides the coverage data of a source file.
class Record {

  /// Creates a new record.
  Record([this.sourceFile]);

  /// Creates a new record from the specified [map] in JSON format.
  Record.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    branches = map['branches'] is List<Map> ? map['branches'].map((item) => new BranchCoverage.fromJson(item)).toList() : [];
    functions = map['functions'] is List<Map> ? map['functions'].map((item) => new FunctionCoverage.fromJson(item)).toList() : [];
    lines = map['lines'] is List<Map> ? map['lines'].map((item) => new LineCoverage.fromJson(item)).toList() : [];
    sourceFile = map['file'] != null ? map['file'].toString() : null;
  }

  /// The branch coverage.
  BranchCoverage branches = new BranchCoverage();

  /// The function coverage.
  FunctionCoverage functions = new FunctionCoverage();

  /// The line coverage.
  LineCoverage lines = new LineCoverage();

  /// The path to the source file.
  String sourceFile;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'file': sourceFile,
    'branches': branches.toJson(),
    'functions': functions.toJson(),
    'lines': lines.toJson()
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var output = ['${Token.sourceFile}:$sourceFile'];
    if (functions != null) output.add(functions.toString());
    if (branches != null) output.add(branches.toString());
    if (lines != null) output.add(lines.toString());
    output.add(Token.endOfRecord);
    return output.join('\n');
  }
}

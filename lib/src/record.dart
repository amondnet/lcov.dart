part of lcov;

/// Provides the coverage data of a source file.
class Record {

  /// Creates a new record.
  Record({this.branches, this.functions, this.lines, this.sourceFile});

  /// Creates a new record from the specified [map] in JSON format.
  Record.fromJson(Map<String, dynamic> map):
    branches = map['branches'] is Map<String, dynamic> ? new BranchCoverage.fromJson(map['branches']) : null,
    functions = map['functions'] is Map<String, dynamic> ? new FunctionCoverage.fromJson(map['functions']) : null,
    lines = map['lines'] is Map<String, dynamic> ? new LineCoverage.fromJson(map['lines']) : null,
    sourceFile = map['file']?.toString();

  /// The branch coverage.
  BranchCoverage branches;

  /// The function coverage.
  FunctionCoverage functions;

  /// The line coverage.
  LineCoverage lines;

  /// The path to the source file.
  String sourceFile;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'file': sourceFile,
    'branches': branches?.toJson(),
    'functions': functions?.toJson(),
    'lines': lines?.toJson()
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var buffer = new StringBuffer('${Token.sourceFile}:$sourceFile')..writeln();
    if (functions != null) buffer.writeln(functions);
    if (branches != null) buffer.writeln(branches);
    if (lines != null) buffer.writeln(lines);
    buffer.write(Token.endOfRecord);
    return buffer.toString();
  }
}

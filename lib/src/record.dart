part of lcov;

/// Provides the coverage data of a source file.
class Record {

  /// Creates a new record with the specified source file.
  Record([this.sourceFile = '']);

  /// Creates a new record from the specified [map] in JSON format.
  Record.fromJson(Map<String, dynamic> map) {
    if (map['branches'] is Map<String, dynamic>) branches = new BranchCoverage.fromJson(map['branches']);
    if (map['functions'] is Map<String, dynamic>) functions = new FunctionCoverage.fromJson(map['functions']);
    if (map['lines'] is Map<String, dynamic>) lines = new LineCoverage.fromJson(map['lines']);
    sourceFile = map['sourceFile'] is String ? map['sourceFile'] : '';
  }

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
    'sourceFile': sourceFile,
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

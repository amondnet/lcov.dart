part of lcov;

/// Provides the coverage data of a source file.
class Record {

  /// Creates a new record.
  Record({BranchCoverage branches, FunctionCoverage functions, LineCoverage lines, this.sourceFile}):
    this.branches = branches != null ? branches : new BranchCoverage(),
    this.functions = functions != null ? functions : new FunctionCoverage(),
    this.lines = lines != null ? lines : new LineCoverage();

  /// Creates a new record from the specified [map] in JSON format.
  Record.fromJson(Map<String, dynamic> map):
    branches = map['branches'] is Map<String, dynamic> ? new BranchCoverage.fromJson(map['branches']) : null,
    functions = map['functions'] is Map<String, dynamic> ? new FunctionCoverage.fromJson(map['functions']) : null,
    lines = map['lines'] is Map<String, dynamic> ? new LineCoverage.fromJson(map['lines']) : null,
    sourceFile = map['file'] != null ? map['file'].toString() : null;

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
    'branches': branches.toJson(),
    'functions': functions.toJson(),
    'lines': lines.toJson()
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    // TODO: replace by a StringBuffer
    var output = ['${Token.sourceFile}:$sourceFile'];
    if (functions != null) output.add(functions.toString());
    if (branches != null) output.add(branches.toString());
    if (lines != null) output.add(lines.toString());
    output.add(Token.endOfRecord);
    return output.join('\n');
  }
}

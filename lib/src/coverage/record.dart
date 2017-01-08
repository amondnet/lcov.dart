part of lcov;

/// Provides the coverage data of a source file.
class Record {

  /// Creates a new record.
  Record([this.sourceFile]);

  /// Creates a new record from the specified [map] in JSON format.
  Record.fromJson(Map<String, dynamic> map) {
    assert(map != null);
    /*
    if (map['branches'] is List<Map>) branches = map['branches'];
    if (map['functions'] is List<Map>) functions = map['functions'];
    if (map['lines'] is List<Map>) lines = map['lines'];
    */
    sourceFile = map['sourceFile'] != null ? map['sourceFile'].toString() : null;
/*
    var items = map['branches'] as List<Map<String, dynamic>>;
    if (items != null) branches = items.map((map) => new Coverage.fromJson(map)).toList();*/
  }

  /// The branch coverage.
  BranchCoverage branches = new BranchCoverage();

  /// The function coverage.
  FunctionCoverage functions = new FunctionCoverage();

  /// The statement coverage.
  LineCoverage lines = new LineCoverage();

  /// The path to the source file.
  String sourceFile;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'branches': branches.toJson(),
    'functions': functions.toJson(),
    'lines': lines.toJson(),
    'sourceFile': sourceFile
  };

  /// Returns a string representation of this object.
  @override
  String toString() {
    var lines = ['${Token.sourceFile}:$sourceFile'];
    if (functions != null) lines.add(functions.toString());
    if (branches != null) lines.add(branches.toString());
    if (lines != null) lines.add(lines.toString());
    lines.add(Token.endOfRecord);
    return lines.join('\n');
  }
}

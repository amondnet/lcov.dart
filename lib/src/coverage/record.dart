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
    if (map['sourceFile'] != null) sourceFile = map['sourceFile'].toString();
/*
    var items = map['branches'] as List<Map<String, dynamic>>;
    if (items != null) branches = items.map((map) => new Coverage.fromJson(map)).toList();*/
  }

  /// The branch coverage.
  Coverage branches = new Coverage<BranchData>();

  /// The function coverage.
  Coverage functions = new Coverage<FunctionCoverage>();

  /// The statement coverage.
  Coverage lines = new Coverage<LineCoverage>();

  /// The path to the source file.
  String sourceFile;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'branches': branches,
    'functions': functions,
    'lines': lines,
    'sourceFile': sourceFile
  };

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}

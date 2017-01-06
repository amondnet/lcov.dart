part of lcov;

/*
class Function {

  int executionCount;

  List branches;

  List lines;
}
*/

/*
class Source {

  List<Function> functions;
}
*/

/// TODO Represents... a source file?
class Record {

  /// The branch coverage.
  Coverage branches = new Coverage();

  /// The function coverage.
  Coverage functions = new Coverage();

  /// The statement coverage.
  Coverage lines = new Coverage();

  /// Converts this object to a map in JSON format.
  Map<String, Map> toJson() => {
    'branches': branches.toJson(),
    'functions': functions.toJson(),
    'lines': lines.toJson()
  };

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}

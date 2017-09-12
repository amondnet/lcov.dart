part of lcov;

/// Provides details for function coverage.
class FunctionData {

  /// Creates a new function data.
  const FunctionData(this.functionName, this.lineNumber, this.executionCount);

  /// Creates a new function data from the specified [map] in JSON format.
  FunctionData.fromJson(Map<String, dynamic> map):
    executionCount = map['executionCount'] is int ? map['executionCount'] : 0,
    functionName = map['functionName'] is String ? map['functionName'] : '',
    lineNumber = map['lineNumber'] is int ? map['lineNumber'] : 0;

  /// The execution count.
  final int executionCount;

  /// The function name.
  final String functionName;

  /// The line number of the function start.
  final int lineNumber;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'executionCount': executionCount,
    'functionName': functionName,
    'lineNumber': lineNumber
  };

  /// Returns a string representation of this object.
  ///
  /// The [asDefinition] parameter indicates whether to return the function definition (e.g. name and line number)
  /// instead of its data (e.g. name and execution count).
  @override
  String toString({bool asDefinition = false}) {
    var token = asDefinition ? Token.functionName : Token.functionData;
    var number = asDefinition ? lineNumber : executionCount;
    return '$token:$number,$functionName';
  }
}

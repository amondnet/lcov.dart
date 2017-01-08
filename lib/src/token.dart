part of lcov;

/// See: http://ltp.sourceforge.net/coverage/lcov/geninfo.1.php
abstract class Token {

  /// The coverage data of a branch.
  static const String branchData = 'BRDA';

  /// The number of branches found.
  static const String branchesFound = 'BRF';

  /// The number of branches hit.
  static const String branchesHit = 'BRH';

  /// The end of a section.
  static const String endOfRecord = 'end_of_record';

  /// The coverage data of a function.
  static const String functionData = 'FNDA';

  /// The number of functions hit.
  static const String functionsHit = 'FRH';

  /// The number of functions found.
  static const String functionsFound = 'FRF';

  /// A function name.
  static const String functionName = 'FN';

  /// The coverage data of a line.
  static const String lineData = 'DA';

  /// The number of instrumented lines.
  static const String linesFound = 'LF';

  /// The number of lines with a non-zero execution count.
  static const String linesHit = 'LH';

  /// The path to a source file.
  static const String sourceFile = 'SF';

  /// A test name.
  static const String testName = 'TN';
}

part of lcov;

/// See: http://ltp.sourceforge.net/coverage/lcov/geninfo.1.php
abstract class Tokens {

  /// Absolute path to the source file.
  static const String sourceFile = 'SF';

  /// Test name.
  static const String testName = 'TN';

  /// Function name.
  static const String functioName = 'FN';

  /// Ends a section.
  static const String endOfRecord = 'end_of_record';

  /// Number of instrumented lines.
  static const String linesFound = 'LF';

  /// Number of lines with a non-zero execution count.
  static const String linesHit = 'LH';

  /// Number of branches hit.
  static const String branchesHit = 'BRH';

  /// Number of branches found.
  static const String branchesFound = 'BRF';

  /// Number of functions hit.
  static const String functionsHit = 'FRH';

  /// Number of functions found.
  static const String functionsFound = 'FRF';

  ///
  static const String branchesData = 'BRDA';

  ///
  static const String functionsData = 'FNDA';

  ///
  static const String LinesData = 'DA';
}

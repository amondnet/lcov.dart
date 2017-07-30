import 'branch_coverage_test.dart' as branch_coverage_test;
import 'branch_data_test.dart' as branch_data_test;
import 'function_coverage_test.dart' as function_coverage_test;
import 'function_data_test.dart' as function_data_test;
import 'line_coverage_test.dart' as line_coverage_test;
import 'line_data_test.dart' as line_data_test;
import 'record_test.dart' as record_test;
import 'report_test.dart' as report_test;

/// Tests all the features of the package.
void main() {
  branch_coverage_test.main();
  branch_data_test.main();
  function_coverage_test.main();
  function_data_test.main();
  line_coverage_test.main();
  line_data_test.main();
  record_test.main();
  report_test.main();
}

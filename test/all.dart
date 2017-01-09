import 'coverage/branch_test.dart' as branch_test;
import 'coverage/function_test.dart' as function_test;
import 'coverage/line_test.dart' as line_test;

/// Tests all the features of the package.
void main() {
  branch_test.main();
  function_test.main();
  line_test.main();
}

/// Parse and format [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) coverage reports.
library lcov;

import 'dart:async';

part 'src/formatter.dart';
part 'src/parser.dart';
part 'src/token.dart';
part 'src/coverage/branch.dart';
part 'src/coverage/function.dart';
part 'src/coverage/line.dart';
part 'src/coverage/record.dart';
part 'src/coverage/report.dart';

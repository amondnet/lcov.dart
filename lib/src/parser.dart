part of lcov;

/// Parses [LCOV](http://ltp.sourceforge.net/coverage/lcov.php) coverage reports.
class Parser {

  /// TODO
  Future<Map> parse(String coverage) {
    var report = new Report();
    var record = new Record();

    for(var line in coverage.split(new RegExp(r'\r?\n'))) {
      var parts = line.trim().split(':', 2);
    }


    /*
    Report report = [];
    Record record;

    List<String> lines = ['end_of_record'];
    lines.addAll(coverage.split(new RegExp(r'\r?\n')));
    lines.forEach((String line) {
      line = line.trim();

      if (line.contains('end_of_record')) {
        report.add(record);
        record = {
          'lines': {
            'data': [],
            'found': 0,
            'hit': 0
          },
          'functions': {
            'data': [],
            'found': 0,
            'hit': 0
          },
          'branches': {
            'data': [],
            'found': 0,
            'hit': 0
          }
        };
      }
    });*/

    return null;
  }
}

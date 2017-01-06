part of lcov;

/// TODO Represents the coverage data.
class Coverage {

  /// Creates a new coverage data.
  Coverage({this.details = const [], this.found = 0, this.hit = 0});

  /// TODO more details
  List<Map<String, int>> details;

  /// The number of statements found.
  int found;

  /// The number of statements hit.
  int hit;

  /// Converts this object to a map in JSON format.
  Map<String, dynamic> toJson() => {
    'details': details,
    'found': found,
    'hit': hit
  };

  /// Returns a string representation of this object.
  @override
  String toString() => '$runtimeType ${JSON.encode(this)}';
}

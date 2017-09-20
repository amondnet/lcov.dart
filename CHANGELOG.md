# Changelog
This file contains highlights of what changes on each version of the [LCOV Reports for Dart](https://github.com/cedx/lcov.dart) project.

## Version [3.0.0](https://github.com/cedx/lcov.dart/compare/v2.1.0...v3.0.0)
- Breaking change: changed the signature of most constructors.
- Breaking change: most properties of data classes are now `final`.

## Version [2.1.0](https://github.com/cedx/lcov.dart/compare/v2.0.1...v2.1.0)
- Changed licensing for the [MIT License](https://opensource.org/licenses/MIT).

## Version [2.0.1](https://github.com/cedx/lcov.dart/compare/v2.0.0...v2.0.1)
- Fixed a bug: a parsing error occurs when the coverage data does not include a test name.

## Version [2.0.0](https://github.com/cedx/lcov.dart/compare/v1.0.0...v2.0.0)
- Breaking change: changed the `Report.parse()` static method to the `fromCoverage` constructor.
- Breaking change: raised the required [Dart](https://www.dartlang.org) version.
- Updated the package dependencies.

## Version [1.0.0](https://github.com/cedx/lcov.dart/compare/v0.4.0...v1.0.0)
- First stable release.

## Version [0.4.0](https://github.com/cedx/lcov.dart/compare/v0.3.1...v0.4.0)
- Breaking change: raised the required [Dart](https://www.dartlang.org) version.
- Updated the package dependencies.

## Version [0.3.1](https://github.com/cedx/lcov.dart/compare/v0.3.0...v0.3.1)
- Fixed a bug in `Report.parse()` method.

## Version [0.3.0](https://github.com/cedx/lcov.dart/compare/v0.2.0...v0.3.0)
- Added the `data` parameter to the default constructors of the coverage classes.
- Added the `records` parameter to the default constructor of the `Report` class.

## Version [0.2.0](https://github.com/cedx/lcov.dart/compare/v0.1.0...v0.2.0)
- Breaking change: changed the signature of most default constructors.
- Empty test names are not included in the report output.

## Version 0.1.0
- Initial release.

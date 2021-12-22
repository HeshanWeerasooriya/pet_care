/// To use this font, place it in your fonts/ directory and include the
/// following in your pubspec.yaml
///
/// flutter:
///   fonts:
///    - family:  Pets
///      fonts:
///       - asset: fonts/Pets.ttf
///
///
///
import 'package:flutter/widgets.dart';
//Icons made by "https://www.flaticon.com/authors/freepik"

class Pets {
  Pets._();

  static const _kFontFam = 'Pets';

  static const IconData cat = IconData(0xe800, fontFamily: _kFontFam);
  static const IconData dog_seating = IconData(0xe801, fontFamily: _kFontFam);
}

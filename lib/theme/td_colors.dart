//  Created by matthewyan on 2021/4/28.
//  Copyright © 2021年 Tencent Inc. All rights reserved.

import 'package:flutter/material.dart';

class TDesignColor extends ColorSwatch<int> {
  /// Creates a color swatch with a variety of shades appropriate for accent
  /// colors.
  const TDesignColor(int primary, Map<int, Color> swatch) : super(primary, swatch);

  /// The lightest shade.
  Color get shade1 => this[1]!;

  /// The second lightest shade.
  Color get shade2 => this[2]!;

  /// The third lightest shade.
  Color get shade3 => this[3]!;

  /// The fourth lightest shade.
  Color get shade4 => this[4]!;

  /// The fifth lightest shade.
  Color get shade5 => this[5]!;

  /// The default shade.
  Color get shade6 => this[6]!;

  /// The fourth darkest shade.
  Color get shade7 => this[7]!;

  /// The third darkest shade.
  Color get shade8 => this[8]!;

  /// The second darkest shade.
  Color get shade9 => this[9]!;

  /// The darkest shade.
  Color get shade10 => this[10]!;
}

abstract class TDColors {
  /// primary-color
  static const TDesignColor blue = TDesignColor(
    _bluePrimaryValue,
    <int, Color>{
       1: Color(0xFFDFEFFF),
       2: Color(0xFFBFDBF7),
       3: Color(0xFF9BC5F2),
       4: Color(0xFF7BAFED),
       5: Color(0xFF5C99EB),
       6: Color(0xFF3881E8),
       7: Color(0xFF206AE1),
       8: Color(_bluePrimaryValue),
       9: Color(0xFF003CBE),
      10: Color(0xFF0026A1),
    },
  );
  static const int _bluePrimaryValue = 0xFF0052D9;

  /// error-color
  static const TDesignColor red = TDesignColor(
    _redPrimaryValue,
    <int, Color>{
       1: Color(0xFFFFE9E9),
       2: Color(0xFFFFCCCE),
       3: Color(0xFFFFACAF),
       4: Color(0xFFFF888C),
       5: Color(0xFFFB646D),
       6: Color(_redPrimaryValue),
       7: Color(0xFFC93043),
       8: Color(0xFFB01531),
       9: Color(0xFF960022),
      10: Color(0xFF730021),
    },
  );
  static const int _redPrimaryValue = 0xFFE34D59;

  /// warning-color
  static const TDesignColor orange = TDesignColor(
    _orangePrimaryValue,
    <int, Color>{
       1: Color(0xFFFFEFDB),
       2: Color(0xFFFFD3A3),
       3: Color(0xFFFFB473),
       4: Color(0xFFFF9247),
       5: Color(_orangePrimaryValue),
       6: Color(0xFFD6621C),
       7: Color(0xFFC24C08),
       8: Color(0xFFA23C00),
       9: Color(0xFF872D00),
      10: Color(0xFF691F00),
    },
  );
  static const int _orangePrimaryValue = 0xFFED7B2F;

  ///success-color
  static const TDesignColor green = TDesignColor(
    _greenPrimaryValue,
    <int, Color>{
       1: Color(0xFFDFF7ED),
       2: Color(0xFFA9E8CD),
       3: Color(0xFF69D5AB),
       4: Color(0xFF30BF8B),
       5: Color(_greenPrimaryValue),
       6: Color(0xFF00935D),
       7: Color(0xFF007E4A),
       8: Color(0xFF006937),
       9: Color(0xFF005426),
      10: Color(0xFF004114),
    },
  );
  static const int _greenPrimaryValue = 0xFF00A870;
}

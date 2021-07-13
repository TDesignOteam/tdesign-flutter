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
      1: Color(0xFFECF2FE),
      2: Color(0xFFD4E3FC),
      3: Color(0xFFBBD3FB),
      4: Color(0xFF96BBF8),
      5: Color(0xFF699EF5),
      6: Color(0xFF4787F0),
      7: Color(0xFF266FE8),
      8: Color(_bluePrimaryValue),
      9: Color(0xFF0034B5),
      10: Color(0xFF001F97),
    },
  );
  static const int _bluePrimaryValue = 0xFF0052D9;

  /// error-color
  static const TDesignColor red = TDesignColor(
    _redPrimaryValue,
    <int, Color>{
      1: Color(0xFFFDECEE),
      2: Color(0xFFF9D7D9),
      3: Color(0xFFF8B9BE),
      4: Color(0xFFF78D94),
      5: Color(0xFFF36D78),
      6: Color(_redPrimaryValue),
      7: Color(0xFFC9353F),
      8: Color(0xFFB11F26),
      9: Color(0xFF951114),
      10: Color(0xFF680506),
    },
  );
  static const int _redPrimaryValue = 0xFFE34D59;

  /// warning-color
  static const TDesignColor orange = TDesignColor(
    _orangePrimaryValue,
    <int, Color>{
      1: Color(0xFFFEF3E6),
      2: Color(0xFFF9E0C7),
      3: Color(0xFFF7C797),
      4: Color(0xFFF2995F),
      5: Color(_orangePrimaryValue),
      6: Color(0xFFD35A21),
      7: Color(0xFFBA431B),
      8: Color(0xFF9E3610),
      9: Color(0xFF842B0B),
      10: Color(0xFF5A1907),
    },
  );
  static const int _orangePrimaryValue = 0xFFED7B2F;

  /// success-color
  static const TDesignColor green = TDesignColor(
    _greenPrimaryValue,
    <int, Color>{
      1: Color(0xFFE8F8F2),
      2: Color(0xFFBCEBDC),
      3: Color(0xFF85DBBE),
      4: Color(0xFF48C79C),
      5: Color(_greenPrimaryValue),
      6: Color(0xFF078D5C),
      7: Color(0xFF067945),
      8: Color(0xFF056334),
      9: Color(0xFF044F2A),
      10: Color(0xFF033017),
    },
  );
  static const int _greenPrimaryValue = 0xFF00A870;

  /// 字体黑色色板
  static const ColorSwatch fontBlack = ColorSwatch(
    _fontBlackPrimaryValue,
    <int, Color>{
      1: Color(_fontBlackPrimaryValue),
      2: Color(0x99000000),
      3: Color(0x66000000),
      4: Color(0x42000000),
    },
  );
  static const int _fontBlackPrimaryValue = 0xE6000000;

  /// 字体白色色板
  static const ColorSwatch fontWhite = ColorSwatch(
    _fontWhitePrimaryValue,
    <int, Color>{
      1: Color(_fontWhitePrimaryValue),
      2: Color(0x8CFFFFFF),
      3: Color(0x59FFFFFF),
      4: Color(0x1AFFFFFF),
    },
  );
  static const int _fontWhitePrimaryValue = 0xFFFFFFFF;
}

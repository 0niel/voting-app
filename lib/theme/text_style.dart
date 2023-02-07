import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_theme.dart';

enum TextType {
  displayLarge,
  displayMedium,
  displaySmall,
  headlineLarge,
  headlineMedium,
  headlineSmall,
  titleLarge,
  titleMedium,
  titleSmall,
  bodyLarge,
  bodyMedium,
  bodySmall,
  labelLarge,
  labelMedium,
  labelSmall,

  @Deprecated('use')
  h4,
  @Deprecated('use')
  h5,
  @Deprecated('use')
  h6,
  @Deprecated('use')
  sh1,
  @Deprecated('use')
  sh2,
  @Deprecated('use')
  button,
  @Deprecated('use')
  caption,
  @Deprecated('use')
  overline,

// Material Design 3
  @Deprecated('use')
  d1,
  @Deprecated('use')
  d2,
  @Deprecated('use')
  d3,
  @Deprecated('use')
  h1,
  @Deprecated('use')
  h2,
  @Deprecated('use')
  h3,
  @Deprecated('use')
  t1,
  @Deprecated('use')
  t2,
  @Deprecated('use')
  t3,
  @Deprecated('use')
  l1,
  @Deprecated('use')
  l2,
  @Deprecated('use')
  l3,
  @Deprecated('use')
  b1,
  @Deprecated('use')
  b2,
  @Deprecated('use')
  b3
}

class CustomTextStyle {
  static Function _fontFamily = GoogleFonts.ibmPlexSans;

  static Map<int, FontWeight> _defaultFontWeight = {
    100: FontWeight.w100,
    200: FontWeight.w200,
    300: FontWeight.w300,
    400: FontWeight.w300,
    500: FontWeight.w400,
    600: FontWeight.w500,
    700: FontWeight.w600,
    800: FontWeight.w700,
    900: FontWeight.w800,
  };

  static Map<TextType, double> _defaultTextSize = {
    // Material Design 3

    TextType.displayLarge: 57,
    TextType.displayMedium: 45,
    TextType.displaySmall: 36,

    TextType.headlineLarge: 32,
    TextType.headlineMedium: 28,
    TextType.headlineSmall: 26,

    TextType.titleLarge: 22,
    TextType.titleMedium: 16,
    TextType.titleSmall: 14,

    TextType.labelLarge: 14,
    TextType.labelMedium: 12,
    TextType.labelSmall: 11,

    TextType.bodyLarge: 16,
    TextType.bodyMedium: 14,
    TextType.bodySmall: 12,

    // @Deprecated('')
    TextType.h4: 36,
    TextType.h5: 25,
    TextType.h6: 21,
    TextType.sh1: 17,
    TextType.sh2: 15,
    TextType.button: 13,
    TextType.caption: 12,
    TextType.overline: 10,

    // Material Design 3

    TextType.d1: 57,
    TextType.d2: 45,
    TextType.d3: 36,

    TextType.h1: 32,
    TextType.h2: 28,
    TextType.h3: 26,

    TextType.t1: 22,
    TextType.t2: 16,
    TextType.t3: 14,

    TextType.l1: 14,
    TextType.l2: 12,
    TextType.l3: 11,

    TextType.b1: 16,
    TextType.b2: 14,
    TextType.b3: 12,
  };

  static Map<TextType, int> _defaultTextFontWeight = {
    TextType.displayLarge: 500,
    TextType.displayMedium: 500,
    TextType.displaySmall: 500,

    TextType.headlineLarge: 500,
    TextType.headlineMedium: 500,
    TextType.headlineSmall: 500,

    TextType.titleLarge: 500,
    TextType.titleMedium: 500,
    TextType.titleSmall: 500,

    TextType.labelLarge: 600,
    TextType.labelMedium: 600,
    TextType.labelSmall: 600,

    TextType.bodyLarge: 500,
    TextType.bodyMedium: 500,
    TextType.bodySmall: 500,
    //
    // // Material Design 2 (Old)
    TextType.h4: 500,
    TextType.h5: 500,
    TextType.h6: 500,
    TextType.sh1: 500,
    TextType.sh2: 500,
    TextType.button: 500,
    TextType.caption: 500,
    TextType.overline: 500,

    //Material Design 3

    TextType.d1: 500,
    TextType.d2: 500,
    TextType.d3: 500,

    TextType.h1: 500,
    TextType.h2: 500,
    TextType.h3: 500,

    TextType.t1: 500,
    TextType.t2: 500,
    TextType.t3: 500,

    TextType.l1: 600,
    TextType.l2: 600,
    TextType.l3: 600,

    TextType.b1: 500,
    TextType.b2: 500,
    TextType.b3: 500,
  };

  static Map<TextType, double> _defaultLetterSpacing = {
    TextType.displayLarge: -0.25,
    TextType.displayMedium: 0,
    TextType.displaySmall: 0,

    TextType.headlineLarge: -0.2,
    TextType.headlineMedium: -0.15,
    TextType.headlineSmall: 0,

    TextType.titleLarge: 0,
    TextType.titleMedium: 0.1,
    TextType.titleSmall: 0.1,

    TextType.labelLarge: 0.1,
    TextType.labelMedium: 0.5,
    TextType.labelSmall: 0.5,

    TextType.bodyLarge: 0.5,
    TextType.bodyMedium: 0.25,
    TextType.bodySmall: 0.4,
    //
    // Deprecated
    TextType.h4: 0,
    TextType.h5: 0,
    TextType.h6: 0,
    TextType.sh1: 0.15,
    TextType.sh2: 0.15,
    TextType.button: 0.15,
    TextType.caption: 0.15,
    TextType.overline: 0.15,

    //Material Design 3
    TextType.d1: -0.25,
    TextType.d2: 0,
    TextType.d3: 0,

    TextType.h1: -0.2,
    TextType.h2: -0.15,
    TextType.h3: 0,

    TextType.t1: 0,
    TextType.t2: 0.1,
    TextType.t3: 0.1,

    TextType.l1: 0.1,
    TextType.l2: 0.5,
    TextType.l3: 0.5,

    TextType.b1: 0.5,
    TextType.b2: 0.25,
    TextType.b3: 0.4,
  };

  @Deprecated('message')
  static TextStyle getStyle(
      {TextStyle? textStyle,
      int? fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double letterSpacing = 0.15,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    double? finalFontSize = fontSize ?? (textStyle == null ? 40 : textStyle.fontSize);

    Color? finalColor;
    if (color == null) {
      Color themeColor = AppTheme.lightTheme.colorScheme.onBackground;
      finalColor = xMuted
          ? themeColor.withAlpha(160)
          : (muted ? themeColor.withAlpha(200) : themeColor);
    } else {
      finalColor = xMuted
          ? color.withAlpha(160)
          : (muted ? color.withAlpha(200) : color);
    }

    return _fontFamily(
        fontSize: finalFontSize,
        fontWeight: _defaultFontWeight[fontWeight] ?? FontWeight.w400,
        letterSpacing: letterSpacing,
        color: finalColor,
        decoration: decoration,
        height: height,
        wordSpacing: wordSpacing);
  }

  @Deprecated('message')
  static TextStyle h4(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.h4],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _defaultLetterSpacing[TextType.h4] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h5(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.h5],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _defaultLetterSpacing[TextType.h5] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h6(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.h6],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ?? _defaultLetterSpacing[TextType.h6] ?? 0,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle sh1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.sh1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.sh1] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle sh2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.sh2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.sh2] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle button(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.button],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.button] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle caption(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing = 0,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.caption],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.caption] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle overline(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.overline],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.overline] ?? 0.15,
        fontWeight: fontWeight,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  // Material Design 3
  @Deprecated('message')
  static TextStyle d1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.d1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.d1] ?? -0.2,
        fontWeight: _defaultTextFontWeight[TextType.d1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle d2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.d2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.d2] ?? -0.2,
        fontWeight: _defaultTextFontWeight[TextType.d2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle d3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.d3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.d3] ?? -0.2,
        fontWeight: _defaultTextFontWeight[TextType.d3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.h1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.h1] ?? -0.2,
        fontWeight: _defaultTextFontWeight[TextType.h1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.h2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.h2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[TextType.h2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle h3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.h3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.h3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[TextType.h3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle t1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.t1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.t1] ?? -0.15,
        fontWeight: _defaultTextFontWeight[TextType.t1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle t2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.t2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.t2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[TextType.t2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle t3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.t3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.t3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[TextType.t3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle l1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.l1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.l1] ?? -0.15,
        fontWeight: _defaultTextFontWeight[TextType.l1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle l2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.l2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.l2] ?? -0.15,
        fontWeight: _defaultTextFontWeight[TextType.l2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle l3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.l3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.l3] ?? -0.15,
        fontWeight: _defaultTextFontWeight[TextType.l3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle b1(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.b1],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.b1] ?? 0.15,
        fontWeight: _defaultTextFontWeight[TextType.b1] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle b2(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.b2],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.b2] ?? 0.15,
        fontWeight: _defaultTextFontWeight[TextType.b2] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  @Deprecated('message')
  static TextStyle b3(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.b3],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.b3] ?? 0.15,
        fontWeight: _defaultTextFontWeight[TextType.b3] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  // Material Design 3
  static TextStyle displayLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.displayLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.displayLarge] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[TextType.displayLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle displayMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.displayMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.displayMedium] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[TextType.displayMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle displaySmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.displaySmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.displaySmall] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[TextType.displaySmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle headlineLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.headlineLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.headlineLarge] ??
            -0.2,
        fontWeight: _defaultTextFontWeight[TextType.headlineLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle headlineMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.headlineMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.headlineMedium] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[TextType.headlineMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle headlineSmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.headlineSmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.headlineSmall] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[TextType.headlineSmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle titleLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.titleLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.titleLarge] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[TextType.titleLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle titleMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.titleMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.titleMedium] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[TextType.titleMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle titleSmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.titleSmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.titleSmall] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[TextType.titleSmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle labelLarge(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.labelLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.labelLarge] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[TextType.labelLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle labelMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.labelMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.labelMedium] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[TextType.labelMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle labelSmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.labelSmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing: letterSpacing ??
            _defaultLetterSpacing[TextType.labelSmall] ??
            -0.15,
        fontWeight: _defaultTextFontWeight[TextType.labelSmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle bodyLarge(
      {TextStyle? textStyle,
      int? fontWeight,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.bodyLarge],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.bodyLarge] ?? 0.15,
        fontWeight:
            fontWeight ?? _defaultTextFontWeight[TextType.bodyLarge] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle bodyMedium(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.bodyMedium],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.bodyMedium] ?? 0.15,
        fontWeight: _defaultTextFontWeight[TextType.bodyMedium] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static TextStyle bodySmall(
      {TextStyle? textStyle,
      int fontWeight = 500,
      bool muted = false,
      bool xMuted = false,
      double? letterSpacing,
      Color? color,
      TextDecoration decoration = TextDecoration.none,
      double? height,
      double wordSpacing = 0,
      double? fontSize}) {
    return getStyle(
        fontSize: fontSize ?? _defaultTextSize[TextType.bodySmall],
        color: color,
        height: height,
        muted: muted,
        letterSpacing:
            letterSpacing ?? _defaultLetterSpacing[TextType.bodySmall] ?? 0.15,
        fontWeight: _defaultTextFontWeight[TextType.bodySmall] ?? 500,
        decoration: decoration,
        textStyle: textStyle,
        wordSpacing: wordSpacing,
        xMuted: xMuted);
  }

  static void changeFontFamily(Function fontFamily) {
    CustomTextStyle._fontFamily = fontFamily;
  }

  static void changeDefaultFontWeight(Map<int, FontWeight> defaultFontWeight) {
    CustomTextStyle._defaultFontWeight = defaultFontWeight;
  }

  static void changeDefaultTextSize(Map<TextType, double> defaultTextSize) {
    CustomTextStyle._defaultTextSize = defaultTextSize;
  }

  static Map<TextType, double> get defaultTextSize => _defaultTextSize;

  static Map<TextType, double> get defaultLetterSpacing =>
      _defaultLetterSpacing;

  static Map<TextType, int> get defaultTextFontWeight => _defaultTextFontWeight;

  static Map<int, FontWeight> get defaultFontWeight => _defaultFontWeight;

  //-------------------Reset Font Styles---------------------------------
  static resetFontStyles() {
    _fontFamily = GoogleFonts.ibmPlexSans;

    _defaultFontWeight = {
      100: FontWeight.w100,
      200: FontWeight.w200,
      300: FontWeight.w300,
      400: FontWeight.w300,
      500: FontWeight.w400,
      600: FontWeight.w500,
      700: FontWeight.w600,
      800: FontWeight.w700,
      900: FontWeight.w800,
    };

    _defaultTextSize = {
      TextType.displayLarge: 57,
      TextType.displayMedium: 45,
      TextType.displaySmall: 36,

      TextType.headlineLarge: 32,
      TextType.headlineMedium: 28,
      TextType.headlineSmall: 26,

      TextType.titleLarge: 22,
      TextType.titleMedium: 16,
      TextType.titleSmall: 14,

      TextType.labelLarge: 14,
      TextType.labelMedium: 12,
      TextType.labelSmall: 11,

      TextType.bodyLarge: 16,
      TextType.bodyMedium: 14,
      TextType.bodySmall: 12,

      TextType.h4: 36,
      TextType.h5: 25,
      TextType.h6: 21,
      TextType.sh1: 17,
      TextType.sh2: 15,
      TextType.button: 13,
      TextType.caption: 12,
      TextType.overline: 10,

      // Material Design 3

      TextType.d1: 57,
      TextType.d2: 45,
      TextType.d3: 36,

      TextType.h1: 32,
      TextType.h2: 28,
      TextType.h3: 26,

      TextType.t1: 22,
      TextType.t2: 16,
      TextType.t3: 14,

      TextType.l1: 14,
      TextType.l2: 12,
      TextType.l3: 11,

      TextType.b1: 16,
      TextType.b2: 14,
      TextType.b3: 12,
    };

    _defaultTextFontWeight = {
      TextType.displayLarge: 500,
      TextType.displayMedium: 500,
      TextType.displaySmall: 500,

      TextType.headlineLarge: 500,
      TextType.headlineMedium: 500,
      TextType.headlineSmall: 500,

      TextType.titleLarge: 500,
      TextType.titleMedium: 500,
      TextType.titleSmall: 500,

      TextType.labelLarge: 600,
      TextType.labelMedium: 600,
      TextType.labelSmall: 600,

      TextType.bodyLarge: 500,
      TextType.bodyMedium: 500,
      TextType.bodySmall: 500,

      // Material Design 2 (Old)
      TextType.h4: 500,
      TextType.h5: 500,
      TextType.h6: 500,
      TextType.sh1: 500,
      TextType.sh2: 500,
      TextType.button: 500,
      TextType.caption: 500,
      TextType.overline: 500,

      //Material Design 3

      TextType.d1: 500,
      TextType.d2: 500,
      TextType.d3: 500,

      TextType.h1: 500,
      TextType.h2: 500,
      TextType.h3: 500,

      TextType.t1: 500,
      TextType.t2: 500,
      TextType.t3: 500,

      TextType.l1: 600,
      TextType.l2: 600,
      TextType.l3: 600,

      TextType.b1: 500,
      TextType.b2: 500,
      TextType.b3: 500,
    };

    _defaultLetterSpacing = {
      TextType.displayLarge: -0.25,
      TextType.displayMedium: 0,
      TextType.displaySmall: 0,

      TextType.headlineLarge: -0.2,
      TextType.headlineMedium: -0.15,
      TextType.headlineSmall: 0,

      TextType.titleLarge: 0,
      TextType.titleMedium: 0.1,
      TextType.titleSmall: 0.1,

      TextType.labelLarge: 0.1,
      TextType.labelMedium: 0.5,
      TextType.labelSmall: 0.5,

      TextType.bodyLarge: 0.5,
      TextType.bodyMedium: 0.25,
      TextType.bodySmall: 0.4,

      //@deprecated
      TextType.h4: 0,
      TextType.h5: 0,
      TextType.h6: 0,
      TextType.sh1: 0.15,
      TextType.sh2: 0.15,
      TextType.button: 0.15,
      TextType.caption: 0.15,
      TextType.overline: 0.15,

      //Material Design 3
      TextType.d1: -0.25,
      TextType.d2: 0,
      TextType.d3: 0,

      TextType.h1: -0.2,
      TextType.h2: -0.15,
      TextType.h3: 0,

      TextType.t1: 0,
      TextType.t2: 0.1,
      TextType.t3: 0.1,

      TextType.l1: 0.1,
      TextType.l2: 0.5,
      TextType.l3: 0.5,

      TextType.b1: 0.5,
      TextType.b2: 0.25,
      TextType.b3: 0.4,
    };
  }
}

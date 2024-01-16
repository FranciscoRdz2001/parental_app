import 'dart:math';

import 'package:flutter/widgets.dart';

enum DeviceType {
  mobile,
  tablet,
  desktop,
}

class ScreenSizer {
  const ScreenSizer({
    required double width,
    required double height,
    required double ratio,
    required DeviceType deviceType,
    required double inch,
  })  : _width = width,
        _height = height,
        _ratio = ratio,
        _inch = inch,
        _deviceType = deviceType;

  factory ScreenSizer.of(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final shortSize = size.shortestSide;

    final type = _breakPoints.entries
        .firstWhere(
          (entry) => shortSize < entry.key,
          orElse: () => _breakPoints.entries.first,
        )
        .value;
    final inch = sqrt(pow(size.width, 2) + pow(size.height, 2));

    return ScreenSizer(
      width: size.width,
      height: size.height,
      ratio: size.aspectRatio,
      deviceType: type,
      inch: inch,
    );
  }
  static const Map<int, DeviceType> _breakPoints = {
    480: DeviceType.mobile,
    834: DeviceType.tablet,
    1600: DeviceType.desktop,
  };

  final double _width;
  final double _height;
  final double _ratio;
  final double _inch;
  final DeviceType _deviceType;

  double get width => _width;
  double get height => _height;
  double get ratio => _ratio;
  DeviceType get deviceType => _deviceType;

  double hp(double percent) => _height * percent / 100;

  double wp(double percent) => _width * percent / 100;

  double ip(double percent) => _inch * percent / 100;
}

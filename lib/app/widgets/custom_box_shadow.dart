import 'package:flutter/material.dart';

class CustomBoxShadow extends BoxShadow {
  const CustomBoxShadow({
    super.color,
    super.offset,
    super.blurRadius,
    this.blurStyle = BlurStyle.normal,
  });

  @override
  // ignore: overridden_fields
  final BlurStyle blurStyle;

  @override
  Paint toPaint() {
    final result = Paint()
      ..color = color
      ..maskFilter = MaskFilter.blur(blurStyle, blurSigma);

    // ignore: prefer_asserts_with_message
    assert(() {
      if (debugDisableShadows) result.maskFilter = null;
      return true;
    }());
    return result;
  }
}

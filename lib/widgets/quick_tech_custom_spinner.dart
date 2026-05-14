import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

/// Enum for spinner animation types
enum SpinnerType {
  circle('Circle'),
  fadingCircle('FadingCircle'),
  chasingDots('ChasingDots'),
  cubeGrid('CubeGrid');

  final String label;
  const SpinnerType(this.label);
}

class CustomSpinner extends StatelessWidget {
  final SpinnerType spinnerType;
  final Color color;
  final double size;

  const CustomSpinner({
    Key? key,
    this.spinnerType = SpinnerType.cubeGrid,
    this.color = const Color(0xff75559E),
    this.size = 30.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Widget spinner = _buildSpinner();
    return Center(child: spinner);
  }

  Widget _buildSpinner() {
    switch (spinnerType) {
      case SpinnerType.circle:
        return SpinKitCircle(color: color, size: size);
      case SpinnerType.fadingCircle:
        return SpinKitFadingCircle(color: color, size: size);
      case SpinnerType.chasingDots:
        return SpinKitChasingDots(color: color, size: size);
      case SpinnerType.cubeGrid:
        return SpinKitCubeGrid(color: color, size: size);
    }
  }
}

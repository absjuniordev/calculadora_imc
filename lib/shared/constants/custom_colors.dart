import 'package:flutter/material.dart';

class CustomColors {
  final Color _activePrimaryButton = const Color.fromARGB(255, 63, 81, 181);
  final Color _activeSecondaryButton = const Color.fromARGB(255, 230, 230, 255);
  final Color _gradientMainColor = const Color.fromARGB(255, 48, 231, 64);
  final Color _gradientSecColor = const Color(0xff00E6FD);
  final Color _appBarMainColor = const Color(0xff0A6D92);
  final Color _circleColor = const Color.fromARGB(85, 139, 156, 145);

  late GradientColor gradientColor;
  late Color scaffoldBackgroundColor;

  CustomColors() {
    gradientColor = GradientColor(colors: [
      _gradientSecColor,
      _gradientMainColor,
    ]);
    scaffoldBackgroundColor = gradientColor.getColor();
  }

  Color getActivePrimaryButtonColor() {
    return _activePrimaryButton;
  }

  Color getCircleColor() {
    return _circleColor;
  }

  Color getActiveSecondaryButton() {
    return _activeSecondaryButton;
  }

  Color getGradientMainColor() {
    return _gradientMainColor;
  }

  Color getGradientSecondaryColor() {
    return _gradientSecColor;
  }

  Color getAppBarMainColor() {
    return _appBarMainColor;
  }
}

class GradientColor extends StatelessWidget {
  final List<Color> colors;

  const GradientColor({Key? key, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          // transform: GradientRotation(5),
        
        ),
      ),
    );
  }

  Color getColor() {
    return colors.isEmpty ? Colors.transparent : colors[colors.length ~/ 2];
  }
}

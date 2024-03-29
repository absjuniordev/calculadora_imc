import 'package:flutter/material.dart';

class CustomColors {
  final Color _activePrimaryButton = const Color.fromARGB(255, 63, 81, 181);
  final Color _activeSecondaryButton = const Color.fromARGB(255, 230, 230, 255);
  final Color _gradientMainColor = const Color.fromARGB(255, 48, 231, 64);
  final Color _gradientSecColor = const Color(0xff00E6FD);
  final Color _appBarMainColor = const Color(0xff0A6D92);
  final Color _circleColor = const Color.fromARGB(85, 139, 156, 145);

 

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



import 'package:calculadora_imc/shared/constants/custom_colors.dart';
import 'package:calculadora_imc/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            CustomColors().getGradientMainColor(),
            CustomColors().getGradientSecondaryColor(),
          ],
        ),
      ),
      child: Column(
        children: [
          const Spacer(flex: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                color: Colors.transparent,
                elevation: 50,
                child: Container(
                  decoration: BoxDecoration(
                      color: CustomColors().getCircleColor(),
                      borderRadius: BorderRadius.circular(75)),
                  height: 175,
                  width: 175,
                ),
              ),
              const SizedBox(width: 2),
              Card(
                color: Colors.transparent,
                elevation: 50,
                child: Container(
                  decoration: BoxDecoration(
                    color: CustomColors().getCircleColor(),
                    borderRadius: BorderRadius.circular(75),
                  ),
                  height: 175,
                  width: 175,
                ),
              ),
            ],
          ),
          const Spacer(flex: 1),
          Card(
            color: Colors.transparent,
            elevation: 50,
            child: Container(
              decoration: BoxDecoration(
                  color: CustomColors().getCircleColor(),
                  borderRadius: BorderRadius.circular(75)),
              height: 190,
              width: 300,
            ),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}

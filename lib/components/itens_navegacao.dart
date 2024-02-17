import 'package:calculadora_imc/pages/imc_listagem_page.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class ItensNavegacao extends StatelessWidget {
  const ItensNavegacao({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Wrap(
      spacing: size.height / 88,
      runSpacing: size.height / 40,
      children: [
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              PageTransition(
                duration: const Duration(milliseconds: 200),
                type: PageTransitionType.bottomToTop,
                child: const IMCListagemPage(),
              ),
            );
          },
          child: Card(
            elevation: 5,
            child: Container(
              height: size.height / 6,
              width: size.width / 3.5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(166, 233, 230, 230),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Card(
            elevation: 5,
            child: Container(
              height: size.height / 6,
              width: size.width / 3.5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(166, 233, 230, 230),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Card(
            elevation: 5,
            child: Container(
              height: size.height / 6,
              width: size.width / 3.5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(166, 233, 230, 230),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Card(
            elevation: 5,
            child: Container(
              height: size.height / 6,
              width: size.width / 3.5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(166, 233, 230, 230),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Card(
            elevation: 5,
            child: Container(
              height: size.height / 6,
              width: size.width / 3.5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(166, 233, 230, 230),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: () {},
          child: Card(
            elevation: 5,
            child: Container(
              height: size.height / 6,
              width: size.width / 3.5,
              decoration: BoxDecoration(
                color: const Color.fromARGB(166, 233, 230, 230),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

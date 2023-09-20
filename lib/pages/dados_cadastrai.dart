import 'package:flutter/material.dart';

class DadosCadastrais extends StatelessWidget {
  const DadosCadastrais({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Card(
                elevation: 50,
                child: Container(
                  height: 190,
                  width: 190,
                  color: Colors.amber,
                ),
              ),
              SizedBox(width: 2),
              Card(
                elevation: 50,
                child: Container(
                  height: 190,
                  width: 190,
                  child: Text("oi"),
                  color: Colors.amber,
                ),
              ),
            ],
          ),
          const Spacer(flex: 1),
          Card(
            elevation: 50,
            child: Container(
              height: 190,
              width: 300,
              child: Text("oi"),
              color: Colors.amber,
            ),
          ),
          const Spacer(flex: 5),
        ],
      ),
    );
  }
}

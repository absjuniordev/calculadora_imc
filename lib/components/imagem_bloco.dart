import 'package:flutter/material.dart';

class ImagemBloco extends StatelessWidget {
  const ImagemBloco({
    super.key,
    required this.title,
    required this.pathImage,
  });

  final String title;
  final String pathImage;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.all(size.height / 70),
      child: Column(
        children: [
          Image.asset(
            pathImage,
            width: size.width / 1,
            height: size.height / 10,
          ),
          SizedBox(
            height: size.height / 100,
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: size.height / 55,
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

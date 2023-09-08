// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// class CustomTextFiel extends StatefulWidget {
//   String labelText;
//   String hintText;
//   const CustomTextFiel({
//     Key? key,
//     required this.labelText,
//     required this.hintText,
//   }) : super(key: key);

//   @override
//   State<CustomTextFiel> createState() => _CustomTextFielState();
// }

// class _CustomTextFielState extends State<CustomTextFiel> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: 80,
//       child: TextField(
//         controller: pesoController,
//         textAlign: TextAlign.start,
//         maxLength: 3,
//         decoration: InputDecoration(
//           border: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.black),
//             borderRadius: BorderRadius.circular(60),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.black),
//             borderRadius: BorderRadius.circular(60),
//           ),
//           labelText: labelText,
//           hintText: "Ex:85",
//         ),
//       ),
//     );
//   }
// }

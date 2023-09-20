// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/material.dart';

// class HomePageContente extends StatefulWidget {
//   int itemCount;
//   List imc = [];
//   bool isFavorite;
//   HomePageContente({
//     Key? key,
//     required this.itemCount,
//     required this.imc,
//     required this.isFavorite,
//   }) : super(key: key);

//   @override
//   State<HomePageContente> createState() => _HomePageContenteState();
// }

// class _HomePageContenteState extends State<HomePageContente> {
//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//           itemCount: widget.itemCount,
//           itemBuilder: (BuildContext bc, int index) {
//             var imc = widget.imc[index];
//             return Dismissible(
//               confirmDismiss: (DismissDirection direction) async {
//                 if (direction == DismissDirection.startToEnd) {
//                   return await showDialog(
//                     context: context,
//                     builder: (BuildContext bc) {
//                       return AlertDialog(
//                         title: const Text("Delete"),
//                         content: const Text(
//                           "Você tem certeza que deseja deletar esse Card ?",
//                         ),
//                         actions: <Widget>[
//                           ElevatedButton(
//                             onPressed: () => Navigator.of(context).pop(true),
//                             child: const Text("Sim"),
//                           ),
//                           ElevatedButton(
//                             onPressed: () => Navigator.of(context).pop(false),
//                             child: const Text("Não"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 } else {
//                   return await showDialog(
//                     context: context,
//                     builder: (BuildContext bc) {
//                       return AlertDialog(
//                         title: const Text("Salvar"),
//                         content: const Text(
//                           "Deseja favoritar este Card?",
//                         ),
//                         actions: <Widget>[
//                           ElevatedButton(
//                             onPressed: () {
//                               setState(() {
//                                 imc.isFavorite = true;
//                                 dadosIMCRepository.alterarTarefa(
//                                     imc.id, imc.isFavorite);
//                               });
//                               Navigator.of(context).pop(false);
//                               favorite = false;
//                             },
//                             child: const Text("Sim"),
//                           ),
//                           ElevatedButton(
//                             onPressed: () => Navigator.of(context).pop(false),
//                             child: const Text("Não"),
//                           ),
//                         ],
//                       );
//                     },
//                   );
//                 }
//               },
//               background: Container(
//                 alignment: Alignment.centerLeft,
//                 margin: const EdgeInsets.only(top: 10),
//                 color: Colors.red,
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Icon(
//                     Icons.delete,
//                   ),
//                 ),
//               ),
//               secondaryBackground: Container(
//                 alignment: Alignment.centerRight,
//                 margin: const EdgeInsets.only(top: 10),
//                 color: Colors.green,
//                 child: const Padding(
//                   padding: EdgeInsets.all(8.0),
//                   child: Icon(
//                     Icons.check,
//                     color: Colors.amber,
//                   ),
//                 ),
//               ),
//               onDismissed: (DismissDirection dismissDirection) async {
//                 await dadosIMCRepository.removeItem(imc.id);
//                 obterIMC();
//               },
//               key: Key(imc.id),
//               child: Card(
//                 key: Key(imc.id),
//                 elevation: 5,
//                 color: determinarCor(imc.result),
//                 child: ListTile(
//                   leading: imc.isFavorite
//                       ? const Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                           size: 30,
//                         )
//                       : null,
//                   title: Row(
//                     children: [
//                       Text(
//                         "${verificacao(imc.result)} ",
//                         maxLines: 2,
//                         style: const TextStyle(
//                           color: Colors.black,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const Spacer(),
//                       Column(
//                         children: [
//                           Text(
//                             imc.dateTime,
//                             style: const TextStyle(
//                               color: Colors.black,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),;
//   }
// }

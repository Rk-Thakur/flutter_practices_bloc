// import 'package:flutter/material.dart';
// import 'package:flutter_practices/sqflite/services/db_helper.dart';

// class DatabasePage extends StatelessWidget {
//   const DatabasePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Database'),
//         ),
//         body: Column(
//           children: [
//             ElevatedButton(
//                 onPressed: () async {
//                   await DatabaseHelper.instance.insert({
//                     DatabaseHelper.columnName: 'John',
//                   });
//                 },
//                 child: const Text('Insert')),
//             ElevatedButton(
//                 onPressed: () async {
//                   var dbquery = await DatabaseHelper.instance.queryAll();
//                   print(dbquery);
//                 },
//                 child: const Text('Read')),
//             ElevatedButton(
//                 onPressed: () async {
//                   await DatabaseHelper.instance.update({
//                     DatabaseHelper.columnId: 1,
//                     DatabaseHelper.columnName: 'Johhn',
//                   });
//                 },
//                 child: const Text('Update')),
//             ElevatedButton(
//                 onPressed: () async {
//                   await DatabaseHelper.instance.delete(1);
//                 },
//                 child: const Text('Delete')),
//           ],
//         ));
//   }
// }

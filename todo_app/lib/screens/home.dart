import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/services/auth.dart';
import 'package:todo_app/services/database.dart';
import 'package:todo_app/widgets/todo_card.dart';

class Home extends StatefulWidget {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  const Home({required this.auth, required this.firestore});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Amateur Coder Todo"),
        centerTitle: true,
        actions: [
          IconButton(
            key: const ValueKey("signOut"),
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Auth(auth: widget.auth).signOut();
            },
          ),
        ],
      ),
    );
  }
}

//                   IconButton(
//                     key: const ValueKey("addButton"),
//                     icon: const Icon(Icons.add),
//                     onPressed: () {
//                       if (_todoController.text != "") {
//                         setState(() {
//                           Database(firestore: widget.firestore).addTodo(
//                             uid: widget.auth.currentUser!.uid,
//                             content: _todoController.text,
//                           );
//                           _todoController.clear();
//                         });
//                       }
//                     },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 20,
//           ),
//           const Text(
//             "Your Todos",
//             style: TextStyle(
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           Expanded(
//             child: StreamBuilder(
//               stream: Database(firestore: widget.firestore)
//                   .streamTodos(uid: widget.auth.currentUser!.uid),
//               builder: (
//                 BuildContext context,
//                 AsyncSnapshot<List<TodoModel?>> snapshot,
//               ) {
//                 if (snapshot.connectionState == ConnectionState.active) {
//                   if (snapshot.data!.isEmpty) {
//                     return const Center(
//                       child: Text("You don't have any unfinished Todos"),
//                     );
//                   }
//                   return ListView.builder(
//                     itemCount: snapshot.data!.length,
//                     itemBuilder: (_, index) {
//                       return null;
//                       // return TodoCard?(
//                       //   firestore: widget.firestore,
//                       //   uid: widget.auth.currentUser!.uid,
//                       //   todo: snapshot.data![index],
//                       // );
//                     },
//                   );
//                 } else {
//                   return const Center(
//                     child: Text("loading..."),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class TodoModel {
//   String? get content => null;

//   get done => null;

//   get todoId => null;

//   static TodoModel? fromDocumentSnapshot(
//       {required DocumentSnapshot<Object?> documentSnapshot}) {}
// }
                

// ignore: avoid_classes_with_only_static_members
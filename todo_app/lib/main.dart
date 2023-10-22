import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:todo_app/screens/home.dart';
import 'package:todo_app/screens/login.dart';
import 'package:todo_app/services/auth.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: FutureBuilder(
        // Initialize FlutterFire:
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return const Scaffold(
              body: Center(
                child: Text("Error"),
              ),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Root();
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return const Scaffold(
            body: Center(
              child: Text("Loading..."),
            ),
          );
        },
      ),
    );
  }
}

class Root extends StatefulWidget {
  @override
  _RootState createState() => _RootState();
}

class _RootState extends State<Root> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StreamBuilder(
        stream: _auth
            .authStateChanges(), // Listen to the user's authentication state
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            final User? user = snapshot.data;

            if (user == null) {
              // User is not authenticated, show a login screen
              return Login(
                auth: _auth,
                firestore: _firestore,
              );
            } else {
              // User is authenticated, show the main app screen
              // ignore: avoid_dynamic_calls
              return Home(auth: _auth, firestore: _firestore);
            }
          } else {
            // Loading state
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }
}



  // Implement your login UI and authentication logic here



  // Implement your main app UI and Firestore operations here








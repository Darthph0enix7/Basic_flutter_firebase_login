import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Initialization',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Firebase Initialization Status'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            FirebaseInitChecker(), // Firebase initialization status
            SizedBox(height: 20),   // Adds spacing
            Text('If Firebase initializes successfully, you\'ll see a confirmation message.'),
          ],
        ),
      ),
    );
  }
}

class FirebaseInitChecker extends StatelessWidget {
  const FirebaseInitChecker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error initializing Firebase',
              style: TextStyle(color: Colors.red, fontSize: 16));
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const Text('Firebase Initialized Successfully',
              style: TextStyle(color: Colors.green, fontSize: 16));
        }
        return const CircularProgressIndicator();
      },
    );
  }
}

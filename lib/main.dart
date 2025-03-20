import 'package:flutter/material.dart';
import 'counter_page.dart';
import 'todo_page.dart'; // Tetap gunakan impor ini

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HomePage(), // Ubah menjadi HomePage untuk navigasi
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Flutter Demo')),
      body: const CounterPage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoPage()),
          );
        },
        child: const Icon(Icons.list),
      ),
    );
  }
}


//nambahin tanggal, check box, ada snack bar, ada validasi
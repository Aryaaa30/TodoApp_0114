import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key});

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  List<String> listCounter = [];
  int _counter = 1;

  void addData() {
    setState(() {
      _counter += 1;
      listCounter.add(_counter.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Counter Page')),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: listCounter.length,
        itemBuilder: (context, index) {
          return CircleAvatar(
            backgroundColor: (index % 2 == 0) ? Colors.red : Colors.blue,
            child: Text('Data: ${listCounter[index]}'),
          );
        },
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              setState(() {
                if (_counter >= 0 && listCounter.isNotEmpty) {
                  _counter--;
                  listCounter.removeLast();
                }
              });
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: addData,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}

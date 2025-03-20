import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _taskController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  DateTime? _selectedDate;

  List<Map<String, dynamic>> _tasks = [];

  void _addTask() {
    if (_taskController.text.isEmpty || _dateController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task dan tanggal tidak boleh kosong!')),
      );
      return;
    }

    setState(() {
      _tasks.add({
        "task": _taskController.text,
        "isDone": false,
        "deadline": _selectedDate,
      });
      _taskController.clear();
      _dateController.clear();
      _selectedDate = null;
    });

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Task added successfully')));
  }

  Future<void> _pickDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        _selectedDate = pickedDate;
        _dateController.text = DateFormat('dd-MM-yyyy').format(pickedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Form Page', style: TextStyle(fontSize: 24)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Task Date (Menggunakan TextFormField)
                Form(
                  key: _key,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _dateController,
                        readOnly: true, // Mencegah input manual
                        decoration: InputDecoration(
                          labelText: "Task Date",
                          hintText: "Select a date",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.calendar_today,
                              color: Colors.blue,
                            ),
                            onPressed: _pickDate,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Task Name
                      TextFormField(
                        controller: _taskController,
                        decoration: InputDecoration(
                          labelText: "Task Name",
                          hintText: "Enter your task",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Submit Button
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purple,
                    ),
                    onPressed: _addTask,
                    child: const Text('Submit'),
                  ),
                ),
                const SizedBox(height: 20),

                // List Tasks
                const Text(
                  "List Tasks",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: _tasks.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey[200],
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _tasks[index]["task"],
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Deadline: ${DateFormat('dd-MM-yyyy').format(_tasks[index]["deadline"])}",
                                style: const TextStyle(color: Colors.blueGrey),
                              ),
                              const SizedBox(height: 5),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    _tasks[index]["isDone"]
                                        ? "Done"
                                        : "Not Done",
                                    style: TextStyle(
                                      color:
                                          _tasks[index]["isDone"]
                                              ? Colors.green
                                              : Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Checkbox(
                                    value: _tasks[index]["isDone"],
                                    activeColor: Colors.purple,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        _tasks[index]["isDone"] = value!;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

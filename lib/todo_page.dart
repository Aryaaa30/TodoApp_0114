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
  DateTime? _selectedDate;

  List<Map<String, dynamic>> _tasks = [];


  void _addTask() {
    if (_taskController.text.isEmpty || _selectedDate == null) {
      // Menampilkan SnackBar jika input kosong atau tanggal belum dipilih
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Task dan tanggal tidak boleh kosong!')),
      );
      return;
    }

    setState(() {
      _tasks.add({
        "task": _taskController.text,
        "isDone": false,
        "deadline": _selectedDate, // Simpan tanggal deadline
      });
      _taskController.clear();
      _selectedDate = null;
    });

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
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke halaman sebelumnya
          },
        ),
        title: const Text('Form Page', style: TextStyle(fontSize: 24)),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Form Input Task
              const Text(
                "Task Date:",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    _selectedDate == null
                        ? "Select a date"
                        : DateFormat('dd-MM-yyyy HH:mm').format(_selectedDate!),
                  ),
                  const SizedBox(width: 10),
                  IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.blue),
                    onPressed: _pickDate,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Form(
                key: _key,
                child: TextFormField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    labelText: "First Name",
                    hintText: "Enter your first name",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.purple),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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

              // Daftar Task
              const Text("List Tasks", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
                         )
                      )
                    )
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

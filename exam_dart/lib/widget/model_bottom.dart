import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ModalBottom extends StatelessWidget {
   ModalBottom({
    super.key,
    required this.addTask,
  });

  final Function addTask;
 
 TextEditingController taskController = TextEditingController();

  void _addTask(BuildContext context) {
    final task = taskController.text;
    addTask(task);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          children: [
            TextField(
              controller: taskController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Task',
                
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
              onPressed:() => _addTask(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 144, 141, 199),
              ),
              child: const Text(
                'Add task',
                
                ),
              ),
            ),
          ]
        ),
      ),
    );
  }
}
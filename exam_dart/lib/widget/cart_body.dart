import 'package:confirm_dialog/confirm_dialog.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CardBody extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  var task;
  // ignore: prefer_typing_uninitialized_variables
  var index;

   CardBody({
    super.key,
    required this.task,
    required this.deleteTask,
    required this.index,
    
  });
  final Function deleteTask;




  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 54,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: (index % 2 == 0) ? const Color.fromARGB(255, 144, 141, 199) : const Color.fromARGB(255, 152, 84, 77),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            task.title,
            style: const TextStyle(
              color: Color.fromARGB(255, 255, 255, 255),
              fontSize: 20,
            ),
          ),
          InkWell(
            onTap: () async {
            if (await confirm(context)) {
              deleteTask(task.id);
            }
             return;
          },
            child: const Icon(
              Icons.delete,
              color: Color.fromARGB(255, 255, 255, 255),
              ),
          ),
        ],
      ),
      ),
    );
  }
}
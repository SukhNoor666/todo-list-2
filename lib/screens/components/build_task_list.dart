import 'package:flutter/material.dart';
import 'package:myapp/models/task_model.dart';
import 'package:myapp/providers/task_provider.dart';

// task lists to show on screen
Widget buildTaskList(
  List<Task> tasks,
  Function(int) removeTask,
  Function(int, bool) updateTask,
) {
  return ListView.builder(
    shrinkWrap: true,
    physics:
        NeverScrollableScrollPhysics(), // function which makes list scrollable
    itemCount: tasks.length,
    itemBuilder: (context, index) {
      final task = tasks[index];
      final isEven = index % 2 == 0;

      return Padding(
        padding: const EdgeInsets.all(1.0), // creating space  around tasks
        child: ListTile(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          tileColor: isEven ? Colors.black : Colors.white,
          leading: Icon(
            // icon which can be checked when completed
            task.completed ? Icons.check_circle : Icons.circle_outlined,
          ),
          title: Text(
            task.name,
            style: TextStyle(
              decoration: task.completed ? TextDecoration.lineThrough : null,
            ),
          ),
          trailing: Row(
            children: [
              Checkbox(
                // checkbox to mark checked tasks
                value: task.completed,
                onChanged: (value) => updateTask(index, value!),
              ),
              IconButton(
                // delete button
                icon: Icon(Icons.delete),
                onPressed: () => removeTask(index), // click to delete tasks
              ),
            ],
          ),
        ),
      );
    },
  );
}

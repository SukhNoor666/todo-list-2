import 'package:flutter/material.dart';
import 'package:myapp/models/task_model.dart';
import 'package:myapp/services/task_service.dart';
import 'package:myapp/providers/task_provider.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:myapp/screens/components/build_task_list.dart';
import 'package:myapp/screens/components/build_add_task_section.dart';

// main screen of the app
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // the top most bar with title
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            // the rdp logo on the left
            Expanded(child: Image.asset('assets/rdplogo.png', height: 80)),
            Text(
              // title of the app on the right
              'Daily Planner',
              style: TextStyle(
                fontFamily: 'Caveat', // font for the title
                fontSize: 32,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      //side menu drawer on the left
      drawer: Drawer(),
      // the main content
      body: Column(
        children: [
          // importing a calendar
          TableCalendar(
            calendarFormat: CalendarFormat.month,
            focusedDay: DateTime.now(),
            firstDay: DateTime(2025),
            lastDay: DateTime(2027),
          ),
          // lists of tasks
          Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              return buildTaskList(
                taskProvider.tasks,
                taskProvider.removeTask,
                taskProvider.updateTask,
              );
            },
          ),
          // add task option
          Consumer<TaskProvider>(
            builder: (context, taskProvider, child) {
              return buildAddTaskSection(nameController, () async {
                await taskProvider.addTask(nameController.text);
                nameController.clear();
              });
            },
          ),
        ],
      ),
    );
  }
}

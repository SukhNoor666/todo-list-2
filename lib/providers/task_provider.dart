import 'package:provider/provider.dart';
import 'package:myapp/services/task_service.dart';

class TaskProvider extends ChangeNotifier {
  final TaskService taskService = TaskService();
}

import 'package:get/get.dart';
import 'package:todo_app/controler/controler.dart';

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<TodoControler>(TodoControler());
  }
}

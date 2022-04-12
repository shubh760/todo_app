import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../modals/task_modal.dart';

class TodoControler extends GetxController {
  var isLoading = false;
  var tasklist = <TaskModal>[];
  Future<void> addTodo(String task, bool isDone, String id) async {
    await FirebaseFirestore.instance
        .collection('todo')
        .doc(id != '' ? id : null)
        .set({
      'task': task,
      'isDone': isDone,
    }, SetOptions(merge: true)).then((value) => getdata());
  }

  Future<void> getdata() async {
    try {
      QuerySnapshot _taskSnap = await FirebaseFirestore.instance
          .collection('todo')
          .orderBy('task')
          .get();
      tasklist.clear();
      for (var item in _taskSnap.docs) {
        tasklist.add(
          TaskModal(
            item.id,
            item['task'],
            item['isDone'],
          ),
        );
        isLoading = false;
        update();
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void deleteTask(String id) {
    FirebaseFirestore.instance.collection('todo').doc(id).delete();
  }
}

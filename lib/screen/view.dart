import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app/controler/controler.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formkey = GlobalKey<FormState>();
  final _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoControler>(
        init: TodoControler(),
        initState: (_) {},
        builder: (todoControler) {
          todoControler.getdata();
          return Scaffold(
            body: Center(
              child: todoControler.isLoading
                  ? const SizedBox(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: todoControler.tasklist.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Checkbox(
                            onChanged: (value) => todoControler.addTodo(
                                todoControler.tasklist[index].task,
                                !todoControler.tasklist[index].done,
                                todoControler.tasklist[index].id),
                            value: todoControler.tasklist[index].done,
                          ),
                          title: Text(todoControler.tasklist[index].task),
                          trailing: SizedBox(
                            width: 100,
                            child: Row(
                              children: [
                                IconButton(
                                    onPressed: (() => addTaskDialouge(
                                        todoControler,
                                        'update',
                                        todoControler.tasklist[index].id,
                                        todoControler.tasklist[index].task)),
                                    icon: const Icon(Icons.edit)),
                                IconButton(
                                  onPressed: (() => todoControler.deleteTask(
                                      todoControler.tasklist[index].id)),
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
            ),
            floatingActionButton: FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () async =>
                  await addTaskDialouge(todoControler, 'add todo', '', ''),
            ),
          );
        });
  }

  addTaskDialouge(
      TodoControler todoControler, String title, String id, String task) async {
    if (task.isEmpty) {
      _textEditingController.text = task;
    }
    Get.defaultDialog(
        title: title,
        content: Form(
          key: _formkey,
          child: Column(
            children: [
              TextFormField(
                controller: _textEditingController,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "cannot be empty";
                  }
                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: (() async {
                    todoControler.addTodo(
                        _textEditingController.text.trim(), false, id);
                    _textEditingController.clear();
                    Get.back();
                  }),
                  child: const Text('save'))
            ],
          ),
        ));
  }
}

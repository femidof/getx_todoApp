import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_remix/controllers/todo_controller.dart';
import 'package:todo_app_remix/screens/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TodoController todoController = Get.put(TodoController());
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Get.to(TodoScreen());
        },
      ),
      appBar: AppBar(
        title: Text("GetX Todo List"),
      ),
      body: Container(
        child: Obx(() => ListView.separated(
              itemBuilder: (context, index) => Dismissible(
                key: UniqueKey(),
                onDismissed: (_) {
                  var removed = todoController.todos[index];
                  todoController.todos.removeAt(index);
                  Get.snackbar("Task removed",
                      "The task ${removed.text} was successfully removed",
                      mainButton: FlatButton(
                          onPressed: () {
                            if (removed.isNull) {
                              return;
                            }
                            todoController.todos.insert(index, removed);
                            removed = null;
                            if (Get.isSnackbarOpen) {
                              Get.back();
                            }
                          },
                          child: Text("Undo")));
                },
                child: ListTile(
                  title: Text(
                    todoController.todos[index].text,
                    style: (todoController.todos[index].done)
                        ? TextStyle(
                            color: Colors.red,
                            decoration: TextDecoration.lineThrough)
                        : TextStyle(
                            color: Theme.of(context).textTheme.bodyText1.color,
                          ),
                  ),
                  onTap: () {
                    Get.to(TodoScreen(
                      index: index,
                    ));
                  },
                  trailing: Icon(Icons.edit),
                  leading: Checkbox(
                    onChanged: (v) {
                      var changed = todoController.todos[index];
                      changed.done = v;
                      todoController.todos[index] = changed;
                    },
                    value: todoController.todos[index].done,
                  ),
                ),
              ),
              separatorBuilder: (_, __) => Divider(),
              itemCount: todoController.todos.length,
            )),
      ),
    );
  }
}

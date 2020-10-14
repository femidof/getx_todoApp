import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_app_remix/controllers/todo_controller.dart';
import 'package:todo_app_remix/models/todo.dart';

class TodoScreen extends StatelessWidget {
  final TodoController todoController = Get.find();
  final int index;
  TodoScreen({this.index});
  @override
  Widget build(BuildContext context) {
    String text = "";
    if (!this.index.isNull) {
      text = todoController.todos[index].text;
    }
    TextEditingController textEditingController = TextEditingController(
      text: text,
    );
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: [
              Expanded(
                  child: TextField(
                controller: textEditingController,
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "What do you want to accomplish",
                  hintStyle: TextStyle(
                    color: Colors.black38,
                  ),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 25,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: 999,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RaisedButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text("Cancel"),
                    color: Colors.red,
                  ),
                  RaisedButton(
                    onPressed: () {
                      if (this.index.isNull) {
                        todoController.todos
                            .add(Todo(text: textEditingController.text));
                      } else {
                        var editing = todoController.todos[index];
                        editing.text = textEditingController.text;
                        todoController.todos[index] = editing;
                      }
                      Get.back();
                    },
                    child: Text(this.index.isNull ? "Add" : "Edit"),
                    color: Colors.green,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

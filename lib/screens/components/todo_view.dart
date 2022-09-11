import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/todo_model.dart';

class TodoViewScreen extends StatefulWidget {
  TodoModel todo;
  int? idTodo;
  TodoViewScreen({Key? key, required this.todo, this.idTodo}) : super(key: key);

  @override
  State<TodoViewScreen> createState() => _TodoViewScreenState();
}

class _TodoViewScreenState extends State<TodoViewScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.todo != null) {
      _titleController.text = widget.todo.title;
      _descriptionController.text = widget.todo.description;
    }
  }

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      appBar: buildTodoViewScreenAppBar(context),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                child: CircleAvatar(
                  backgroundColor: Colors.black26,
                  child: Text(
                    '${widget.idTodo == null ? '_' : widget.idTodo}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                child: TextField(
                  cursorColor: Colors.black12,
                  controller: _titleController,
                  maxLines: 1,
                  maxLength: 10,
                  onChanged: (data) {
                    widget.todo.title = data;
                  },
                  style: const TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.white),
                    labelText: 'Title',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Container(
                child: TextField(
                  cursorColor: Colors.black12,
                  controller: _descriptionController,
                  maxLines: 5,
                  onChanged: (data) {
                    widget.todo.description = data;
                  },
                  style: const TextStyle(color: Colors.white),
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(color: Colors.white),
                    labelText: 'Description',
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                DateFormat('yyyy/MM/dd').format(
                  DateTime.now(),
                ),
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          padding: EdgeInsets.only(bottom: 10),
          height: kToolbarHeight,
          child: BottomAppBar(
            elevation: 0,
            color: Colors.transparent,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.amber.shade400,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              onPressed: () {
                Navigator.pop(context, widget.todo);
              },
              child: const Padding(
                padding:
                    EdgeInsets.only(left: 15, top: 10, bottom: 10, right: 15),
                child: Text('Save',
                    style: TextStyle(color: Colors.black, fontSize: 20)),
              ),
            ),
          ),
        ),
      ),
    );
  }

  AppBar buildTodoViewScreenAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: Icon(
          Icons.arrow_back_ios,
          color: Colors.black,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: Colors.transparent,
      title: Text(
        'Creare Todo',
        style: TextStyle(color: Colors.black),
      ),
    );
  }
}

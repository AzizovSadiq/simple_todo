import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/todo_model.dart';
import 'components/todo_view.dart';


class HomePageScreen extends StatefulWidget {
  HomePageScreen({Key? key}) : super(key: key);

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late SharedPreferences _prefs;
  List todosHome = [];

  @override
  void initState() {
    super.initState();
    setupTodo();
  }

  setupTodo() async {
    _prefs = await SharedPreferences.getInstance();
    String? stringTodo = _prefs.getString('todo');
    if (stringTodo != null) {
      List todoList = jsonDecode(stringTodo);
      for (var todo in todoList) {
        setState(() {
          todosHome.add(TodoModel(
            id: 0,
            title: '',
            description: '',
            status: false,
            dateTime: DateFormat('yyyy/MM/dd').format(
              DateTime.now(),
            ),
          ).fromJson(todo));
        });
      }
    }
  }

  void saveTodo() async {
    List items = await todosHome.map((e) => e.toJson()).toList();
    _prefs.setString('todo', jsonEncode(items));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent.shade400,
      appBar: buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ListView.builder(
            itemCount: todosHome.length,
            itemBuilder: (context, index) {
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white,
                child: InkWell(
                    onTap: () async {
                      TodoModel t = await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TodoViewScreen(
                              todo: todosHome[index], idTodo: index + 1),
                        ),
                      );
                      if (t != null) {
                        setState(() {
                          todosHome[index] = t;
                        });
                        saveTodo();
                      }
                    },
                    child: makeTodoListTile(todosHome[index], index)),
              );
            }),
      ),
    );
  }

  ListTile makeTodoListTile(TodoModel todo, int index) {
    return ListTile(
      leading: Container(
        child: InkWell(
          onTap: () {
            setState(() {
              todo.status = !todo.status;
            });
            saveTodo();
          },
          child: CircleAvatar(
            backgroundColor: Colors.black54,
            child: Icon(
              Icons.favorite,
              color: todo.status ? Colors.red : Colors.white,
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            todo.title,
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            width: 5,
          ),
          Text(
            todo.dateTime.toString(),
          ),
        ],
      ),
      subtitle: Text(
        todo.description,
        overflow: TextOverflow.clip,
        maxLines: 1,
        style: const TextStyle(
          color: Colors.black,
        ),
      ),
      trailing: IconButton(
        onPressed: () {
          delete(todo);
        },
        icon: const Icon(
          Icons.delete_forever_outlined,
          color: Colors.red,
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: Container(
        padding: const EdgeInsets.all(12),
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          child: Text(
            '${todosHome.length}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      centerTitle: true,
      title: Text('MyTodoList'),
      backgroundColor: Colors.transparent,
      elevation: 0,
      actions: [
        // Container(
        //   child: CircleAvatar(
        //     backgroundColor: Colors.black26,
        //     child: Text(
        //       '${todosHome.length}',
        //       style: const TextStyle(
        //           color: Colors.white,
        //           fontSize: 24,
        //           fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        IconButton(
          onPressed: () {
            addTodoModel();
          },
          icon: Container(
            child: const CircleAvatar(
              backgroundColor: Colors.transparent,
              child: Text(
                'add',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        )
      ],
    );
  }

  addTodoModel() async {
    int id = Random().nextInt(99);
    TodoModel t = TodoModel(
        id: id,
        title: '',
        description: '',
        status: false,
        dateTime: DateFormat('yyyy/MM/dd').format(DateTime.now()));
    TodoModel returnTodo = await Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => TodoViewScreen(
              todo: t,
            )));
    setState(() {
      todosHome.add(returnTodo);
    });
    saveTodo();
  }

  delete(TodoModel todo) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Alert'),
        content: Text('Are you sure to delete'),
        actions: [
          ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                Navigator.pop(_);
              },
              child: Text('No')),
          ElevatedButton(
              onPressed: () {
                setState(() {
                  todosHome.remove(todo);
                });
                Navigator.pop(_);
              },
              child: Text('Yes')),
        ],
      ),
    );
  }
}

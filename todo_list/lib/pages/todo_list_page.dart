import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/repositories/todo_repositories.dart';

import '../widgets/todo_list_item.dart';

class TodoListPage extends StatefulWidget {
  TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {

  List<Todo> todos = [];
  Todo? deletedTodo;
  int? deletedTodoPos;


  final TextEditingController todoControler = TextEditingController();
  final TodoRepository todoRepository = TodoRepository();

  String? errortext;


  @override
  void initState() {

    super.initState();

    todoRepository.getTodoList().then((value) {
      setState(() {
        todos = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: const Text('Lista de tarefas'),
          actions: const [
            Icon(
              Icons.task
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: todoControler,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Adicione uma Tarefa',
                          hintText: 'Ex. Estudar',
                          errorText: errortext,
                          labelStyle: const TextStyle(
                            color: Colors.teal,
                          ),
                          focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.teal,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(onPressed: () {
                      String text = todoControler.text;

                      if(text.trim() != ''){
                        setState(() {
                          Todo newTodo = Todo(
                            title: text.trim(),
                            dateTime: DateTime.now(),
                          );
                          todos.add(newTodo);
                          errortext = null;
                        });
                      } else {
                        setState(() {
                          errortext = 'Informe uma tarefa';
                        });
                      }
                      todoControler.clear();
                      todoRepository.saveTodoList(todos);
                    },
                      style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          padding: const EdgeInsets.all(14),
                      ),
                      child: const Icon(
                        Icons.add,
                        size: 30,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      for(Todo todo in todos)
                       TodoListItem(
                         todos: todo,
                         onDelete: onDelete,
                       ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Você possui ${todos.length} tarefas pendentes',
                      ),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                        onPressed: showDeleteTodosConfirmationDialog,
                        child: const Text('Limpar tudo'),
                          style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                          padding: const EdgeInsets.all(14,)
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ),
      ),
    );
  }

  void onDelete(Todo todo) {

    deletedTodo = todo;
    deletedTodoPos = todos.indexOf(todo);

    setState(() {
      todos.remove(todo);
    });
    todoRepository.saveTodoList(todos);
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          content: Text('Tarefa ${todo.title} foi removida com sucesso!',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          ),
        backgroundColor: const Color(0xff1e6348),
        action: SnackBarAction(
          label: 'Desfazer?',
          textColor: const Color(0xffffffff),
          onPressed: () {
            setState(() {
              todos.insert(deletedTodoPos!, deletedTodo!);
            });
            todoRepository.saveTodoList(todos);
          },
        ),
      ),
    );
  }

  void showDeleteTodosConfirmationDialog() {

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Remover todos os registros.'),
          content: Text('Você deseja remover todas as tarefas?'),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.of(context).pop();
                },
              style: TextButton.styleFrom(
                primary: Colors.teal,
              ),
                child: Text('Cancelar'),
            ),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  deleteAllTodos();
                },
              style: TextButton.styleFrom(
                primary: Colors.red,
              ),
                child: Text('Limpar tudo'),
            ),
          ],
        ),
    );
  }

  void deleteAllTodos() {

    setState(() {
      todos.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Todas as tarefas foram removidas com sucesso!',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: Color(0xff1e6348),
        ),
      );
    });
    todoRepository.saveTodoList(todos);
  }

}

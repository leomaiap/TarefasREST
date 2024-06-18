import 'package:flutter/material.dart';
import 'package:tarefas_rest/screen/novaTarefa.dart';
import 'package:tarefas_rest/widget/taskWidget.dart';

import '../model/task.dart';

class MostrarTarefas extends StatefulWidget {
  const MostrarTarefas({Key? key}) : super(key: key);

  @override
  State<MostrarTarefas> createState() => _MostrarTarefasState();
}

class _MostrarTarefasState extends State<MostrarTarefas> {

  List<Task> tasks = Task.mockTasks(); //subastituir pelo metodo fetch
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                Task task = tasks[index];
                return TaskWidget(task: task);
              },
            ),
          ),
          Container(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomCenter,
              child: FilledButton.tonalIcon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const NovaTarefa()),
                  );
                },
                label: Text('Criar Tarefa'),
                icon: Icon(Icons.add),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

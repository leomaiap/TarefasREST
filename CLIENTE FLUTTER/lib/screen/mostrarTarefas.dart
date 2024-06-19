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
  
   late Future<List<Task>> _futureTasks;

  @override
  void initState() {
    super.initState();
    _futureTasks = Task.mockTasks(); //substituir pelo metodo fetch da ApiService
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder<List<Task>>(
              future: _futureTasks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: const CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Erro: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('Nenhuma tarefa encontrada.'));
                } else {
                  List<Task> tasks = snapshot.data!;
                  return ListView.builder(
                    itemCount: tasks.length,
                    itemBuilder: (context, index) {
                      Task task = tasks[index];
                      return TaskWidget(task: task);
                    },
                  );
                }
              },
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const NovaTarefa()),
                );
              },
              child: const Text('Criar Tarefa'),
            ),
          ),
        ],
      ),
    );
  }
}
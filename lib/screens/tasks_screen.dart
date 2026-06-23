// ============================================================
// TELA 2 - TAREFAS
// Usa TabBarView com duas abas: Pendentes e Concluídas
// As listas são implementadas com ListView
// ============================================================

import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/task_card.dart';
import '../app_theme.dart';

class TasksScreen extends StatefulWidget {
  // Lista de tarefas passada pelo pai (HomeScreen)
  final List<Task> tasks;
  final VoidCallback onTasksChanged; // Notifica o pai quando uma tarefa muda

  const TasksScreen({
    super.key,
    required this.tasks,
    required this.onTasksChanged,
  });

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen>
    with SingleTickerProviderStateMixin {
  // Controlador do TabBar
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Inicializa o TabController com 2 abas
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  // Alterna o estado de conclusão de uma tarefa
  void _toggleTask(Task task) {
    setState(() {
      task.isCompleted = !task.isCompleted;
    });
    widget.onTasksChanged(); // Atualiza contadores no HomeScreen
  }

  @override
  Widget build(BuildContext context) {
    // Filtra tarefas por status
    final pending   = widget.tasks.where((t) => !t.isCompleted).toList();
    final completed = widget.tasks.where((t) => t.isCompleted).toList();

    return Column(
      children: [
        // --- TabBar: Pendentes e Concluídas ---
        Container(
          color: AppTheme.primaryDark,
          child: TabBar(
            controller: _tabController,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white54,
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            tabs: [
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Pendentes'),
                    const SizedBox(width: 6),
                    // Badge com contador
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.danger,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${pending.length}',
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
              Tab(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text('Concluídas'),
                    const SizedBox(width: 6),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 7, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppTheme.accent,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      child: Text(
                        '${completed.length}',
                        style: const TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // --- TabBarView: conteúdo de cada aba ---
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // ABA 1: Tarefas Pendentes - ListView
              _TaskList(
                tasks: pending,
                emptyMessage: 'Nenhuma tarefa pendente! 🎉',
                onToggle: _toggleTask,
              ),

              // ABA 2: Tarefas Concluídas - ListView
              _TaskList(
                tasks: completed,
                emptyMessage: 'Nenhuma tarefa concluída ainda.',
                onToggle: _toggleTask,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Widget auxiliar para a lista de tarefas (Pendentes ou Concluídas)
class _TaskList extends StatelessWidget {
  final List<Task> tasks;
  final String emptyMessage;
  final ValueChanged<Task> onToggle;

  const _TaskList({
    required this.tasks,
    required this.emptyMessage,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    if (tasks.isEmpty) {
      // Estado vazio: mensagem centralizada
      return Center(
        child: Text(
          emptyMessage,
          style: const TextStyle(color: AppTheme.textSub, fontSize: 15),
        ),
      );
    }

    // ListView com todas as tarefas filtradas
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8, bottom: 24),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskCard(
          task: tasks[index],
          onToggle: () => onToggle(tasks[index]),
        );
      },
    );
  }
}

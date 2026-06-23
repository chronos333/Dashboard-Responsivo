// ============================================================
// TELA 3 - DASHBOARD (Infográfico de Tarefas)
// GridView no topo com resumo + ListView de tarefas recentes
// ============================================================

import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/stats_grid.dart';
import '../widgets/task_card.dart';
import '../app_theme.dart';

class DashboardScreen extends StatelessWidget {
  final List<Task> tasks;
  final VoidCallback onTasksChanged;

  const DashboardScreen({
    super.key,
    required this.tasks,
    required this.onTasksChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Cálculos para os cards do GridView
    final total     = tasks.length;
    final pending   = tasks.where((t) => !t.isCompleted).length;
    final completed = tasks.where((t) => t.isCompleted).length;
    final highPrio  = tasks.where((t) => t.priority == 'Alta' && !t.isCompleted).length;

    // Próximo prazo (primeira tarefa pendente da lista — simplificado)
    final nextDeadline = tasks
        .where((t) => !t.isCompleted)
        .isNotEmpty
        ? tasks.firstWhere((t) => !t.isCompleted).deadline
        : '-';

    // Progresso de conclusão em porcentagem
    final progress = total > 0 ? (completed / total * 100).round() : 0;

    // Dados para o GridView
    final stats = [
      StatItem(
        label: 'Total de Tarefas',
        value: '$total',
        icon: Icons.list_alt,
        color: AppTheme.primary,
      ),
      StatItem(
        label: 'Pendentes',
        value: '$pending',
        icon: Icons.hourglass_empty,
        color: AppTheme.warning,
      ),
      StatItem(
        label: 'Concluídas',
        value: '$completed',
        icon: Icons.check_circle_outline,
        color: AppTheme.accent,
      ),
      StatItem(
        label: 'Alta Prioridade',
        value: '$highPrio',
        icon: Icons.priority_high,
        color: AppTheme.danger,
      ),
    ];

    // Tarefas pendentes com alta prioridade (exibidas em destaque)
    final urgentTasks = tasks
        .where((t) => !t.isCompleted && t.priority == 'Alta')
        .toList();

    return SingleChildScrollView(
      // SingleChildScrollView permite que todo o conteúdo role junto
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // --- Cabeçalho de boas-vindas ---
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryDark, AppTheme.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bom dia, Ana! 👋',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Próximo prazo: $nextDeadline',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.75), fontSize: 13),
                ),
                const SizedBox(height: 16),

                // Barra de progresso geral
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: LinearProgressIndicator(
                          value: total > 0 ? completed / total : 0,
                          minHeight: 8,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation(Colors.white),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      '$progress%',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$completed de $total tarefas concluídas',
                  style: TextStyle(
                      color: Colors.white.withOpacity(0.6), fontSize: 12),
                ),
              ],
            ),
          ),

          // --- GridView: Resumo de estatísticas ---
          const Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 4),
            child: Text(
              'RESUMO',
              style: TextStyle(
                fontSize: 11,
                fontWeight: FontWeight.w800,
                letterSpacing: 1.5,
                color: AppTheme.textSub,
              ),
            ),
          ),
          StatsGrid(items: stats),

          // --- ListView: Tarefas urgentes em destaque ---
          if (urgentTasks.isNotEmpty) ...[
            const Padding(
              padding: EdgeInsets.fromLTRB(16, 8, 16, 4),
              child: Text(
                'URGENTES',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.5,
                  color: AppTheme.textSub,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: urgentTasks.length,
              itemBuilder: (context, index) => TaskCard(
                task: urgentTasks[index],
                onToggle: () {
                  urgentTasks[index].isCompleted = true;
                  onTasksChanged();
                },
              ),
            ),
          ],

          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

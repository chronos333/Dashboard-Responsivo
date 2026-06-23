// ============================================================
// WIDGET REUTILIZÁVEL: Card de Tarefa
// Usado nas listas de Pendentes e Concluídas
// ============================================================

import 'package:flutter/material.dart';
import '../models/task.dart';
import '../app_theme.dart';

class TaskCard extends StatelessWidget {
  final Task task;
  final VoidCallback? onToggle; // Callback ao marcar/desmarcar

  const TaskCard({super.key, required this.task, this.onToggle});

  @override
  Widget build(BuildContext context) {
    final Color priorityColor = AppTheme.priorityColor(task.priority);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onToggle,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Checkbox visual (ícone)
              Container(
                margin: const EdgeInsets.only(top: 2, right: 14),
                child: Icon(
                  task.isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: task.isCompleted ? AppTheme.accent : AppTheme.textSub,
                  size: 24,
                ),
              ),

              // Conteúdo da tarefa
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Título
                    Text(
                      task.title,
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.textMain,
                        decoration: task.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                      ),
                    ),
                    const SizedBox(height: 4),
                    // Descrição
                    Text(
                      task.description,
                      style: const TextStyle(
                          fontSize: 13, color: AppTheme.textSub),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    // Metadados: responsável e prazo
                    Row(
                      children: [
                        const Icon(Icons.person_outline,
                            size: 13, color: AppTheme.textSub),
                        const SizedBox(width: 4),
                        Text(task.assignee,
                            style: const TextStyle(
                                fontSize: 12, color: AppTheme.textSub)),
                        const SizedBox(width: 12),
                        const Icon(Icons.calendar_today_outlined,
                            size: 13, color: AppTheme.textSub),
                        const SizedBox(width: 4),
                        Text(task.deadline,
                            style: const TextStyle(
                                fontSize: 12, color: AppTheme.textSub)),
                      ],
                    ),
                  ],
                ),
              ),

              // Badge de prioridade
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: priorityColor.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  task.priority,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: priorityColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

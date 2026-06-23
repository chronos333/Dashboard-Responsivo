// ============================================================
// TELA PRINCIPAL - HomeScreen
// Integra: Scaffold, AppBar, Drawer, BottomNavigationBar
// Controla qual tela exibir conforme a navegação inferior
// ============================================================

import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/app_drawer.dart';
import '../app_theme.dart';
import 'dashboard_screen.dart';
import 'tasks_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Índice da aba selecionada no BottomNavigationBar
  int _currentIndex = 0;

  // Lista de tarefas compartilhada entre as telas
  // É mantida aqui (estado "pai") para que Dashboard e Tasks compartilhem os dados
  final List<Task> _tasks = List.from(sampleTasks);

  // Títulos da AppBar por tela
  final List<String> _titles = ['Dashboard', 'Tarefas', 'Configurações'];

  // Quantidade de notificações não lidas (simulado)
  int _notificationCount = 3;

  // Exibe painel de notificações simplificado
  void _showNotifications() {
    setState(() => _notificationCount = 0); // Marca como lidas
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Notificações',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppTheme.textMain)),
            const SizedBox(height: 16),
            _NotifItem(
              icon: Icons.warning_amber,
              color: AppTheme.danger,
              text: 'Tarefa "Correção de bug #2041" vence amanhã!',
            ),
            _NotifItem(
              icon: Icons.check_circle,
              color: AppTheme.accent,
              text: 'Tarefa "Deploy versão 3.2" foi concluída.',
            ),
            _NotifItem(
              icon: Icons.person_add,
              color: AppTheme.primary,
              text: 'Novo colaborador adicionado ao projeto.',
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  // Reconstrói a tela quando uma tarefa muda (atualiza o dashboard)
  void _onTaskChanged() => setState(() {});

  @override
  Widget build(BuildContext context) {
    // Telas mapeadas por índice
    // OBS: TasksScreen fica no índice 1; DashboardScreen no índice 0
    final List<Widget> screens = [
      DashboardScreen(
        tasks: _tasks,
        onTasksChanged: _onTaskChanged,
      ),
      TasksScreen(
        tasks: _tasks,
        onTasksChanged: _onTaskChanged,
      ),
      const SettingsScreen(),
    ];

    return Scaffold(
      // ── AppBar ──────────────────────────────────────────
      appBar: AppBar(
        title: Text(_titles[_currentIndex]),
        actions: [
          // Ícone de notificações com badge
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                tooltip: 'Notificações',
                onPressed: _showNotifications,
              ),
              if (_notificationCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: const BoxDecoration(
                      color: AppTheme.danger,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$_notificationCount',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 4),
        ],
      ),

      // ── Drawer (Menu Lateral) ────────────────────────────
      drawer: AppDrawer(
        currentIndex: _currentIndex == 2 ? 1 : 0,
        onSelect: (index) {
          // 0 = Dashboard, 1 = Configurações
          setState(() => _currentIndex = index == 0 ? 0 : 2);
        },
      ),

      // ── Corpo: troca entre as telas ──────────────────────
      body: IndexedStack(
        // IndexedStack mantém o estado das telas ao trocar de aba
        index: _currentIndex,
        children: screens,
      ),

      // ── BottomNavigationBar ──────────────────────────────
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: AppTheme.textSub,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.task_outlined),
            activeIcon: Icon(Icons.task),
            label: 'Tarefas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}

// Item de notificação no modal
class _NotifItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const _NotifItem({
    required this.icon,
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: color, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(text,
                style:
                    const TextStyle(fontSize: 13, color: AppTheme.textMain)),
          ),
        ],
      ),
    );
  }
}

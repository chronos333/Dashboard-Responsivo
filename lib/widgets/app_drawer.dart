// ============================================================
// WIDGET: Drawer (Menu Lateral)
// Exibe links de navegação: Dashboard, Configurações, Ajuda
// ============================================================

import 'package:flutter/material.dart';
import '../app_theme.dart';

class AppDrawer extends StatelessWidget {
  // Índice da tela atualmente selecionada (para destacar o item ativo)
  final int currentIndex;
  final ValueChanged<int> onSelect;

  const AppDrawer({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          // --- Cabeçalho do Drawer ---
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [AppTheme.primaryDark, AppTheme.primary],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 14),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ana Paula',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    Text(
                      'ana@technova.com.br',
                      style: TextStyle(
                          color: Colors.white.withOpacity(0.7), fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // --- Itens de navegação ---
          _DrawerItem(
            icon: Icons.dashboard_outlined,
            label: 'Dashboard',
            isActive: currentIndex == 0,
            onTap: () {
              Navigator.pop(context); // Fecha o drawer
              onSelect(0);
            },
          ),
          _DrawerItem(
            icon: Icons.settings_outlined,
            label: 'Configurações',
            isActive: currentIndex == 1,
            onTap: () {
              Navigator.pop(context);
              onSelect(1);
            },
          ),
          _DrawerItem(
            icon: Icons.help_outline,
            label: 'Ajuda',
            isActive: false,
            onTap: () {
              Navigator.pop(context);
              // Exibe um diálogo simples de ajuda
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text('Ajuda'),
                  content: const Text(
                      'TaskFlow v1.0\nPara suporte, contate:\nsuporte@technova.com.br'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Fechar'),
                    ),
                  ],
                ),
              );
            },
          ),

          const Spacer(),
          const Divider(),

          // --- Rodapé: Sair ---
          ListTile(
            leading: const Icon(Icons.logout, color: AppTheme.danger),
            title: const Text('Sair',
                style: TextStyle(color: AppTheme.danger, fontWeight: FontWeight.w600)),
            onTap: () => Navigator.of(context).popUntil((r) => r.isFirst),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

// Item individual do menu lateral
class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon,
          color: isActive ? AppTheme.primary : AppTheme.textSub),
      title: Text(
        label,
        style: TextStyle(
          fontWeight: isActive ? FontWeight.w700 : FontWeight.normal,
          color: isActive ? AppTheme.primary : AppTheme.textMain,
        ),
      ),
      tileColor: isActive ? AppTheme.primary.withOpacity(0.08) : null,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
      onTap: onTap,
    );
  }
}

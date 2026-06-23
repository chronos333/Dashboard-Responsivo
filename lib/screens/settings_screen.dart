// ============================================================
// TELA - CONFIGURAÇÕES
// Tela simples de configurações do perfil e notificações
// ============================================================

import 'package:flutter/material.dart';
import '../app_theme.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Variáveis de configuração (booleanos controlam os switches)
  bool _notificationsEnabled = true;
  bool _emailAlerts          = false;
  bool _darkMode             = false;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // --- Card de Perfil ---
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppTheme.primary,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Ana Paula Souza',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                          color: AppTheme.textMain),
                    ),
                    const SizedBox(height: 2),
                    Text('Desenvolvedora',
                        style: TextStyle(color: AppTheme.textSub)),
                    Text('ana@technova.com.br',
                        style: TextStyle(
                            color: AppTheme.primary, fontSize: 12)),
                  ],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 20),

        // --- Seção: Notificações ---
        _SectionTitle(title: 'NOTIFICAÇÕES'),
        Card(
          child: Column(
            children: [
              SwitchListTile(
                title: const Text('Notificações push'),
                subtitle: const Text('Receber alertas no celular'),
                value: _notificationsEnabled,
                activeColor: AppTheme.primary,
                onChanged: (v) => setState(() => _notificationsEnabled = v),
              ),
              const Divider(height: 1),
              SwitchListTile(
                title: const Text('Alertas por e-mail'),
                subtitle: const Text('Resumo diário de tarefas'),
                value: _emailAlerts,
                activeColor: AppTheme.primary,
                onChanged: (v) => setState(() => _emailAlerts = v),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),

        // --- Seção: Aparência ---
        _SectionTitle(title: 'APARÊNCIA'),
        Card(
          child: SwitchListTile(
            title: const Text('Modo escuro'),
            subtitle: const Text('(Em desenvolvimento)'),
            value: _darkMode,
            activeColor: AppTheme.primary,
            onChanged: (v) => setState(() => _darkMode = v),
          ),
        ),
        const SizedBox(height: 20),

        // --- Seção: Sobre ---
        _SectionTitle(title: 'SOBRE'),
        Card(
          child: Column(
            children: [
              ListTile(
                leading: const Icon(Icons.info_outline, color: AppTheme.primary),
                title: const Text('Versão do app'),
                trailing: const Text('1.0.0',
                    style: TextStyle(color: AppTheme.textSub)),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.business, color: AppTheme.primary),
                title: const Text('TechNova Soluções Digitais'),
                subtitle: const Text('contato@technova.com.br'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// Título de seção reutilizável
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.5,
          color: AppTheme.textSub,
        ),
      ),
    );
  }
}

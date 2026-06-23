// ============================================================
// MAIN.DART - Ponto de entrada do aplicativo TaskFlow
// ============================================================

import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/login_screen.dart';

void main() {
  // runApp inicializa o aplicativo Flutter
  runApp(const TaskFlowApp());
}

class TaskFlowApp extends StatelessWidget {
  const TaskFlowApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TaskFlow',
      debugShowCheckedModeBanner: false, // Remove a faixa de debug
      theme: AppTheme.theme,             // Aplica o tema global definido em app_theme.dart
      home: const LoginScreen(),         // Tela inicial: Login
    );
  }
}

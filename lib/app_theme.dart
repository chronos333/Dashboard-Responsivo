// ============================================================
// TEMA GLOBAL DO APLICATIVO - TaskFlow
// Define cores, fontes e estilos padrão
// ============================================================

import 'package:flutter/material.dart';

class AppTheme {
  // Paleta de cores principal
  static const Color primary     = Color(0xFF2563EB); // Azul principal
  static const Color primaryDark = Color(0xFF1E40AF); // Azul escuro (AppBar/Drawer)
  static const Color accent      = Color(0xFF10B981); // Verde (concluídas)
  static const Color warning     = Color(0xFFF59E0B); // Amarelo (média prioridade)
  static const Color danger      = Color(0xFFEF4444); // Vermelho (alta prioridade)
  static const Color surface     = Color(0xFFF8FAFC); // Fundo claro
  static const Color cardBg      = Color(0xFFFFFFFF);
  static const Color textMain    = Color(0xFF1E293B);
  static const Color textSub     = Color(0xFF64748B);

  // Retorna o ThemeData configurado para o app
  static ThemeData get theme => ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: primary,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: primaryDark,
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        letterSpacing: -0.3,
      ),
    ),
    drawerTheme: const DrawerThemeData(
      backgroundColor: cardBg,
    ),
    scaffoldBackgroundColor: surface,
    cardTheme: CardTheme(
      color: cardBg,
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );

  // Retorna cor conforme prioridade da tarefa
  static Color priorityColor(String priority) {
    switch (priority) {
      case 'Alta':   return danger;
      case 'Média':  return warning;
      default:       return accent;
    }
  }
}

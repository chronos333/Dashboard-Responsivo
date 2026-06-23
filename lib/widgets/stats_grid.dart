// ============================================================
// WIDGET: GridView de Resumo (Infográfico de Tarefas)
// Exibe cards com estatísticas no topo da tela de dashboard
// ============================================================

import 'package:flutter/material.dart';
import '../app_theme.dart';

// Modelo simples para cada card do grid
class StatItem {
  final String label;
  final String value;
  final IconData icon;
  final Color color;

  const StatItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.color,
  });
}

class StatsGrid extends StatelessWidget {
  final List<StatItem> items;

  const StatsGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: GridView.builder(
        // Desabilita o scroll interno (o pai faz o scroll)
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,       // 2 colunas
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.55,  // Proporção largura/altura de cada card
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return _StatCard(item: item);
        },
      ),
    );
  }
}

// Card individual do grid
class _StatCard extends StatelessWidget {
  final StatItem item;
  const _StatCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppTheme.cardBg,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: item.color.withOpacity(0.12),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Ícone com fundo colorido
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: item.color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(item.icon, color: item.color, size: 20),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Número em destaque
              Text(
                item.value,
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w800,
                  color: item.color,
                  letterSpacing: -0.5,
                ),
              ),
              Text(
                item.label,
                style: const TextStyle(
                    fontSize: 12, color: AppTheme.textSub),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

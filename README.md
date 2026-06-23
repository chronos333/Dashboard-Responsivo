# TaskFlow — Dashboard Responsivo em Flutter

Aplicativo de gerenciamento de tarefas corporativas desenvolvido como entrega do Desafio Profissional Inicial.

## Como rodar

```bash
flutter pub get
flutter run
```

## Estrutura de arquivos

```
lib/
├── main.dart                    # Ponto de entrada
├── app_theme.dart               # Paleta de cores e ThemeData global
├── models/
│   └── task.dart                # Modelo Task + dados fictícios
├── screens/
│   ├── login_screen.dart        # Tela 1 – Login / Apresentação
│   ├── home_screen.dart         # Scaffold principal (AppBar, Drawer, BottomNav)
│   ├── dashboard_screen.dart    # Tela 3 – GridView + progresso
│   ├── tasks_screen.dart        # Tela 2 – TabBarView (Pendentes / Concluídas)
│   └── settings_screen.dart     # Tela de Configurações
└── widgets/
    ├── app_drawer.dart          # Drawer reutilizável
    ├── task_card.dart           # Card de tarefa reutilizável
    └── stats_grid.dart          # GridView de estatísticas
```

## Widgets de Estrutura utilizados

| Widget | Onde | Função |
|---|---|---|
| `Scaffold` | `home_screen.dart` | Estrutura base de toda a tela |
| `AppBar` | `home_screen.dart` | Título + ícone de notificações com badge |
| `Drawer` | `app_drawer.dart` | Menu lateral com links e perfil do usuário |
| `BottomNavigationBar` | `home_screen.dart` | Navegação entre Dashboard, Tarefas e Configurações |
| `TabBar + TabBarView` | `tasks_screen.dart` | Divide tarefas em Pendentes e Concluídas |
| `GridView` | `stats_grid.dart` | Cards de resumo (total, pendentes, concluídas, urgentes) |
| `ListView` | `tasks_screen.dart` | Lista de tarefas em cada aba |

## Fluxo de navegação

```
LoginScreen
    └─► HomeScreen (Scaffold)
            ├── AppBar (título dinâmico + notificações)
            ├── Drawer → Dashboard / Configurações / Ajuda
            ├── BottomNavigationBar
            │       ├── [0] DashboardScreen (GridView + ListView urgentes)
            │       ├── [1] TasksScreen (TabBarView → ListView × 2)
            │       └── [2] SettingsScreen (ListView de opções)
            └── IndexedStack (mantém estado ao trocar abas)
```

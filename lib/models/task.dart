// ============================================================
// MODELO DE DADOS: Tarefa
// Representa uma tarefa corporativa do sistema
// ============================================================

class Task {
  final String id;
  final String title;
  final String description;
  final String assignee;   // Responsável
  final String deadline;   // Prazo (data formatada)
  final String priority;   // 'Alta', 'Média', 'Baixa'
  bool isCompleted;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.assignee,
    required this.deadline,
    required this.priority,
    this.isCompleted = false,
  });
}

// ============================================================
// DADOS FICTÍCIOS para popular o app
// ============================================================
final List<Task> sampleTasks = [
  Task(
    id: '1',
    title: 'Revisar relatório Q2',
    description: 'Revisar e aprovar o relatório financeiro do segundo trimestre.',
    assignee: 'Ana Paula',
    deadline: '28/06/2026',
    priority: 'Alta',
  ),
  Task(
    id: '2',
    title: 'Reunião com cliente XYZ',
    description: 'Apresentar proposta de novo contrato de suporte.',
    assignee: 'Carlos Lima',
    deadline: '30/06/2026',
    priority: 'Alta',
  ),
  Task(
    id: '3',
    title: 'Atualizar documentação API',
    description: 'Documentar os novos endpoints da versão 3.2.',
    assignee: 'Fernanda Costa',
    deadline: '05/07/2026',
    priority: 'Média',
  ),
  Task(
    id: '4',
    title: 'Onboarding novo estagiário',
    description: 'Preparar materiais e agendar treinamentos iniciais.',
    assignee: 'Roberto Alves',
    deadline: '07/07/2026',
    priority: 'Média',
  ),
  Task(
    id: '5',
    title: 'Correção de bug #2041',
    description: 'Resolver erro de autenticação reportado em produção.',
    assignee: 'Ana Paula',
    deadline: '25/06/2026',
    priority: 'Alta',
  ),
  Task(
    id: '6',
    title: 'Deploy versão 3.2',
    description: 'Publicar nova versão em ambiente de produção.',
    assignee: 'Carlos Lima',
    deadline: '10/07/2026',
    priority: 'Baixa',
    isCompleted: true,
  ),
  Task(
    id: '7',
    title: 'Pesquisa de satisfação',
    description: 'Enviar formulário de NPS para clientes ativos.',
    assignee: 'Fernanda Costa',
    deadline: '15/07/2026',
    priority: 'Baixa',
    isCompleted: true,
  ),
  Task(
    id: '8',
    title: 'Renovação de licenças',
    description: 'Renovar licenças de software da equipe de design.',
    assignee: 'Roberto Alves',
    deadline: '20/06/2026',
    priority: 'Alta',
    isCompleted: true,
  ),
];

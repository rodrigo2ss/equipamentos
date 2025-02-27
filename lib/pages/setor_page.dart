import 'package:controle_ti/providers/equipamento_provider.dart';
import 'package:controle_ti/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:controle_ti/widgets/equipamento_card.dart';

class SetorPage extends ConsumerWidget {
  final String setorNome;

  const SetorPage({super.key, required this.setorNome});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final equipamentos = ref.watch(equipamentoProvider);
    final equipamentosDoSetor = equipamentos
        .where((equip) => equip.setor.toUpperCase() == setorNome.toUpperCase())
        .toList();

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Setor: $setorNome',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Ação ao pressionar notificações
            },
          ),
        ],
      ),
      backgroundColor:
          const Color(0xFFF5F5F5), // Fundo suave para um visual moderno

      body: Column(
        children: [
          const SizedBox(height: 16),

          // Lista de equipamentos
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: equipamentosDoSetor.isEmpty
                  ? const Center(
                      child: Text(
                        "Nenhum equipamento cadastrado neste setor.",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    )
                  : LayoutBuilder(
                      builder: (context, constraints) {
                        int crossAxisCount = constraints.maxWidth > 600
                            ? 3
                            : 2; // 3 colunas em telas grandes
                        return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: crossAxisCount,
                            childAspectRatio: 1,
                            crossAxisSpacing: 12,
                            mainAxisSpacing: 12,
                          ),
                          itemCount: equipamentosDoSetor.length,
                          itemBuilder: (context, index) {
                            final equipamento = equipamentosDoSetor[index];
                            return EquipamentoCard(equipamento: equipamento);
                          },
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:controle_ti/pages/cadastro_pc_note_page.dart';
import 'package:controle_ti/pages/cadastro_eqp_page.dart';
import 'package:controle_ti/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:controle_ti/pages/setor_page.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  static const List<Map<String, String>> setores = [
    {"nome": "ADMINISTRATIVO", "icone": "business"},
    {"nome": "ESTOQUE", "icone": "inventory"},
    {"nome": "COMERCIAL", "icone": "storefront"},
    {"nome": "INFORMÁTICA", "icone": "computer"},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'Controle de Equipamentos',
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Ação ao pressionar notificações
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: LayoutBuilder(
          builder: (context, constraints) {
            int crossAxisCount = constraints.maxWidth > 600 ? 3 : 2;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1.2,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: setores.length,
              itemBuilder: (context, index) {
                final setor = setores[index];

                final Map<String, IconData> icones = {
                  "business": Icons.business,
                  "inventory": Icons.inventory,
                  "storefront": Icons.storefront,
                  "computer": Icons.computer,
                };
                final iconData = icones[setor["icone"]] ?? Icons.help;

                return _buildSetorCard(
                  context,
                  setor["nome"] ?? "Indefinido",
                  iconData,
                  index,
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _mostrarModalEscolha(context),
        icon: const Icon(
          Icons.add_circle_sharp,
          color: Colors.white,
        ),
        label: const Text(
          'Adicionar Equipamento',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.green,
        elevation: 6,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
    );
  }

  // 🔹 Modal para escolher o tipo de cadastro
  void _mostrarModalEscolha(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Escolha o tipo de cadastro",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(Icons.desktop_mac, color: Colors.blue),
                title: const Text("Cadastro de PC/Notebook"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CadastroPcNotePage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(Icons.devices_other, color: Colors.green),
                title: const Text("Cadastro de Equipamento"),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CadastroEqpPage()),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // 🔹 Widget para criar os cartões dos setores
  Widget _buildSetorCard(
      BuildContext context, String nome, IconData icon, int index) {
    final List<List<Color>> gradients = [
      [Colors.blue.shade400, Colors.blue.shade600],
      [Colors.green.shade400, Colors.green.shade600],
      [Colors.orange.shade400, Colors.orange.shade600],
      [Colors.red.shade400, Colors.red.shade600],
    ];

    final gradientColors = gradients[index % gradients.length];

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SetorPage(setorNome: nome),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              // ignore: deprecated_member_use
              color: Colors.black.withOpacity(0.15),
              blurRadius: 6,
              offset: const Offset(2, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 50, color: Colors.white),
            const SizedBox(height: 10),
            Text(
              nome,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

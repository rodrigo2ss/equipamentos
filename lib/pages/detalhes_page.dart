import 'package:controle_ti/models/equipamento.dart';
import 'package:controle_ti/pages/cadastro_pc_note_page.dart';
import 'package:controle_ti/pages/cadastro_eqp_page.dart';
import 'package:controle_ti/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class DetalhesPage extends StatelessWidget {
  final Equipamento equipamento;

  const DetalhesPage({super.key, required this.equipamento});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: equipamento.tipo.isNotEmpty ? equipamento.tipo : "Detalhes",
        actions: [
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.white),
            onPressed: () {
              _abrirTelaEdicao(context);
            },
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(2, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoRow(Icons.device_hub, "Tipo", equipamento.tipo),
                _infoRow(
                    Icons.calendar_today, "Ano", equipamento.ano.toString()),
                _infoRow(Icons.apartment, "Setor", equipamento.setor),
                _infoRow(Icons.person, "Responsável",
                    equipamento.usuarioResponsavel),
                _infoRow(Icons.computer, "Sistema Operacional",
                    equipamento.sistemaOperacional),

                const SizedBox(height: 16),

                // 🔹 Exibir Programas Instalados
                if (equipamento.programasInstalados.isNotEmpty) ...[
                  const Text("📂 Programas Instalados",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...equipamento.programasInstalados
                      .map((programa) => _itemLista(programa)),
                  const SizedBox(height: 16),
                ],

                // 🔹 Exibir Assinaturas
                if (equipamento.assinaturasSelecionadas.isNotEmpty) ...[
                  const Text("📝 Assinaturas",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  ...equipamento.assinaturasSelecionadas
                      .map((assinatura) => _itemLista(assinatura)),
                  const SizedBox(height: 16),
                ],

                // 🔹 Exibir Ficha Técnica
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    // ignore: deprecated_member_use
                    color: Colors.blueAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("🔧 Especificações Técnicas",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 18)),
                      _infoRow(
                          Icons.memory,
                          "Processador",
                          equipamento.fichaTecnica['processador'] ??
                              'Não informado'),
                      _infoRow(Icons.storage, "RAM",
                          equipamento.fichaTecnica['ram'] ?? 'Não informado'),
                      _infoRow(
                          Icons.sd_storage,
                          "Armazenamento",
                          equipamento.fichaTecnica['armazenamento'] ??
                              'Não informado'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _abrirTelaEdicao(BuildContext context) {
    Widget paginaEdicao;

    // Se for PC/Notebook, abre CadastroPcNotePage
    if (equipamento.tipo.toLowerCase().contains("pc") ||
        equipamento.tipo.toLowerCase().contains("notebook")) {
      paginaEdicao = CadastroPcNotePage(equipamento: equipamento);
    } else {
      // Caso contrário, abre CadastroEqpPage
      paginaEdicao = CadastroEqpPage(equipamento: equipamento);
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => paginaEdicao),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, color: Colors.blueAccent, size: 22),
          const SizedBox(width: 10),
          Expanded(
              child: Text("$label: $value",
                  style: const TextStyle(fontSize: 16, color: Colors.black87))),
        ],
      ),
    );
  }

  Widget _itemLista(String item) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text("- $item", style: const TextStyle(fontSize: 16)),
    );
  }
}

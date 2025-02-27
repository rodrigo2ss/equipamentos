import 'package:controle_ti/models/equipamento.dart';
import 'package:controle_ti/providers/equipamento_provider.dart';
import 'package:controle_ti/widgets/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CadastroPcNotePage extends ConsumerStatefulWidget {
  final Equipamento? equipamento;
  const CadastroPcNotePage({super.key, this.equipamento});

  @override
  CadastroPcNotePageState createState() => CadastroPcNotePageState();
}

class CadastroPcNotePageState extends ConsumerState<CadastroPcNotePage> {
  final _formKey = GlobalKey<FormState>();

  // 🔹 Controladores de Texto
  final _tipoController = TextEditingController();
  final _marcaController = TextEditingController();
  final _modeloController = TextEditingController();
  final _anoController = TextEditingController();
  final _usuarioController = TextEditingController();
  final _responsavelSetorController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _processadorController = TextEditingController();
  final _ramController = TextEditingController();
  final _armazenamentoController = TextEditingController();
  final _localizacaoController = TextEditingController();
  final _nomeController = TextEditingController();

  // 🔹 Variáveis de Seleção
  String? _setorSelecionado;
  String? _sistemaOperacionalSelecionado;
  final List<String> _programasSelecionados = [];
  final List<String> _assinaturasSelecionadas = [];

  bool _isSaving = false;
  final bool _mostrarProgramas = true;

  // 🔹 Listas de Seleção
  final List<String> _setores = [
    'Administrativo',
    'Estoque',
    'Comercial',
    'Informática'
  ];
  final List<String> _sistemasOperacionais = [
    'Windows 10',
    'Windows 11',
    'MacOS',
    'Linux'
  ];
  final List<String> _programasDisponiveis = [
    'Google Chrome',
    'Microsoft Office',
    'Adobe Photoshop',
    'Figma',
    'VS Code',
    'LibreOffice'
  ];
  final List<String> _assinaturasDisponiveis = [
    'Gridtec',
    'Cronos Tecnologia',
    'GM Soluções',
    'Ks Tecnologia',
    'Staff Projetos'
  ];

  @override
  void dispose() {
    _tipoController.dispose();
    _marcaController.dispose();
    _modeloController.dispose();
    _anoController.dispose();
    _usuarioController.dispose();
    _responsavelSetorController.dispose();
    _descricaoController.dispose();
    _processadorController.dispose();
    _ramController.dispose();
    _armazenamentoController.dispose();
    _localizacaoController.dispose();
    _nomeController.dispose();
    super.dispose();
  }

  Future<void> _salvarEquipamento() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final equipamentoNotifier = ref.read(equipamentoProvider.notifier);

      int? ano = int.tryParse(_anoController.text);
      if (ano == null) {
        throw FormatException("O campo 'Ano' deve ser um número válido.");
      }

      final novoEquipamento = Equipamento(
        id: 0,
        tipo: _tipoController.text,
        marca: _marcaController.text,
        modelo: _modeloController.text,
        ano: ano,
        localizacao: _localizacaoController.text,
        nome: _nomeController.text,
        usuarioResponsavel: _usuarioController.text,
        setor: _setorSelecionado ?? '',
        responsavelSetor: _responsavelSetorController.text,
        sistemaOperacional: _sistemaOperacionalSelecionado ?? '',
        descricao: _descricaoController.text,
        programasInstalados: _programasSelecionados,
        assinaturasSelecionadas: _assinaturasSelecionadas,
        fichaTecnica: {
          'processador': _processadorController.text,
          'ram': _ramController.text,
          'armazenamento': _armazenamentoController.text,
        },
      );

      await equipamentoNotifier.adicionarEquipamento(novoEquipamento);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Equipamento cadastrado com sucesso!")),
        );
        Navigator.pop(context, true);
      }
    } catch (e) {
      if (kDebugMode) print(" Erro ao salvar equipamento: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao salvar: $e")),
        );
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {TextInputType type = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.white,
        prefixIcon: const Icon(Icons.computer),
      ),
      keyboardType: type,
      validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      // appBar: AppBar(
      //   title: const Text('Cadastrar Equipamento'),
      // ),
      appBar: CustomAppBar(title: 'Cadastrar Equipamento'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(5),
        child: Card(
          color: Colors.blueAccent.shade100,
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("📋 Informações do Equipamento",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  _buildTextField(_tipoController, 'Tipo (Notebook/PC)'),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                          child: _buildTextField(_marcaController, 'Marca')),
                      const SizedBox(width: 10),
                      Expanded(
                          child: _buildTextField(_modeloController, 'Modelo')),
                    ],
                  ),
                  const SizedBox(height: 10),
                  _buildTextField(_anoController, 'Ano',
                      type: TextInputType.number),
                  const SizedBox(height: 10),
                  _buildTextField(_usuarioController, 'Usuário Responsável'),
                  const SizedBox(height: 10),
                  _buildTextField(_descricaoController, 'Descrição'),
                  const SizedBox(height: 20),
                  const Text("⚙️ Configuração Técnica",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  _buildTextField(_processadorController, 'Processador'),
                  const SizedBox(height: 10),
                  _buildTextField(_ramController, 'Memória RAM'),
                  const SizedBox(height: 10),
                  _buildTextField(_armazenamentoController, 'Armazenamento'),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Setor'),
                    value: _setorSelecionado,
                    items: _setores
                        .map((setor) =>
                            DropdownMenuItem(value: setor, child: Text(setor)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _setorSelecionado = value),
                    validator: (value) =>
                        value == null ? 'Campo obrigatório' : null,
                  ),
                  const SizedBox(height: 10),
                  DropdownButtonFormField<String>(
                    decoration:
                        const InputDecoration(labelText: 'Sistema Operacional'),
                    value: _sistemaOperacionalSelecionado,
                    items: _sistemasOperacionais
                        .map((so) =>
                            DropdownMenuItem(value: so, child: Text(so)))
                        .toList(),
                    onChanged: (value) =>
                        setState(() => _sistemaOperacionalSelecionado = value),
                    validator: (value) =>
                        value == null ? 'Campo obrigatório' : null,
                  ),
                  const SizedBox(height: 20),
                  if (_mostrarProgramas) ...[
                    const Text("📂 Programas Instalados",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Column(
                      children: _programasDisponiveis.map((programa) {
                        return CheckboxListTile(
                          title: Text(programa),
                          value: _programasSelecionados.contains(programa),
                          onChanged: (checked) {
                            setState(() {
                              checked!
                                  ? _programasSelecionados.add(programa)
                                  : _programasSelecionados.remove(programa);
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 20),
                  ],
                  // 🔹 Checkbox para Assinaturas
                  const Text("📝 Assinaturas:",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Column(
                    children: _assinaturasDisponiveis.map((assinatura) {
                      return CheckboxListTile(
                        title: Text(assinatura),
                        value: _assinaturasSelecionadas.contains(assinatura),
                        onChanged: (checked) {
                          setState(() {
                            checked!
                                ? _assinaturasSelecionadas.add(assinatura)
                                : _assinaturasSelecionadas.remove(assinatura);
                          });
                        },
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width:
                          double.infinity, // Faz o botão ocupar toda a largura
                      child: ElevatedButton.icon(
                        onPressed: _isSaving ? null : _salvarEquipamento,
                        icon: _isSaving
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    color: Colors.white, strokeWidth: 2),
                              )
                            : const Icon(Icons.save, color: Colors.blueAccent),
                        label: const Text(
                          "Salvar Equipamento",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.blueAccent,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          elevation: 5, // Adiciona sombra ao botão
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

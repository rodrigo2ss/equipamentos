import 'package:controle_ti/models/equipamento.dart';
import 'package:controle_ti/providers/equipamento_provider.dart';
import 'package:controle_ti/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CadastroEqpPage extends ConsumerStatefulWidget {
  final Equipamento? equipamento;
  const CadastroEqpPage({super.key, this.equipamento});

  @override
  CadastroEqpPageState createState() => CadastroEqpPageState();
}

class CadastroEqpPageState extends ConsumerState<CadastroEqpPage> {
  final _formKey = GlobalKey<FormState>();

  // 🔹 Controladores de Texto
  final _nomeController = TextEditingController();
  final _modeloController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _localizacaoController = TextEditingController();

  // 🔹 Variáveis de Seleção
  String? _setorSelecionado;
  bool _isSaving = false;

  // 🔹 Lista de Setores
  final List<String> _setores = [
    'Administrativo',
    'Estoque',
    'Comercial',
    'Informática'
  ];

  @override
  void dispose() {
    _nomeController.dispose();
    _modeloController.dispose();
    _descricaoController.dispose();
    _localizacaoController.dispose();
    super.dispose();
  }

  Future<void> _salvarEquipamento() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    try {
      final equipamentoNotifier = ref.read(equipamentoProvider.notifier);

      final novoEquipamento = Equipamento(
        id: 0,
        nome: _nomeController.text, // 🔹 Adicionado campo 'nome'
        tipo: '',
        marca: '',
        modelo: _modeloController.text,
        ano: 0,
        usuarioResponsavel: '',
        setor: _setorSelecionado ?? '',
        responsavelSetor: '',
        sistemaOperacional: '',
        descricao: _descricaoController.text,

        localizacao:
            _localizacaoController.text, // 🔹 Adicionado campo 'localizacao'
        programasInstalados: [],
        assinaturasSelecionadas: [],
        fichaTecnica: {},
      );

      await equipamentoNotifier.adicionarEquipamento(novoEquipamento);

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Equipamento cadastrado com sucesso!")),
      );

      Navigator.pop(context, true);
    } catch (e) {
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
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        filled: true,
        fillColor: Colors.white,
      ),
      keyboardType: type,
      validator: (value) => value!.isEmpty ? 'Campo obrigatório' : null,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
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
                  _buildTextField(_nomeController, 'Nome'),
                  const SizedBox(height: 10),
                  _buildTextField(_modeloController, 'Modelo'),
                  const SizedBox(height: 10),
                  _buildTextField(_descricaoController, 'Descrição'),
                  const SizedBox(height: 10),
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
                  _buildTextField(_localizacaoController, 'Localização'),
                  const SizedBox(height: 20),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
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
                          elevation: 5,
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

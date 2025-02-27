import 'package:controle_ti/models/equipamento.dart';
import 'package:controle_ti/services/equipamento_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EquipamentoNotifier extends StateNotifier<List<Equipamento>> {
  EquipamentoNotifier() : super([]) {
    carregarEquipamentos();
  }

  bool isLoading = false;
  String? errorMessage; //

  // 🔹 Buscar Equipamentos da API
  Future<void> carregarEquipamentos() async {
    isLoading = true;
    errorMessage = null;
    state = [...state];
    try {
      final equipamentos = await EquipamentoService.listarEquipamentos();
      state = equipamentos; // ✅ Atualiza com os dados da API
    } catch (e) {
      errorMessage = "Erro ao carregar equipamentos.";
      if (kDebugMode) {
        print(" Erro ao carregar equipamentos: $e");
      }
    } finally {
      isLoading = false;
      state = [...state]; // 🔹 Atualiza para refletir mudanças na UI
    }
  }

  // 🔹 Adicionar Equipamento
  Future<void> adicionarEquipamento(Equipamento equipamento) async {
    isLoading = true;
    state = [...state];

    bool sucesso = await EquipamentoService.cadastrarEquipamento(equipamento);
    if (sucesso) {
      await carregarEquipamentos();
    } else {
      errorMessage = "Erro ao cadastrar equipamento.";
    }

    isLoading = false;
    state = [...state];
  }

  // 🔹 Atualizar Equipamento
  Future<void> atualizarEquipamento(Equipamento equipamento) async {
    isLoading = true;
    state = [...state];

    bool sucesso = await EquipamentoService.atualizarEquipamento(equipamento);
    if (sucesso) {
      await carregarEquipamentos();
    } else {
      errorMessage = "Erro ao atualizar equipamento.";
    }

    isLoading = false;
    state = [...state];
  }

  // 🔹 Deletar Equipamento
  Future<void> deletarEquipamento(int id) async {
    isLoading = true;
    state = [...state];

    bool sucesso = await EquipamentoService.deletarEquipamento(id);
    if (sucesso) {
      await carregarEquipamentos();
    } else {
      errorMessage = "Erro ao deletar equipamento.";
    }

    isLoading = false;
    state = [...state];
  }
}

// 🔹 Provedor Global
final equipamentoProvider =
    StateNotifierProvider<EquipamentoNotifier, List<Equipamento>>((ref) {
  return EquipamentoNotifier();
});

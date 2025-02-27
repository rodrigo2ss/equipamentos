import 'dart:convert';
import 'dart:async';
import 'package:controle_ti/models/equipamento.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class EquipamentoService {
  static const String _baseUrl = kIsWeb
      ? 'http://127.0.0.1/equipamentos_api/api/equipamentos.php' // Para Web (CORS)
      : 'http://10.0.2.2/equipamentos_api/api/equipamentos.php'; // Para Android

  static void debugPrintError(String mensagem) {
    if (kDebugMode) print("❌ $mensagem");
  }

  // 🔹 Buscar todos os equipamentos
  static Future<List<Equipamento>> listarEquipamentos() async {
    try {
      final response = await http.get(
        Uri.parse(_baseUrl),
        headers: {"Accept": "application/json"},
      ).timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        if (response.body.isEmpty) {
          throw Exception("Resposta da API vazia!");
        }

        final decoded = jsonDecode(response.body);
        if (decoded is! List) {
          throw Exception("Formato de resposta inválido!");
        }

        return decoded.map((json) => Equipamento.fromJson(json)).toList();
      } else {
        debugPrintError(
            "Erro ao buscar equipamentos: ${response.statusCode} - ${response.body}");
        return [];
      }
    } catch (e) {
      debugPrintError("Erro ao conectar com a API: $e");
      return [];
    }
  }

  // 🔹 Cadastrar novo equipamento (Agora inclui nome e localização)
  static Future<bool> cadastrarEquipamento(Equipamento equipamento) async {
    try {
      final response = await http
          .post(
            Uri.parse(_baseUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(equipamento
                .toJson()), // ✅ Nome e Localização já estão incluídos no toJson()
          )
          .timeout(const Duration(seconds: 10));

      debugPrintError("📢 Resposta da API (Cadastro): ${response.body}");

      return response.statusCode == 201 || response.statusCode == 200;
    } catch (e) {
      debugPrintError("Erro ao conectar com a API: $e");
      return false;
    }
  }

  // 🔹 Atualizar equipamento (Corrigido para enviar ID na URL)
  static Future<bool> atualizarEquipamento(Equipamento equipamento) async {
    try {
      final response = await http
          .put(
            Uri.parse(
                "$_baseUrl/${equipamento.id}"), // ✅ Agora envia o ID na URL
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(equipamento.toJson()),
          )
          .timeout(const Duration(seconds: 10));

      debugPrintError("📢 Resposta da API (Atualizar): ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      debugPrintError("Erro ao conectar com a API: $e");
      return false;
    }
  }

  // 🔹 Deletar equipamento (Corrigido para enviar ID na URL)
  static Future<bool> deletarEquipamento(int id) async {
    try {
      final response = await http.delete(
        Uri.parse("$_baseUrl/$id"), // ✅ Agora envia o ID na URL
        headers: {"Content-Type": "application/json"},
      ).timeout(const Duration(seconds: 10));

      debugPrintError("📢 Resposta da API (Deletar): ${response.body}");

      return response.statusCode == 200;
    } catch (e) {
      debugPrintError("Erro ao conectar com a API: $e");
      return false;
    }
  }
}

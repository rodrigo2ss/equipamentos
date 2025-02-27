import 'dart:convert';

class Equipamento {
  final int? id;
  final String nome;
  final String tipo;
  final String marca;
  final String modelo;
  final int ano;
  final String descricao;
  final String usuarioResponsavel;
  final String setor;
  final String responsavelSetor;
  final String sistemaOperacional;
  final String localizacao;
  final List<String> programasInstalados;
  final List<String> assinaturasSelecionadas; // 🔹 Adicionado
  final Map<String, dynamic> fichaTecnica;

  Equipamento({
    this.id,
    required this.nome,
    required this.tipo,
    required this.marca,
    required this.modelo,
    required this.ano,
    required this.descricao,
    required this.usuarioResponsavel,
    required this.setor,
    required this.responsavelSetor,
    required this.sistemaOperacional,
    required this.localizacao,
    required this.programasInstalados,
    required this.assinaturasSelecionadas, // 🔹 Adicionado
    required this.fichaTecnica,
  });

  // 🔹 Converte JSON para Equipamento
  factory Equipamento.fromJson(Map<String, dynamic> json) {
    return Equipamento(
      id: json['id'] != null ? int.tryParse(json['id'].toString()) : null,
      nome: json['nome'] ?? '',
      tipo: json['tipo'] ?? '',
      marca: json['marca'] ?? '',
      modelo: json['modelo'] ?? '',
      ano: json['ano'] != null ? int.tryParse(json['ano'].toString()) ?? 0 : 0,
      descricao: json['descricao'] ?? '',
      usuarioResponsavel: json['usuario_responsavel'] ?? '',
      setor: json['setor'] ?? '',
      responsavelSetor: json['responsavel_setor'] ?? '',
      sistemaOperacional: json['sistema_operacional'] ?? '',
      localizacao: json['localizacao'] ?? '',
      programasInstalados: _parseLista(json['programas_instalados']),
      assinaturasSelecionadas:
          _parseLista(json['assinaturas_selecionadas']), // 🔹 Adicionado
      fichaTecnica: _parseFichaTecnica(json['ficha_tecnica']),
    );
  }

  // 🔹 Converte Equipamento para JSON
  Map<String, dynamic> toJson() {
    return {
      if (id != null) "id": id,
      "nome": nome,
      "tipo": tipo,
      "marca": marca,
      "modelo": modelo,
      "ano": ano,
      "descricao": descricao,
      "usuario_responsavel": usuarioResponsavel,
      "setor": setor,
      "responsavel_setor": responsavelSetor,
      "sistema_operacional": sistemaOperacional,
      "localizacao": localizacao,
      "programas_instalados": programasInstalados,
      "assinaturas_selecionadas": assinaturasSelecionadas, // 🔹 Adicionado
      "ficha_tecnica": fichaTecnica,
    };
  }

  // 🔹 Função para converter JSON -> Lista de Strings
  static List<String> _parseLista(dynamic value) {
    if (value == null) return [];
    if (value is String) {
      try {
        return List<String>.from(jsonDecode(value));
      } catch (_) {
        return [];
      }
    }
    if (value is List) {
      return value.cast<String>();
    }
    return [];
  }

  // 🔹 Função para tratar a conversão de "ficha_tecnica"
  static Map<String, dynamic> _parseFichaTecnica(dynamic value) {
    if (value == null) return {};
    if (value is String) {
      try {
        return jsonDecode(value) as Map<String, dynamic>;
      } catch (_) {
        return {};
      }
    }
    if (value is Map<String, dynamic>) {
      return value;
    }
    return {};
  }
}

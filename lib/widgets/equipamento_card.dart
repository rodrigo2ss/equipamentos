import 'package:flutter/material.dart';
import 'package:controle_ti/models/equipamento.dart';
import 'package:controle_ti/pages/detalhes_page.dart';

class EquipamentoCard extends StatelessWidget {
  final Equipamento equipamento;

  const EquipamentoCard({super.key, required this.equipamento});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetalhesPage(equipamento: equipamento),
          ),
        );
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: LinearGradient(
            colors: [Colors.blue.shade400, Colors.blue.shade600],
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
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisSize: MainAxisSize.min, // 🔹 Evita overflow
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Ícone do equipamento
              Container(
                decoration: BoxDecoration(
                  // ignore: deprecated_member_use
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(12),
                child: const Icon(
                  Icons.computer,
                  size: 40,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 10),

              // Modelo do Equipamento
              SizedBox(
                height: 20, // 🔹 Define um tamanho fixo para evitar overflow
                child: Text(
                  equipamento.tipo,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(height: 3),

              // Marca e Responsável
              Flexible(
                // 🔹 Ajusta para evitar estouro de layout
                child: Text(
                  '${equipamento.marca}\nResp: ${equipamento.usuarioResponsavel}',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize:
                        14, // 🔹 Ajustado para evitar quebre desnecessária
                    // ignore: deprecated_member_use
                    color: Colors.white.withOpacity(0.9),
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

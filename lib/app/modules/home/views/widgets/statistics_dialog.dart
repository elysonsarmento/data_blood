import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controllers/home_controller.dart';

class StatisticsDialog extends GetView<HomeController> {
  const StatisticsDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Estatísticas Filtradas', textAlign: TextAlign.center),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildStatRow('IMC Médio:', _calculateAvgIMC().toStringAsFixed(1)),
          _buildStatRow('Idade Média:', '${_calculateAvgAge()} anos'),
          const SizedBox(height: 15),
          _buildGenderStats('Homens Obesos:', _maleStats()),
          _buildGenderStats('Mulheres Obesas:', _femaleStats()),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(),
          child: const Text('Fechar'),
        ),
      ],
    );
  }

  double _calculateAvgIMC() {
    double totalIMC = 0;
    for (final item in controller.filteredItems) {
      totalIMC += (item['peso'] as int) / ((item['altura'] as double) * (item['altura'] as double));
    }
    return controller.filteredItems.isEmpty ? 0 : totalIMC / controller.filteredItems.length;
  }

  int _calculateAvgAge() {
    int totalAge = 0;
    final currentYear = DateTime.now().year;
    for (final item in controller.filteredItems) {
      final birthDate = DateFormat('dd/MM/yyyy').parse(item['data_nasc'] as String);
      totalAge += currentYear - birthDate.year;
    }
    return controller.filteredItems.isEmpty ? 0 : (totalAge / controller.filteredItems.length).round();
  }

  Map<String, int> _maleStats() {
    int total = 0;
    int obese = 0;
    for (final item in controller.filteredItems) {
      if ((item['sexo'] as String).toLowerCase().contains('masculino')) {
        total++;
        final imc = (item['peso'] as int) / ((item['altura'] as double) * (item['altura'] as double));
        if (imc > 30) obese++;
      }
    }
    return {'total': total, 'obese': obese};
  }

  Map<String, int> _femaleStats() {
    int total = 0;
    int obese = 0;
    for (final item in controller.filteredItems) {
      if (!(item['sexo'] as String).toLowerCase().contains('masculino')) {
        total++;
        final imc = (item['peso'] as int) / ((item['altura'] as double) * (item['altura'] as double));
        if (imc > 30) obese++;
      }
    }
    return {'total': total, 'obese': obese};
  }

  Widget _buildStatRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: Colors.grey[800])),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildGenderStats(String label, Map<String, int> stats) {
    final percent = stats['total']! > 0 
        ? (stats['obese']! / stats['total']! * 100) 
        : 0;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label),
          LinearProgressIndicator(
            value: percent / 100,
            backgroundColor: Colors.grey[300],
            valueColor: AlwaysStoppedAnimation<Color>(
              percent > 30 ? Colors.red : Colors.green,
            ),
          ),
          Text(
            '${percent.toStringAsFixed(1)}% (${stats['obese']} de ${stats['total']})',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
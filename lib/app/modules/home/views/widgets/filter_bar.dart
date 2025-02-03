import 'dart:convert';
import 'dart:io';
import '../../../../utils/enums/filter_mode_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:file_picker/file_picker.dart';
import '../../controllers/home_controller.dart';
import 'filter_dialog.dart';

class FilterBar extends GetView<HomeController> {
  const FilterBar({super.key});

  Future<void> _loadJsonFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['json'],
      );

      if (result != null && result.files.single.path != null) {
        final filePath = result.files.single.path!;
        final jsonString = await File(filePath).readAsString();
        final jsonData = jsonDecode(jsonString) as List<dynamic>;

        // Converte os dados de forma segura
        final List<Map<String, Object>> parsedData = jsonData.map((item) {
          return (item as Map<String, dynamic>).map((key, value) {
            return MapEntry(key, value as Object);
          });
        }).toList();

        // Atualiza o controller com os novos dados
        controller.loadFromJson(parsedData);
        Get.snackbar('Sucesso', 'Dados carregados com sucesso!');
      }
    } catch (e) {
      Get.snackbar('Erro', 'Falha ao carregar arquivo: ${e.toString()}');
    }
  }

  void _showJsonUploadDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Carregar dados'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Selecione um arquivo JSON com os dados:'),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.upload_file),
              label: const Text('Selecionar arquivo'),
              onPressed: () async {
                Get.back();
                await _loadJsonFile();
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Colors.grey[200],
      child: Row(
        children: [
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.filter_alt),
            onPressed: () => Get.bottomSheet(
              const FilterDialog(),
              isScrollControlled: true,
            ),
            color: Colors.red[900],
          ),
          IconButton(
            iconSize: 30,
            icon: const Icon(Icons.add),
            onPressed: _showJsonUploadDialog,
            color: Colors.green[900],
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Obx(() => Row(
                    children: [
                      if (controller.filterMode.value != FilterMode.nenhum)
                        _buildFilterChip(
                            'Modo: ${controller.filterMode.value.name.toUpperCase()}',
                            Colors.blue),
                      if (controller.selectedBloodType.value != 'Todos')
                        _buildFilterChip(
                            'Sangue: ${controller.selectedBloodType.value}',
                            Colors.red),
                      _buildFilterChip(
                          'Idade: ${controller.minAge}-${controller.maxAge} anos',
                          Colors.green),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, Color color) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

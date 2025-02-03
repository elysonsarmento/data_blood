import '../../../../utils/enums/blood_type_enum.dart';
import '../../../../utils/enums/filter_mode_enum.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../utils/enums/uf_enum.dart';
import '../../controllers/home_controller.dart';

class FilterDialog extends GetView<HomeController> {
  const FilterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildHeader(),
          const SizedBox(height: 16),
          _buildModeToggle(),
          const SizedBox(height: 16),
          _buildBloodTypeFilter(),
          const SizedBox(height: 16),
          _buildStateFilter(),
          const SizedBox(height: 16),
          _buildAgeFilter(),
          const SizedBox(height: 24),
          _buildActionButtons(),
        ],
      ),
    );
  }

  Widget _buildStateFilter() {
  return Obx(() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Estado (UF):', style: TextStyle(fontSize: 16)),
      DropdownButton<StateEnum>(
        isExpanded: true,
        value: controller.selectedState.value,
        onChanged: (StateEnum? newValue) {
          controller.selectedState.value = newValue!;
          controller.filterResults();
        },
        items: StateEnum.values.map<DropdownMenuItem<StateEnum>>((StateEnum value) {
          return DropdownMenuItem<StateEnum>(
            value: value,
            child: Text(value.label),
          );
        }).toList(),
      ),
    ],
  ));
}

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Filtros',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  Widget _buildModeToggle() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Tipo de Filtro:', style: TextStyle(fontSize: 16)),
        ToggleButtons(
          isSelected: [
            controller.filterMode.value == FilterMode.nenhum,
            controller.filterMode.value == FilterMode.doador,
            controller.filterMode.value == FilterMode.receptor
          ],
          onPressed: (index) {
            controller.filterMode.value = FilterMode.values[index];
            controller.filterResults();
          },
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Nenhum'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Doador'),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text('Receptor'),
            ),
          ],
        ),
      ],
    ));
  }

  Widget _buildBloodTypeFilter() {
  return Obx(() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const Text('Tipo Sanguíneo:', style: TextStyle(fontSize: 16)),
      DropdownButton<BloodType>(
        isExpanded: true,
        value: controller.selectedBloodType.value,
        onChanged: (BloodType? newValue) {
          controller.selectedBloodType.value = newValue!;
          controller.filterResults();
        },
        items: BloodType.values.map<DropdownMenuItem<BloodType>>((BloodType value) {
          return DropdownMenuItem<BloodType>(
            value: value,
            child: Text(value.label),
          );
        }).toList(),
      ),
    ],
  ));
}

  Widget _buildAgeFilter() {
    return Obx(() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Faixa Etária:', style: TextStyle(fontSize: 16)),
        RangeSlider(
          values: RangeValues(
            controller.minAge.value.toDouble(), 
            controller.maxAge.value.toDouble()
          ),
          min: 0,
          max: 100,
          divisions: 100,
          labels: RangeLabels(
            'Min: ${controller.minAge.value}',
            'Max: ${controller.maxAge.value}',
          ),
          onChanged: (values) {
            controller.minAge.value = values.start.round();
            controller.maxAge.value = values.end.round();
          },
        ),
      ],
    ));
  }

  Widget _buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            controller.resetFilters();
            Get.back();
          },
          child: const Text('Limpar Filtros'),
        ),
        ElevatedButton(
          onPressed: () {
            controller.filterResults();
            Get.back();
          },
          child: const Text('Aplicar Filtros'),
        ),
      ],
    );
  }
}
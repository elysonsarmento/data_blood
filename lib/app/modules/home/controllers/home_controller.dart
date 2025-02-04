import 'package:data_blood/app/domain/entity/person.dart';
import 'package:data_blood/app/domain/usecase/person_usecase.dart';
import 'package:data_blood/app/utils/enums/filter_mode_enum.dart';
import 'package:data_blood/app/utils/enums/blood_type_enum.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/enums/uf_enum.dart';

class HomeController extends GetxController {
  final PersonUseCase _personUseCase = Get.find<PersonUseCase>();
  int get totalItems => resultItens.length;
  int get filteredItemsCount => filteredItems.length;
  final RxList<Map<String, Object>> resultItens = <Map<String, Object>>[].obs;
  final filterMode = FilterMode.nenhum.obs;
  final selectedBloodType = BloodType.todos.obs;
  final selectedState = StateEnum.todos.obs;
  final minAge = 0.obs;
  final maxAge = 100.obs;

  List<String> get bloodTypeLabels =>
      BloodType.values.map((e) => e.label).toList();

  List<String> get stateLabels => StateEnum.values.map((e) => e.label).toList();

  @override
  void onInit() {
    selectedBloodType.value = BloodType.todos;
    selectedState.value = StateEnum.todos;
    super.onInit();
  }

  List<Map<String, dynamic>> get filteredItems => filterResults();

  List<Map<String, dynamic>> filterResults() {
    return resultItens.where((p) {
      final age = _calculateAge(p['data_nasc'] as String);
      bool bloodMatch = true;
      bool stateMatch = true;

      // Filtro por tipo sanguíneo (se não for 'Todos')
      if (selectedBloodType.value != BloodType.todos) {
        if (filterMode.value == FilterMode.doador) {
          bloodMatch = _canDonate(
              p['tipo_sanguineo'] as String, selectedBloodType.value.label);
        } else if (filterMode.value == FilterMode.receptor) {
          bloodMatch = _canReceive(
              p['tipo_sanguineo'] as String, selectedBloodType.value.label);
        } else {
          bloodMatch = p['tipo_sanguineo'] == selectedBloodType.value.label;
        }
      }

      // Filtro por estado (se não for 'Todos')
      if (selectedState.value != StateEnum.todos) {
        stateMatch = p['estado'] == selectedState.value.label;
      }

      return bloodMatch &&
          stateMatch &&
          age >= minAge.value &&
          age <= maxAge.value;
    }).toList();
  }

  int _calculateAge(String birthDate) {
    final date = DateFormat('dd/MM/yyyy').parse(birthDate);
    final today = DateTime.now();
    return today.year -
        date.year -
        ((today.month < date.month ||
                (today.month == date.month && today.day < date.day))
            ? 1
            : 0);
  }

  String get filteredPercentage {
    if (totalItems == 0) return '0.00%';
    final percentage = (filteredItemsCount / totalItems) * 100;
    return '${percentage.toStringAsFixed(2)}%';
  }

  void resetFilters() {
    filterMode.value = FilterMode.nenhum;
    selectedBloodType.value = BloodType.todos;
    selectedState.value = StateEnum.todos;
    minAge.value = 0;
    maxAge.value = 100;
    filterResults();
  }

  bool _canReceive(String receiverType, String donorType) {
    final compatibility = {
      'O-': ['O-'],
      'O+': ['O-', 'O+'],
      'A-': ['A-', 'O-'],
      'A+': ['A-', 'A+', 'O-', 'O+'],
      'B-': ['B-', 'O-'],
      'B+': ['B-', 'B+', 'O-', 'O+'],
      'AB-': ['A-', 'B-', 'AB-', 'O-'],
      'AB+': ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
    };

    return compatibility[receiverType]?.contains(donorType) ?? false;
  }

  bool _canDonate(String donorType, String receiverType) {
    final compatibility = {
      'O-': ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'],
      'O+': ['A+', 'B+', 'AB+', 'O+'],
      'A-': ['A+', 'A-', 'AB+', 'AB-'],
      'A+': ['A+', 'AB+'],
      'B-': ['B+', 'B-', 'AB+', 'AB-'],
      'B+': ['B+', 'AB+'],
      'AB-': ['AB+', 'AB-'],
      'AB+': ['AB+']
    };

    return compatibility[donorType]?.contains(receiverType) ?? false;
  }

  void loadFromJson(List<Map<String, Object>> newData) async {
    resultItens.clear();
    resultItens.addAll(newData);
    final toPerson = newData.map((e) => Pessoa.fromJson(e)).toList();
    
  }
}

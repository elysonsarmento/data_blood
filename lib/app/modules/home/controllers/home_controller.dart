import 'package:data_blood/app/utils/enums/filter_mode_enum.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';


class HomeController extends GetxController {
  int get totalItems => resultItens.length;
  int get filteredItemsCount => filteredItems.length;
  final RxList<Map<String, Object>> resultItens = <Map<String, Object>>[].obs;
  final filterMode = FilterMode.nenhum.obs;
  final selectedBloodType = 'Todos'.obs;
  final minAge = 0.obs;
  final maxAge = 100.obs;

  final bloodTypes = [
    'Todos',
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];
  @override
  void onInit() {
    selectedBloodType.value = bloodTypes.first;

    super.onInit();
  }

  List<Map<String, dynamic>> get filteredItems => filterResults();

  List<Map<String, dynamic>> filterResults() {
    return resultItens.where((p) {
      final age = _calculateAge(p['data_nasc'] as String);
      bool bloodMatch = true;

      // Filtro por tipo sanguíneo (se não for 'Todos')
      if (selectedBloodType.value != 'Todos') {
        if (filterMode.value == FilterMode.doador) {
          bloodMatch = _canDonate(
              p['tipo_sanguineo'] as String, selectedBloodType.value);
        } else if (filterMode.value == FilterMode.receptor) {
          bloodMatch = _canReceive(
              p['tipo_sanguineo'] as String, selectedBloodType.value);
        } else {
          bloodMatch = p['tipo_sanguineo'] == selectedBloodType.value;
        }
      }

      return bloodMatch && age >= minAge.value && age <= maxAge.value;
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
    selectedBloodType.value = 'Todos';
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

  void loadFromJson(List<Map<String, Object>> newData) {
    resultItens.clear();
    resultItens.addAll(newData);
  }
}

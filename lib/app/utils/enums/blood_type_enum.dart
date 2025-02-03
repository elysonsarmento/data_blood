enum BloodType {
  todos,
  aPositivo,
  aNegativo,
  bPositivo,
  bNegativo,
  abPositivo,
  abNegativo,
  oPositivo,
  oNegativo,
}

extension BloodTypeExtension on BloodType {
  String get label {
    switch (this) {
      case BloodType.todos:
        return 'Todos';
      case BloodType.aPositivo:
        return 'A+';
      case BloodType.aNegativo:
        return 'A-';
      case BloodType.bPositivo:
        return 'B+';
      case BloodType.bNegativo:
        return 'B-';
      case BloodType.abPositivo:
        return 'AB+';
      case BloodType.abNegativo:
        return 'AB-';
      case BloodType.oPositivo:
        return 'O+';
      case BloodType.oNegativo:
        return 'O-';
    }
  }
}
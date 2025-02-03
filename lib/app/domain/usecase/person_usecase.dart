import '../entity/person.dart';
import '../repository/person_repo.dart';

class PersonUseCase {
  final PersonRepo _repository;

  PersonUseCase(this._repository);

  Future<List<Pessoa>> getPersons() async {
    return await _repository.getPersons();
  }

  Future<void> saveAllPersons(List<Pessoa> persons) async {
    await _repository.saveAllPerson(persons);
  }
}

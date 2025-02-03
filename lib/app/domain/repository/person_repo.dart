import '../entity/person.dart';

abstract class PersonRepo {
  Future<List<Pessoa>> getPersons();
  Future<void> saveAllPerson(List<Pessoa> person);  
}
import 'package:data_blood/app/data/datasources/remote/person_data_remote.dart';
import 'package:data_blood/app/domain/entity/person.dart';
import 'package:data_blood/app/domain/repository/person_repo.dart';

class PersonRepoImple implements PersonRepo {
  final DonorRemoteDataSource _personDataSource;

  PersonRepoImple(this._personDataSource);

  @override
  Future<List<Pessoa>> getPersons() async {
    return await _personDataSource.getAllDonors();
  }

  
  @override
  Future<void> saveAllPerson(List<Pessoa> person) async{
    return await _personDataSource.createDonors(person);
  }
  
}
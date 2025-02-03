import 'package:data_blood/app/domain/entity/person.dart';
import 'package:dio/dio.dart';

class DonorRemoteDataSource {
  final Dio dio;

  DonorRemoteDataSource(this.dio);

  Future<void> createDonors(List<Pessoa> donors) async {
    final data = donors.map((donor) => donor.toJson()).toList();
    await dio.post('/v1/donors', data: data);
  }

  Future<Pessoa> createDonor(Pessoa donor) async {
    final response = await dio.post('/v1/donor', data: donor.toJson());
    return Pessoa.fromJson(response.data);
  }

  Future<List<Pessoa>> getAllDonors({int page = 0, int size = 20}) async {
    final response = await dio.get('/v1/donor', queryParameters: {'page': page, 'size': size});
    final List<dynamic> donors = response.data['content'];
    return donors.map((json) => Pessoa.fromJson(json)).toList();
  }
}

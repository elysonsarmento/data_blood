import '../../../domain/usecase/person_usecase.dart';

import "../../../data/datasources/remote/person_data_remote.dart";
import '../../../data/repository/person_repo_imple.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Dio>(() => Dio(BaseOptions(
        baseUrl: dotenv.env['BASE_URL'] ?? 'http://localhost:8080')));
    Get.lazyPut<DonorRemoteDataSource>(
        () => DonorRemoteDataSource(Get.find<Dio>()));
    Get.lazyPut<PersonRepoImple>(
        () => PersonRepoImple(Get.find<DonorRemoteDataSource>()));
    Get.lazyPut<PersonUseCase>(
        () => PersonUseCase(Get.find<PersonRepoImple>()));
    Get.lazyPut<HomeController>(() => HomeController());
  }
}

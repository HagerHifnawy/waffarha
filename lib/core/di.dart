import 'package:get_it/get_it.dart';
import 'package:waffarha/features/home/data/repo/home_repo.dart';
import 'network/dio_factory.dart';


final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerLazySingleton<DioFactory>(() => DioFactory());
  getIt.registerLazySingleton<HomeRepository>(() => HomeRepository(getIt()));


}

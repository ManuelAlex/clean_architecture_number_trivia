import 'package:data_connection_checker_nulls/data_connection_checker_nulls.dart';
import 'package:get_it/get_it.dart';
import 'package:number_trivia/core/network/network_info.dart';
import 'package:number_trivia/core/utils/format_converter.dart';
import 'package:number_trivia/features/number_trivia/data/data_sources/number_trivia_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/data_sources/number_trivia_local_data_source.dart';
import 'package:number_trivia/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:number_trivia/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:number_trivia/features/number_trivia/presentation/riverpod/notifier/number_trivia_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  //register features
  //Riverpod Notifier
  sl.registerFactory<NumberTriviStateNotifier>(
    () => NumberTriviStateNotifier(
      getConcreteNumberTriviaUsecase: sl(),
      getRandomNumberTriviaUsecase: sl(),
      stringToIntConverter: sl(),
    ),
  );

  // register usecases
  sl.registerLazySingleton<GetConcreteNumberTriviaUsecase>(
    () => GetConcreteNumberTriviaUsecase(
      repository: sl(),
    ),
  );
  sl.registerLazySingleton<GetRandomNumberTriviaUsecase>(
    () => GetRandomNumberTriviaUsecase(
      repository: sl(),
    ),
  );

  //core
  sl.registerLazySingleton<StringToIntConverter>(
      () => const StringToIntConverter());
  sl.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      dataConnectionChecker: sl(),
    ),
  );

  //repositories
  sl.registerLazySingleton<NumberTriaviaRepository>(
      () => NumberTriviaRepositoryImpl(
            remoteDataSource: sl(),
            localDataSource: sl(),
            networkInfo: sl(),
          ));

  //data
  sl.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: sl(),
    ),
  );
  sl.registerLazySingleton<NumberTriviaLocalDataSource>(
    () => NumberTriviaLocalDataSourceImpl(
      sharedPreferences: sl(),
    ),
  );

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(
    () => sharedPreferences,
  );
  sl.registerLazySingleton<DataConnectionChecker>(
    () => DataConnectionChecker(),
  );
  //final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<http.Client>(
    () => http.Client(),
  );
}

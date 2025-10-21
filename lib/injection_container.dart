import 'package:buku_tamu/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/get_token_usecase.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/login_usecase.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/logout_usecase.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:buku_tamu/src/features/guest/data/datasource/guest_datasource.dart';
import 'package:buku_tamu/src/features/guest/data/repositories/guest_repository.dart';
import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';
import 'package:buku_tamu/src/features/guest/domain/usecases/add_guest.dart';
import 'package:buku_tamu/src/features/guest/domain/usecases/fetch_employee.dart';
import 'package:buku_tamu/src/features/home/data/datasource/home_datasource.dart';
import 'package:buku_tamu/src/features/home/data/repository/home_repository.dart';
import 'package:buku_tamu/src/features/home/domain/repository/home_repository.dart';
import 'package:buku_tamu/src/features/home/domain/usecases/add_guest.dart';
import 'package:buku_tamu/src/features/home/presentation/bloc/home_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buku_tamu/src/features/auth/data/repositories/auth_repository.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/register_usecase.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External (Firebase)
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Bloc
  sl.registerFactory(() => AuthBloc(sl(), sl(), sl(), sl()));
  sl.registerFactory(() => GuestBloc(sl(), sl(), sl()));
  sl.registerFactory(() => HomeBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => GetTokenUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => AddGuestUseCase(sl()));
  sl.registerLazySingleton(() => FetchEmployeeUseCase(sl()));
  sl.registerLazySingleton(() => AddGuestUserUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );
  sl.registerLazySingleton<GuestRepository>(
    () => GuestRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<HomeRepository>(
    () => HomeRepositoryImpl(remoteDataSource: sl()),
  );


  // data sources
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(secureStorage: sl<FlutterSecureStorage>()),
  );
  sl.registerLazySingleton<FirebaseAuthDatasource>(
    () => FirebaseAuthDatasourceImpl(
      sl<FirebaseFirestore>(),
      firebaseAuth: sl<FirebaseAuth>(),
    ),
  );
  sl.registerLazySingleton<GuestRemoteDataSource>(
    () => GuestRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<HomeRemoteDataSource>(
    () => HomeRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );
}

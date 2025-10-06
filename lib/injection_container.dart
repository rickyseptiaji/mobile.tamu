import 'package:buku_tamu/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/save_token.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/login_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buku_tamu/src/features/auth/data/repositories/auth_repository.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/register_usecase.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/register_bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External (Firebase)
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Bloc
  sl.registerFactory(() => RegisterBloc(sl(), sl()));
  sl.registerFactory(() => LoginBloc(sl(), sl()));
  sl.registerFactory(() => GuestBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => SaveToken(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(remoteDataSource: sl(), localDataSource: sl()),
  );

  // data sources
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
  );
  sl.registerLazySingleton<LocalDataSource>(
    () => LocalDataSourceImpl(secureStorage: sl<FlutterSecureStorage>()),
  );
  sl.registerLazySingleton<FirebaseAuthDatasource>(
    () => FirebaseAuthDatasourceImpl(firebaseAuth: sl<FirebaseAuth>()),
  );
}

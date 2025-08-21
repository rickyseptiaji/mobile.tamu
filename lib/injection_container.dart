import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:buku_tamu/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/data/repositories/auth_repository.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/register_usecase.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/register_bloc.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External (Firebase)
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Bloc
  sl.registerFactory(() => RegisterBloc(sl()));
  sl.registerFactory(() => GuestBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => RegisterUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // DataSource
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl());
}

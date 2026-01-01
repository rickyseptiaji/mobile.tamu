import 'package:buku_tamu/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:buku_tamu/src/features/employee/data/datasource/employee_datasource.dart';
import 'package:buku_tamu/src/features/employee/data/repository/employee_repository.dart';
import 'package:buku_tamu/src/features/employee/domain/repository/employee_repository.dart';
import 'package:buku_tamu/src/features/employee/presentation/bloc/employee_bloc.dart';
import 'package:buku_tamu/src/features/form_visitor/data/datasource/form_visitor_datasource.dart';
import 'package:buku_tamu/src/features/form_visitor/data/repository/form_visitor_repository.dart';
import 'package:buku_tamu/src/features/form_visitor/domain/repository/form_visitor_repository.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_bloc.dart';
import 'package:buku_tamu/src/features/guest/data/datasource/guest_datasource.dart';
import 'package:buku_tamu/src/features/guest/data/repositories/guest_repository.dart';
import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';
import 'package:buku_tamu/src/features/guest/domain/usecases/add_guest.dart';
import 'package:buku_tamu/src/features/history/data/datasource/history_datasource.dart';
import 'package:buku_tamu/src/features/history/data/repository/history_repository_impl.dart';
import 'package:buku_tamu/src/features/history/domain/repository/history_repository.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/all_history/all_history_bloc.dart';
import 'package:buku_tamu/src/features/history/presentation/bloc/home_history/home_history_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:buku_tamu/src/features/auth/data/repositories/auth_repository.dart';
import 'package:buku_tamu/src/features/auth/domain/repositories/auth_repository.dart';
import 'package:buku_tamu/src/features/guest/presentation/bloc/guest_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External (Firebase)
  sl.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  sl.registerLazySingleton<FirebaseFirestore>(() => FirebaseFirestore.instance);

  // Bloc
  sl.registerFactory(() => AuthBloc(sl()));
  sl.registerFactory(() => GuestBloc(sl()));
  sl.registerFactory(() => FormVisitorBloc(repository: sl()));
  sl.registerFactory(
    () => HomeHistoryBloc(sl<HistoryRepository>(), sl<AuthRepository>()),
  );
  sl.registerFactory(() => EmployeeCubit(sl()));
  sl.registerFactory(() => AllHistoryBloc(sl<HistoryRepository>(), sl<AuthRepository>()));


  // UseCase
  sl.registerLazySingleton(() => AddGuestUseCase(sl()));

  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(sl(), sl()),
  );
  sl.registerLazySingleton<GuestRepository>(
    () => GuestRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<FormVisitorRepository>(
    () => FormVisitorRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<HistoryRepository>(
    () => HistoryRepositoryImpl(
      remote: sl<HistoryRemoteDataSource>(),
      firestore: sl<FirebaseFirestore>(),
    ),
  );
  sl.registerLazySingleton<EmployeeRepository>(
    () => EmployeeRepositoryImpl(remoteDataSource: sl()),
  );

  // Datasource
  sl.registerLazySingleton<FlutterSecureStorage>(
    () => const FlutterSecureStorage(),
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
  sl.registerLazySingleton<FormVisitorDatasource>(
    () => FormVisitorRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<HistoryRemoteDataSource>(
    () => HistoryRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );

  sl.registerLazySingleton<EmployeeRemoteDataSource>(
    () => EmployeeRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );
}

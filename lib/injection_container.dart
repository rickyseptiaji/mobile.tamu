import 'package:buku_tamu/src/features/auth/data/datasource/auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/data/datasource/firebase_auth_datasource.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/get_token_usecase.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/login_usecase.dart';
import 'package:buku_tamu/src/features/auth/domain/usecase/logout_usecase.dart';
import 'package:buku_tamu/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:buku_tamu/src/features/detail_visior/data/datasource/detailvisitor_datasource.dart';
import 'package:buku_tamu/src/features/detail_visior/data/repository/detailvisitor_repository.dart';
import 'package:buku_tamu/src/features/detail_visior/domain/repository/detailvisitor_repository.dart';
import 'package:buku_tamu/src/features/detail_visior/domain/usecases/detailvisitor_usecase.dart';
import 'package:buku_tamu/src/features/detail_visior/presentation/bloc/detail_visitor_bloc.dart';
import 'package:buku_tamu/src/features/form_visitor/data/datasource/form_visitor_datasource.dart';
import 'package:buku_tamu/src/features/form_visitor/data/repository/form_visitor_repository.dart';
import 'package:buku_tamu/src/features/form_visitor/domain/repository/form_visitor_repository.dart';
import 'package:buku_tamu/src/features/form_visitor/presentation/bloc/form_bloc.dart';
import 'package:buku_tamu/src/features/guest/data/datasource/guest_datasource.dart';
import 'package:buku_tamu/src/features/guest/data/repositories/guest_repository.dart';
import 'package:buku_tamu/src/features/guest/domain/repositories/guest_repository.dart';
import 'package:buku_tamu/src/features/guest/domain/usecases/add_guest.dart';
import 'package:buku_tamu/src/features/guest/domain/usecases/fetch_employee.dart';
import 'package:buku_tamu/src/features/home/data/datasource/home_datasource.dart';
import 'package:buku_tamu/src/features/home/data/repository/home_repository.dart';
import 'package:buku_tamu/src/features/home/domain/repository/home_repository.dart';
import 'package:buku_tamu/src/features/form_visitor/domain/usecases/add_visitor_usecase.dart';
import 'package:buku_tamu/src/features/home/domain/usecases/fetch_history.dart';
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
  sl.registerFactory(() => FormVisitorBloc(sl()));
  sl.registerFactory(() => DetailVisitorBloc(sl()));

  // UseCase
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => LoginUsecase(sl()));
  sl.registerLazySingleton(() => GetTokenUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));
  sl.registerLazySingleton(() => AddGuestUseCase(sl()));
  sl.registerLazySingleton(() => FetchEmployeeUseCase(sl()));
  sl.registerLazySingleton(() => AddVisitorUsecase(sl()));
  sl.registerLazySingleton(() => FetchHistoryUseCase(sl()));
  sl.registerLazySingleton(() => DetailvisitorUsecase(sl()));

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
  sl.registerLazySingleton<FormVisitorRepository>(
    () => FormVisitorRepositoryImpl(remoteDataSource: sl()),
  );
  sl.registerLazySingleton<DetailvisitorRepository>(
    () => DetailvisitorRepositoryImpl(remoteDataSource: sl()),
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
  sl.registerLazySingleton<FormVisitorDatasource>(
    () => FormVisitorRemoteDataSourceImpl(firestore: sl<FirebaseFirestore>()),
  );
  sl.registerLazySingleton<DetailvisitorDatasource>(
    () => DetailvisitorDatasourceImpl(firestore: sl<FirebaseFirestore>()),
  );
}

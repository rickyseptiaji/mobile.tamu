import 'package:buku_tamu/src/features/form_visitor/data/datasource/form_visitor_datasource.dart';
import 'package:buku_tamu/src/features/form_visitor/domain/repository/form_visitor_repository.dart';

class FormVisitorRepositoryImpl extends FormVisitorRepository {
  final FormVisitorDatasource remoteDataSource;

  FormVisitorRepositoryImpl({required this.remoteDataSource});

  @override
  Future<String> addVisitor(String employeeId, String description) async {
    return remoteDataSource.addVisitor(employeeId, description);
  }
}

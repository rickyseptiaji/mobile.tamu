import 'package:buku_tamu/src/features/form_visitor/domain/repository/form_visitor_repository.dart';

class AddVisitorUsecase {
  final FormVisitorRepository repository;
  AddVisitorUsecase(this.repository);

  Future<String> call(String employeeId, String description) async {
    return repository.addVisitor(employeeId, description);
  }
}

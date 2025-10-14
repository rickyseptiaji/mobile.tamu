import 'package:buku_tamu/src/features/guest/domain/entity/guest_entity.dart';

class GuestModel extends GuestEntity {
  GuestModel({
    super.id,
    super.fullName,
    super.companyName,
    super.email,
    super.phone,
    super.employeeId,
    super.description,
  });

  factory GuestModel.fromEntity(GuestEntity employee) {
    return GuestModel(
      id: employee.id,
      fullName: employee.fullName,
      companyName: employee.companyName,
      email: employee.email,
      phone: employee.phone,
      employeeId: employee.employeeId,
      description: employee.description,
    );
  }

  GuestEntity toEntity() {
    return GuestEntity(
      id: id,
      fullName: fullName,
      companyName: companyName,
      email: email,
      phone: phone,
      employeeId: employeeId,
      description: description,
    );
  }
}

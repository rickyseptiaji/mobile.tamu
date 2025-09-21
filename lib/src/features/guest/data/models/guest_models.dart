import 'package:buku_tamu/src/features/guest/domain/entity/guest_entity.dart';

class GuestModel extends GuestEntity {
  GuestModel({
    super.id,
    super.fullName,
    super.email,
    super.phone,
    super.address,
    super.divisionId,
  });

factory GuestModel.fromEntity(GuestEntity employee) {
    return GuestModel(
      id: employee.id,
      fullName: employee.fullName,
      email: employee.email,
      phone: employee.phone,
      address: employee.address,
      divisionId: employee.divisionId,
    );
  }

  GuestEntity toEntity() {
    return GuestEntity(
      id: id, 
      fullName: fullName,
      email: email,
      phone: phone,
      address: address,
      divisionId: divisionId,
    );
  }
}
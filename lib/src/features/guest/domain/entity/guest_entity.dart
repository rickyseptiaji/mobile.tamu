class GuestEntity {
  String? id;
  String? fullName;
  String? companyName;
  String? email;
  String? phone;
  String? employeeId;
  String? description;

  GuestEntity({
    this.id,
    this.fullName,
    this.companyName,
    this.email,
    this.phone,
    this.employeeId,
    this.description,
  });
    Map<String, dynamic> toMap() {
    return {
      'id': id,
      'fullName': fullName,
      'companyName': companyName,
      'email': email,
      'phone': phone,
      'employeeId': employeeId,
      'description': description,
    };
  }
}


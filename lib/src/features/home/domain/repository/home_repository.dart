abstract class HomeRepository {
  Future<void> addGuest(String employeeId, String description);
  Future<List<Map<String, dynamic>>> fetchGuest();
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthDatasource {
  Future<User> login(String email, String password);
  Future<void> register(
    String email,
    String password,
    String fullName,
    String companyName,
    String countryCode,
    String phone,
  );
  Future<void> logout();
}

class FirebaseAuthDatasourceImpl implements FirebaseAuthDatasource {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  FirebaseAuthDatasourceImpl(
    this.firebaseFirestore, {
    required this.firebaseAuth,
  });

  @override
  Future<User> login(String email, String password) async {
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    return credential.user!;
  }

  @override
  Future<void> register(
    String email,
    String password,
    String fullName,
    String companyName,
    String countryCode,
    String phone,
  ) async {
    final userCredential = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
  final uid = userCredential.user?.uid;
    if (uid != null) {
      await firebaseFirestore.collection('users').doc(uid).set({
        'userId': uid,
        'fullName': fullName,
        'companyName': companyName,
        'countryCode': countryCode,
        'phone': phone,
        'email': email,
        'role': 'user',
        'visitCount': null,
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class FirebaseAuthDatasource {
  Future<UserCredential> login(String email, String password);
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
  Future<UserCredential> login(String email, String password) async {
    return await firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
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
        'createdAt': FieldValue.serverTimestamp(),
      });
    }
  }

  @override
  Future<void> logout() async {
    await firebaseAuth.signOut();
  }
}

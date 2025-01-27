import 'package:firebase_auth/firebase_auth.dart';
class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  User? getCurrentUser(){
    return _firebaseAuth.currentUser;
  }

  Future<UserCredential> singInWithEmailPassword(String email,password) async{
    try{
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password,);
      return userCredential;
    }
    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  Future<UserCredential> singUpWithEmailPassword(String email,password) async{
    try{
      UserCredential userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      return userCredential;
    }
    on FirebaseAuthException catch (e){
      throw Exception(e.code);
    }
  }

  Future<void> singOut() async{
    return await _firebaseAuth.signOut();
  }


}
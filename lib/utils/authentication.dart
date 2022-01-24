import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Authentication {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // FIX: Connect firebase backend with signUp front-end
  Future<String> signUp(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth
          .createUserWithEmailAndPassword(email: email, password: password);
      // Do these after successful sign up:
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'document_ID': userCredential.user!.uid,
        'email': email,
        'organization': 'none',
        'username': 'none',
        'usertype': 'student',
      });
      return 'Sign Up Successful!';
    } on FirebaseAuthException catch (err) {
      // Catch Firebase errors
      return err.toString();
    } catch (err) {
      // Catch any other errors
      return err.toString();
    }
  }

  // FIX: Connect firebase backend with Login front-end
  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      // Do these after successful login:
      print(userCredential);
      return 'Sign In Successful!';
    } on FirebaseAuthException catch (err) {
      // Catch Firebase errors
      return err.toString();
    } catch (err) {
      // Catch any other errors
      return err.toString();
    }
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kredo/firebase_options.dart';
import 'package:kredo/provider/auth_provider.dart';
import 'package:kredo/utilities/authuser.dart';
import 'package:kredo/utilities/auth_exceptions.dart';

class FirebaseAuthService implements FirebaseAuthProvider {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> initialize() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }


  @override
  Future<EmailAuthUser> createEmailUser({
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final user = currentEmailUser;
        if (user != null) {
          return user;
        } else {
          throw UserNotLoggedInAuthException();
        }
      } on FirebaseAuthException catch (e) {
        switch (e.code) {
          case 'email-already-in-use':
            throw EmailAlreadyInUseAuthException();
          case 'invalid-email':
            throw InvalidEmailAuthException();
          case 'weak-password':
            throw WeakPasswordAuthException();
          default:
            throw GenericAuthException();
        }
      }
  }

  @override
  // TODO: implement currentEmailUser
  EmailAuthUser? get currentEmailUser {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return EmailAuthUser.fromFirebase(user);
    }
    return null;
  }

  @override
  // TODO: implement currentPhoneUser
  PhoneAuthUser? get currentPhoneUser {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      return PhoneAuthUser.fromFirebase(user);
    }
    return null;
  }

  @override
  Future<EmailAuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      final user = currentEmailUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw UserNotFoundAuthException();
        case 'wrong-password':
          throw WrongPasswordAuthException();
        default:
          throw GenericAuthException();
      }
    }catch (_){
      throw GenericAuthException();
    }
  }

  @override
  Future<PhoneAuthUser> registerPhoneNumber({
    required String phoneNumber,
    required String verificationId,
  }) {
    // TODO: implement registerPhoneNumber
    throw UnimplementedError();
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendSMSCode() {
    // TODO: implement sendSMSCode
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() async {
    final user = _firebaseAuth.currentUser;
    if (user != null) {
      await _firebaseAuth.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<PhoneAuthUser> verifyPhone({required String phoneNumber}) {
    // TODO: implement verifyPhone
    throw UnimplementedError();
  }


}

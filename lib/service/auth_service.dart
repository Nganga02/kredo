import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:kredo/firebase_options.dart';
import 'package:kredo/provider/auth_provider.dart';
import 'package:kredo/model/authuser.dart';
import 'package:kredo/utilities/auth_exceptions.dart';

class FirebaseAuthService implements FirebaseAuthProvider {
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
    required String phoneNumber,

  }) async {
      try {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final firebaseUser = FirebaseAuth.instance.currentUser;
        if (firebaseUser != null) {
          await firebaseUser.updateDisplayName(phoneNumber);
        }
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
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return EmailAuthUser.fromFirebase(user);
    }
    return null;
  }

  @override
  // TODO: implement currentPhoneUser
  PhoneAuthUser? get currentPhoneUser {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return PhoneAuthUser.fromFirebase(user);
    }
    return null;
  }

  @override
  String? get displayName{
    final user = currentEmailUser;
    if (user != null) {
      print("this is the user displayName********************** ${user.displayName}");
      return user.displayName;
    }
    return null;
  }



  @override
  Future<EmailAuthUser> logIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
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
    final user = FirebaseAuth.instance.currentUser;
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
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
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

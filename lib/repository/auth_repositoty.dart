import 'package:kredo/provider/auth_provider.dart';
import 'package:kredo/service/auth_service.dart';
import 'package:kredo/utilities/auth_exceptions.dart';
import 'package:kredo/model/authuser.dart';

class FirebaseAuthRepository implements FirebaseAuthProvider{
  final FirebaseAuthProvider firebaseAuthProvider;

  const FirebaseAuthRepository(this.firebaseAuthProvider);

  factory FirebaseAuthRepository.build() => FirebaseAuthRepository(FirebaseAuthService());

  @override
  Future<void> initialize() => firebaseAuthProvider.initialize();

  @override
  Future<EmailAuthUser> createEmailUser({required String email, required String password, required String confirmPassword, required String phoneNumber}) {
    if(password == confirmPassword){
      return firebaseAuthProvider.createEmailUser(email: email, password: password, confirmPassword: confirmPassword, phoneNumber: phoneNumber);
    }
    else {
      throw PasswordDoesNotMatchAuthException();
    }
  }

  @override
  String? get displayName => firebaseAuthProvider.displayName;

  @override
  EmailAuthUser? get currentEmailUser => firebaseAuthProvider.currentEmailUser;

  @override
  PhoneAuthUser? get currentPhoneUser => firebaseAuthProvider.currentPhoneUser;

  @override
  Future<EmailAuthUser> logIn({required String email, required String password}) {
    return firebaseAuthProvider.logIn(email: email, password: password);
  }

  @override
  Future<PhoneAuthUser> registerPhoneNumber({required String phoneNumber, required String verificationId}) {
    return firebaseAuthProvider.registerPhoneNumber(phoneNumber: phoneNumber, verificationId: verificationId);
  }

  @override
  Future<void> sendEmailVerification() => firebaseAuthProvider.sendEmailVerification();

  @override
  Future<void> sendSMSCode() => firebaseAuthProvider.sendSMSCode();

  @override
  Future<void> signOut() => firebaseAuthProvider.signOut();

  @override
  Future<PhoneAuthUser> verifyPhone({required String phoneNumber}) => firebaseAuthProvider.verifyPhone(phoneNumber: phoneNumber);

}
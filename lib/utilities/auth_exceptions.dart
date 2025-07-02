class InvalidPhoneNumberException implements Exception {}

///Login exceptions
class UserNotFoundAuthException implements Exception {}

class WrongPasswordAuthException implements Exception {}

class UserDisabledAuthException implements Exception {}

class TooManyRequestsAuthException implements Exception {}

class InvalidCredentialAuthException implements Exception {}

///Register exceptions
class EmailAlreadyInUseAuthException implements Exception {}

class InvalidEmailAuthException implements Exception {}

class WeakPasswordAuthException implements Exception {}

class UserNotLoggedInAuthException implements Exception {}

class PasswordDoesNotMatchAuthException implements Exception {
  @override
  String toString() {
    return "Passwords do not match";
  }
}


class GenericAuthException implements Exception {}

///Local auth exceptions
class BiometricNotAvailableAuthException implements Exception {}

class BiometricNotEnrolledAuthException implements Exception {}

class BiometricAuthException implements Exception {}
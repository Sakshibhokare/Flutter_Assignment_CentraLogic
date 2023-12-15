abstract class SignInEvent {}

class SignInPhoneNumberChangedEvent extends SignInEvent {
  final String phoneNumberValue;

  SignInPhoneNumberChangedEvent({required this.phoneNumberValue,});
}

class SignInEmailChangedEvent extends SignInEvent {
  final String emailIdValue;

  SignInEmailChangedEvent({required this.emailIdValue,});
}

class SignInSubmittedEvent extends SignInEvent {
  final String phoneNumber;
  final String emailId;

  SignInSubmittedEvent({required this.phoneNumber, required this.emailId});
}
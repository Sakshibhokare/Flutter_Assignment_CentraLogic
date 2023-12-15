abstract class AddUserEvent {}

class UserNameChangedEvent extends AddUserEvent {
  final String name;

  UserNameChangedEvent({required this.name});
}

class UserPhoneNumberChangedEvent extends AddUserEvent {
  final String phoneNumber;

  UserPhoneNumberChangedEvent({required this.phoneNumber});
}

class UserEmailIdChangedEvent extends AddUserEvent {
  final String emailId;

  UserEmailIdChangedEvent({required this.emailId});
}

class UserSubmittedEvent extends AddUserEvent {
  final String name;
  final String phoneNumber;
  final String emailId;

  UserSubmittedEvent({
    required this.name,
    required this.phoneNumber,
    required this.emailId,
  });
}
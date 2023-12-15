abstract class AddUserState {}

class AddUserInitialState extends AddUserState {}

class AddUserValidState extends AddUserState {}

class AddUserErrorState extends AddUserState {
  final String errorMessage;

  AddUserErrorState({required this.errorMessage});
}


class AddUserLoadingState extends AddUserState {}
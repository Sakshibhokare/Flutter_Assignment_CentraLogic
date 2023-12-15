import 'package:assignment_4th_flutter/dashboard/bloc/add_user/add_user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'add_user_event.dart';

class AddUserBloc extends Bloc<AddUserEvent, AddUserState> {
  AddUserBloc() : super(AddUserInitialState()) {


    on<UserEmailIdChangedEvent>((event, emit) {

      if (event.emailId == "" ||
          event.emailId.contains("@gmail.com") == false) {
        emit(
          AddUserErrorState(
            errorMessage: "Please enter a valid email id",
          ),
        );
      } else {

        emit(AddUserErrorState(errorMessage: ""));
        emit(AddUserValidState());
      }
    });


    on<UserPhoneNumberChangedEvent>((event, emit) {

      if (event.phoneNumber == "" || event.phoneNumber.length != 10) {
        emit(
          AddUserErrorState(
            errorMessage: "Please enter valid phone number",
          ),
        );
      } else {

        emit(AddUserErrorState(errorMessage: ""));
        emit(AddUserValidState());
      }
    });
  }
}
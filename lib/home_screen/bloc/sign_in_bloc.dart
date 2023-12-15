import 'package:assignment_4th_flutter/home_screen/bloc/sign_in_event.dart';
import 'package:assignment_4th_flutter/home_screen/bloc/sign_in_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    
    on<SignInEmailChangedEvent>((event, emit) {
      /// check if email id is empty or not or is valid or not
      if (event.emailIdValue == "" ||
          event.emailIdValue.contains("@gmail.com") == false) {
        emit(
          SignInErrorState(
            errorMessage: "Please enter a valid email id",
          ),
        );
      } else {
        /// if email id is valid then emit SignInValidState
        emit(SignInErrorState(errorMessage: ""));
        emit(SignInEmailValidState());
      }
    });

    
    on<SignInPhoneNumberChangedEvent>((event, emit) {
      /// check if phone number is empty or not or is valid or not
      if (event.phoneNumberValue == "" || event.phoneNumberValue.length != 10) {
        emit(
          SignInErrorState(
            errorMessage: "Please enter valid phone number",
          ),
        );
      } else {
        /// if phone number is valid then emit SignInValidState
        emit(SignInErrorState(errorMessage: ""));
        emit(SignInPhoneNumberValidState());
      }

    });

    on<SignInSubmittedEvent>((event, emit) {

      if(event.emailId == "" || event.phoneNumber == "") {
        emit(SignInErrorState(errorMessage: "Please enter details",));
      } else if(event.emailId.contains("@gmail.com") == false || event.phoneNumber.length != 10) {
        emit(SignInErrorState(errorMessage: "Please enter valid details",));
      } else {

        emit(SignInValidState());
      }

    });
  }
}

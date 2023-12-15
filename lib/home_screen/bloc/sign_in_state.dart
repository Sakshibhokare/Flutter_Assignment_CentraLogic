import 'package:flutter/material.dart';

abstract class SignInState {}


class SignInInitialState extends SignInState {}




class SignInValidState extends SignInState {

  SignInValidState() {
    debugPrint("SignInValidState");
  }

}


class SignInErrorState extends SignInState {
  final String errorMessage;

  SignInErrorState({required this.errorMessage});
}


class SignInLoadingState extends SignInState {}


class SignInEmailValidState extends SignInState {}


class SignInPhoneNumberValidState extends SignInState {}
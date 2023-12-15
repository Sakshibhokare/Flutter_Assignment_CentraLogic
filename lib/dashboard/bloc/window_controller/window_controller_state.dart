import 'package:flutter/cupertino.dart';

abstract class WindowControllerState {}

class WindowControllerInitialState extends WindowControllerState {}

class WindowControllerChangedState extends WindowControllerState {
  final Widget window;
  final String windowName;

  WindowControllerChangedState({required this.window, required this.windowName,});
}
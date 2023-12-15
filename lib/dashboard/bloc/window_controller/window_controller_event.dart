import 'package:flutter/material.dart';

abstract class WindowControllerEvent {}

class WindowChangedEvent extends WindowControllerEvent {
  final Widget window;
  final String windowName;

  WindowChangedEvent({required this.window, required this.windowName,});
}
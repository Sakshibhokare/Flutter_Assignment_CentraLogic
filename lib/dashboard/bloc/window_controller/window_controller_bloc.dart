import 'package:assignment_4th_flutter/dashboard/bloc/window_controller/window_controller_event.dart';
import 'package:assignment_4th_flutter/dashboard/bloc/window_controller/window_controller_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WindowControllerBloc
    extends Bloc<WindowControllerEvent, WindowControllerState> {
  WindowControllerBloc()
      : super(
    WindowControllerInitialState(),
  ) {

    on<WindowChangedEvent>((event, emit) => emit(WindowControllerChangedState(window: event.window, windowName: event.windowName,),),);

  }
}
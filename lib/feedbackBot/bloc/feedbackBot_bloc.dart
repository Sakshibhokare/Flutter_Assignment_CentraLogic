import 'dart:convert';

import 'package:assignment_4th_flutter/dashboard/models/Message_Model.dart';
import 'package:assignment_4th_flutter/feedbackBot/bloc/feedbackBot_event.dart';
import 'package:assignment_4th_flutter/feedbackBot/bloc/feedbackBot_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

class FeedbackBotBloc extends Bloc<FeedbackBotEvent, FeedbackBotState> {
  FeedbackBotBloc() : super(FeedbackBotInitialState()) {
    on<FeedbackBotInitialEvent>((event, emit) async {
      emit(FeedbackBotLoadingState());

      /// load the first message
      final res = await post(Uri.parse("https://sapdos-api-v2.azurewebsites.net/api/Credentials/FeedbackJoiningBot"), body: jsonEncode({"step": event.step,},), headers: {"Content-Type": "application/json"},);

      final message = jsonDecode(res.body)["message"];

      emit(FeedbackBotLoadedState(message: MessageModel(prompt: message, isBot: true,),),);
    });


    on<FeedbackBotNextEvent>((event, emit) async {
      emit(FeedbackBotLoadingState());

      debugPrint("Step: ${event.step}");

      if(event.step >= 5) {
        emit(FeedbackBotLoadedState(message: MessageModel(prompt: "Thank you for your feedback!", isBot: true,),),);
        return;
      }

      /// load the first message
      final res = await post(Uri.parse("https://sapdos-api-v2.azurewebsites.net/api/Credentials/FeedbackJoiningBot"), body: jsonEncode({"step": event.step,},), headers: {"Content-Type": "application/json"},);

      final message = jsonDecode(res.body)["message"];

      emit(FeedbackBotLoadedState(message: MessageModel(prompt: message, isBot: true,),),);
    });
  }


}
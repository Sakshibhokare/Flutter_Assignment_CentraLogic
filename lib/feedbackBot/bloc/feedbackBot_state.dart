import 'package:assignment_4th_flutter/dashboard/models/Message_Model.dart';

abstract class FeedbackBotState {}

class FeedbackBotInitialState extends FeedbackBotState {}

class FeedbackBotLoadingState extends FeedbackBotState {}

class FeedbackBotLoadedState extends FeedbackBotState {
  final MessageModel message;

  FeedbackBotLoadedState({required this.message});
}
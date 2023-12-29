abstract class FeedbackBotEvent {}

class FeedbackBotInitialEvent extends FeedbackBotEvent {
  int step = 0;

  FeedbackBotInitialEvent({required this.step});
}

class FeedbackBotNextEvent extends FeedbackBotEvent {
  final int step;

  FeedbackBotNextEvent({required this.step});
}
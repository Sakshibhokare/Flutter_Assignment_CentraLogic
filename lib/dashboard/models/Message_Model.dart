class MessageModel {

  final String prompt;
  final bool isBot;

  MessageModel({
    required this.prompt,
    required this.isBot,
  });

/*factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      prompt: json['prompt'],
      isBot: json['isBot'],
    );
  }*/

}
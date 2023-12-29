import 'package:flutter/material.dart';

import '../../dashboard/models/Message_Model.dart';
import '../../utils/ThemeColors.dart';

class ChatItemWidget extends StatelessWidget {
  const ChatItemWidget({super.key, required this.message,});

  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: message.isBot ? MainAxisAlignment.start : MainAxisAlignment.end,
      children: [
        if(message.isBot) Image.asset("assets/bot_logo.png",),
        /// Padding
        const SizedBox(width: 8.0,),
        Container(
          width: message.isBot ? MediaQuery.of(context).size.width * 0.4 : MediaQuery.of(context).size.width * 0.05,
          padding: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: ThemeColors.secondary100,
            borderRadius: BorderRadius.only(topLeft: const Radius.circular(8.0), topRight: const Radius.circular(8.0), bottomRight: message.isBot ? const Radius.circular(8.0) : Radius.zero, bottomLeft: message.isBot ? Radius.zero : const Radius.circular(8.0),),
          ),
          child: Text(
            message.prompt,
            maxLines: null,
            style: TextStyle(
              fontSize: 16.0,
              color: ThemeColors.secondary500,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }

}
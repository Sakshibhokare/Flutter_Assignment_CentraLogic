import 'package:flutter/material.dart';

import '../ui_services.dart';

class MobileLayout extends StatelessWidget {
  const MobileLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(children: [
          /// call to function which builds the left side of the screen
          buildLeftView(size: size, containerWidth: size.width, containerHeight: size.height,),
          /// call to function which builds the right side of the screen
          buildRightView(size: size, containerWidth: size.width, containerHeight: size.height,),
        ],),
      ),
    );
  }
}
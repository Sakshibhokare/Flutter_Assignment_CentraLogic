import 'package:flutter/material.dart';

import '../ui_services.dart';

class DesktopLayout extends StatelessWidget {
  const DesktopLayout({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(children: [

        buildLeftView(size: size, containerWidth: size.width * 0.5, containerHeight: size.height,),

        buildRightView(size: size, containerWidth: size.width * 0.5, containerHeight: size.height,),
      ],),
    );
  }


}
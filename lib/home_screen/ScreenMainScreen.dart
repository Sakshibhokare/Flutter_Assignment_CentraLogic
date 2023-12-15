import 'package:flutter/material.dart';

import 'device_layout/desktop_layout.dart';
import 'device_layout/mobile_layout.dart';

class ScreenMainScreen extends StatelessWidget {
  const ScreenMainScreen({super.key});

  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width <= 800;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width > 800;

  @override
  Widget build(BuildContext context) {
    debugPrint("Screen size: ${MediaQuery.of(context).size}");
    /// if the screen size greater than 840, then return the desktop layout
    /// if the screen size less than 400, then return the mobile layout
    return isMobile(context) ? const MobileLayout() : const DesktopLayout();
  }

}

import 'package:assignment_4th_flutter/dashboard/bloc/window_controller/window_controller_bloc.dart';
import 'package:assignment_4th_flutter/dashboard/bloc/window_controller/window_controller_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/ThemeColors.dart';
import '../../bloc/documents/document_bloc.dart';
import '../../bloc/window_controller/window_controller_event.dart';
import '../ScreenHomeTab.dart';
import 'ScreenMobileDocuments.dart';

class ViewMobile extends StatelessWidget {
  ViewMobile({super.key});

  final List tabs = [
    {
      "name": "Home",
      "icon": "assets/home.png",
      "isSelected": true,
      "route": const ScreenHomeTab(),
    },
    {
      "name": "Documents",
      "icon": "assets/document.png",
      "isSelected": false,
      "route": BlocProvider(
        create: (context) => DocumentBloc(),
        child: const ScreenMobileDocuments(),
      ),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<WindowControllerBloc, WindowControllerState>(
                builder: (context, state) => state is WindowControllerInitialState
                    ? const ScreenHomeTab()
                    : state is WindowControllerChangedState
                    ? state.window
                    : Container(),
              ),
            ),

            SizedBox(
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: tabs.map((e) => getCustomBottomNavigationBarItem(tab: e, context: context,),).toList(),),
            ),

          ],
        ),
      ),
    );
  }

  /// Function to build the custom bottom navigation bar item
  Widget getCustomBottomNavigationBarItem(
      {required Map<String, dynamic> tab, required BuildContext context,}
      ) {
    return SizedBox(
      height: 50,
      child: GestureDetector(
        onTap: () {
          /// Dispatch the event to change the window
          BlocProvider.of<WindowControllerBloc>(context).add(
            WindowChangedEvent(
              window: tab["route"],
              windowName: tab["name"],
            ),
          );
        },
        child: Column(children: [

          /// Icon widget to display the icon
          BlocBuilder<WindowControllerBloc, WindowControllerState>(builder: (context, state) {
            /// If the state is Initial state and tab name is home, then display the icon in primary color
            if(state is WindowControllerInitialState && tab["name"] == "Home") {
              return Image.asset(
                tab["icon"],
                width: 24,
                color: ThemeColors.primary,
              );
            }

            /// If the state is WindowControllerChangedState and tab name is same as the window name, then display the icon in primary color
            if(state is WindowControllerChangedState && state.windowName == tab["name"]) {
              return Image.asset(
                tab["icon"],
                width: 24,
                color: ThemeColors.primary,
              );
            }

            /// If the tab is not selected, then display the icon in grey color
            return Image.asset(
              tab["icon"],
              width: 24,
              color: ThemeColors.fontPrimary,
            );
          },),

          /// Text widget to display the title
          BlocBuilder<WindowControllerBloc, WindowControllerState>(builder: (context, state) {
            /// If the state is Initial state and tab name is home, then display the title in primary color
            if(state is WindowControllerInitialState && tab["name"] == "Home") {
              return Text(tab["name"], style: TextStyle(
                fontSize: 10,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
                color: ThemeColors.primary,
              ),);
            }

            /// If the state is WindowControllerChangedState and tab name is same as the window name, then display the title in primary color
            if(state is WindowControllerChangedState && state.windowName == tab["name"]) {
              return Text(tab["name"], style: TextStyle(
                fontSize: 10,
                fontFamily: "Roboto",
                fontWeight: FontWeight.w600,
                color: ThemeColors.primary,
              ),);
            }

            /// If the tab is not selected, then display the title in primary color
            return Text(tab["name"], style: TextStyle(
              fontSize: 10,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w600,
              color: ThemeColors.fontPrimary,
            ),);
          },),

        ],),
      ),
    );
  }

}

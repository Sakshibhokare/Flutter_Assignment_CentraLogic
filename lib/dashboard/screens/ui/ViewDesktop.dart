import 'package:assignment_4th_flutter/dashboard/bloc/add_user/add_user_bloc.dart';
import 'package:assignment_4th_flutter/dashboard/bloc/documents/document_bloc.dart';
import 'package:assignment_4th_flutter/dashboard/bloc/window_controller/window_controller_bloc.dart';
import 'package:assignment_4th_flutter/dashboard/screens/ScreenHomeTab.dart';
import 'package:assignment_4th_flutter/feedbackBot/bloc/feedbackBot_bloc.dart';
import 'package:assignment_4th_flutter/feedbackBot/screens/ScreenFeedbackBot.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/ThemeColors.dart';
import '../../bloc/documents/document_event.dart';
import '../../bloc/window_controller/window_controller_event.dart';
import '../../bloc/window_controller/window_controller_state.dart';
import 'ScreenDesktopDocuments.dart';

class ViewDesktop extends StatelessWidget {
  ViewDesktop({super.key});

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
        child: const ScreenDesktopDocuments(),
      ),
    },
  ];

  BuildContext? contextMain;

  final Widget selectedTab = const ScreenHomeTab();

  Size? mediaQuery;

  @override
  Widget build(BuildContext context) {
    mediaQuery =  MediaQuery.of(context).size;
    contextMain = context;

    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Row(
        children: [
          buildSideBar(width: MediaQuery.of(context).size.width * 0.15,),

          /// now displaying the widget according to the selected tab
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.85,
            height: MediaQuery.of(context).size.height,

            /// Using the bloc builder to listen to the changes in the selected tab
            child: BlocBuilder<WindowControllerBloc, WindowControllerState>(
              builder: (context, state) {
                if (state is WindowControllerChangedState) {
                  return state.window;
                }
                return selectedTab;
              },
            ),),
        ],
      ),
    );
  }

  /// Function to build the SideBar
  buildSideBar({required double width}) => Container(
    width: width,
    height: double.infinity,
    padding: const EdgeInsets.all(20),
    decoration: const BoxDecoration(
      border: Border.symmetric(
        horizontal: BorderSide.none,
        vertical: BorderSide(
          width: 0.5,
          color: Color.fromRGBO(
            230,
            230,
            230,
            1,
          ),
        ),
      ),
    ),
    child: Column(
      children: [
        /// logo
        Image.asset("assets/centraLogic.png", fit: BoxFit.contain,),

        /// Padding
        const SizedBox(
          height: 20,
        ),

        /// Horizontal divider
        const Divider(),

        /// Padding
        const SizedBox(
          height: 20,
        ),

        /// Displaying the tabs in the sidebar
        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 10,
            ),
            itemCount: tabs.length,
            itemBuilder: (context, index) =>

            /// List tile for the sidebar tabs
            ListTile(
              contentPadding: const EdgeInsets.all(0),
              onTap: () {
                /// Setting all the tabs to false
                for (var element in tabs) {
                  element["isSelected"] = false;
                }

                /*/// Setting the selected tab to true
                    tabs[index]["isSelected"] = true;

                    //selectedTab = tabs[index]["route"];*/

                debugPrint("Selected tab: ${tabs[index]["name"]}");

                /// Adding the event to the bloc
                context.read<WindowControllerBloc>().add(
                  WindowChangedEvent(
                    window: tabs[index]["route"],
                    windowName: tabs[index]["name"],
                  ),
                );
              },
              leading: BlocBuilder<WindowControllerBloc, WindowControllerState>(
                builder: (context, state) {
                  /// if the state is initial state then return the icon widget with the default color
                  if(state is WindowControllerInitialState && tabs[index]["name"] == "Home"){
                    return getTabIcon(iconPath: tabs[index]["icon"], color: ThemeColors.primary,);
                  }
                  /// if the state is changed state and the window name is equal to the tab name then return the icon widget with the selected color
                  if (state is WindowControllerChangedState && state.windowName == tabs[index]["name"]) {
                    return getTabIcon(iconPath: tabs[index]["icon"], color: ThemeColors.primary,);
                  }
                  /// else return the icon widget with the default color
                  return getTabIcon(iconPath: tabs[index]["icon"],);
                },
              ),
              title: mediaQuery!.width <= 1003.0 ? null : BlocBuilder<WindowControllerBloc, WindowControllerState>(
                builder: (context, state) {

                  /// if the state is initial state then return the text widget with the default color
                  if(state is WindowControllerInitialState && tabs[index]["name"] == "Home"){
                    return getTextWidget(text: tabs[index]["name"], color: ThemeColors.primary,);
                  }

                  /// if the state is changed state and the window name is equal to the tab name then return the text widget with the selected color
                  if (state is WindowControllerChangedState && state.windowName == tabs[index]["name"]) {
                    return getTextWidget(text: tabs[index]["name"], color: ThemeColors.primary,);
                  }
                  /// else return the text widget with the default color
                  return getTextWidget(text: tabs[index]["name"],);
                },
              ),),
          ),
        ),


        /// Displaying the button to open the feedback bot
        GestureDetector(
          onTap: () {
            /// Navigate to the feedback bot screen
            Navigator.of(contextMain!).push(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => FeedbackBotBloc(),
                  child: const ScreenFeedbackBot(),),
              ),);
          },
          child: Image.asset("assets/bot_logo.png", width: MediaQuery.of(contextMain!).size.width * 0.1,),
        ),
      ],
    ),
  );


  /// Function to build the icon
  getTabIcon({required String iconPath, Color? color = const Color.fromRGBO(
    48,
    48,
    48,
    1,
  ),}) => Image.asset(
    iconPath,
    /// Setting the color of the icon based on the isSelected value
    color: color,
  );


  /// Function to build Text Widget
  getTextWidget({required String text, Color color = const Color.fromRGBO(
    48,
    48,
    48,
    1,
  ),}) => Text(
    text,
    style: TextStyle(
      fontSize: mediaQuery!.width * 0.01,
      fontWeight: FontWeight.w400,
      fontFamily: "Roboto",
      color: color,
    ),
  );


}
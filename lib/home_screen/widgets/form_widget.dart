import 'package:assignment_4th_flutter/home_screen/bloc/sign_in_bloc.dart';
import 'package:assignment_4th_flutter/home_screen/bloc/sign_in_event.dart';
import 'package:assignment_4th_flutter/home_screen/bloc/sign_in_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../dashboard/bloc/add_user/add_user_bloc.dart';
import '../../dashboard/screens/ScreenHomeScreen.dart';

class FormWidget extends StatelessWidget {
  FormWidget({super.key});

  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController emailIdController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.1,
      ),
      child: Column(
        children: [
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInErrorState) {
                return Text(
                  state.errorMessage,
                  style: const TextStyle(color: Colors.red),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          const SizedBox(
            height: 10.0,
          ),

          /// Text form field for phone number
          TextField(
            controller: phoneNumberController,
            onChanged: (val) {
              BlocProvider.of<SignInBloc>(context).add(
                SignInPhoneNumberChangedEvent(
                  phoneNumberValue: phoneNumberController.text,
                ),
              );
            },
            decoration: InputDecoration(
              hintText: "Enter Phone No.",
              hintStyle: const TextStyle(color: Colors.grey),
              fillColor: const Color.fromRGBO(203, 229, 251, 1),
              filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.phone_outlined,
                  size: size.width > 800
                      ? size.width * 0.017
                      : size.width * 0.065,
                  color: Colors.grey,
                ),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),

          const SizedBox(
            height: 20.0,
          ),

          /// Text form field for email id
          TextField(
            controller: emailIdController,
            onChanged: (val) {
              BlocProvider.of<SignInBloc>(context).add(
                SignInEmailChangedEvent(emailIdValue: emailIdController.text),
              );
            },
            decoration: InputDecoration(
              helperText: "optional*",
              helperStyle: TextStyle(
                color: size.width > 400 ? Colors.grey : Colors.white,
                fontSize: size.width > 400 ? 10.0 : 12.0,
                fontWeight: FontWeight.w500,
              ),
              hintText: "Enter Email iD",
              hintStyle: const TextStyle(color: Colors.grey),
              fillColor: const Color.fromRGBO(203, 229, 251, 1),
              filled: true,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(
                  Icons.email_outlined,
                  size: size.width > 800
                      ? size.width * 0.017
                      : size.width * 0.065,
                  color: Colors.grey,
                ),
              ),
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(
            height: 20.0,
          ),

          /// Elevated button to send OTP
          BlocBuilder<SignInBloc, SignInState>(
            builder: (context, state) {
              if (state is SignInLoadingState) {
                return const CircularProgressIndicator();
              }

              if (state is SignInValidState) {
                /// Adding a callback to check if state becomes valid
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => BlocProvider<AddUserBloc>(
                      create: (context) => AddUserBloc(),
                      child: const
                      ScreenHomeScreen(),
                    ),
                  ));
                });
              }

              /// Returning the button
              return buildElevatedButton(
                onPressed: () async {
                  if (state is! SignInValidState) {
                    BlocProvider.of<SignInBloc>(context).add(
                      SignInSubmittedEvent(
                        phoneNumber: phoneNumberController.text,
                        emailId: emailIdController.text,
                      ),
                    );
                  }
                },
                size: size,
              );
            },
          ),
        ],
      ),
    );
  }

  /// Function to build the send otp button widget
  buildElevatedButton({required VoidCallback? onPressed, required Size size}) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          Size(size.width * 0.8, size.height * 0.06),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        backgroundColor: MaterialStateProperty.all(
          const Color.fromRGBO(1, 60, 110, 1),
        ),
      ),
      child: const Text(
        "Send OTP",
        style: TextStyle(
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
    );
  }
}

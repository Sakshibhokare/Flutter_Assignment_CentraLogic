import 'package:assignment_4th_flutter/home_screen/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/sign_in_bloc.dart';

buildLeftView({required Size size, required double containerWidth, required double containerHeight,}) {
  return Container(
    width: containerWidth,
    height: containerHeight,
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('assets/auth_img.png'),
        fit: BoxFit.cover,
      ),
    ),
    child: Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: size.width > 800 ? size.height * 0.2 : size.height * 0.1,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0x00414141).withOpacity(0.3),
              const Color(0x00414141).withOpacity(0.9),
              const Color(0x00414141).withOpacity(0.9),
            ],
          ),
        ),
        padding: const EdgeInsets.only(top: 10.0,),
        child: Align(
          alignment: Alignment.center,
          child: Text("Dream • Connect • Achieve", style: getTextStyle(size),),),
      ),
    ),
  );
}

getTextStyle(Size size) {
  if(size.width <= 400) {
    return TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: size.width * 0.05,);
  }
  return TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: size.width * 0.02,);
}



buildRightView({required Size size, required double containerWidth, required double containerHeight,}) {
  return Container(
    width: containerWidth,
    height: size.width > 800 ? containerHeight : containerHeight * 0.8,
    color: size.width > 800 ? Colors.white : Colors.transparent,
    margin: EdgeInsets.only(top: size.height * 0.1,),
    child: size.width >= 400 && size.width < 800 ? SingleChildScrollView(
      child: buildColumnWidget(size),
    ) : buildColumnWidget(size),
  );
}

buildColumnWidget(Size size) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Image.asset("assets/centra_job.png", width: size.width > 800 ? size.width * 0.25 : size.width * 0.7,),

      buildSocialLoginButtons(size: size,),

      BlocProvider(create: (context) => SignInBloc(), child: FormWidget(),),

      Text("© 2023, CentraLogic Pvt. Ltd. All Rights Reserved.", style: TextStyle(color: size.width > 800 ? const Color.fromRGBO(149, 169, 177, 1,) : Colors.white, fontSize: size.width > 800 ? size.width * 0.01 : size.width * 0.035, fontWeight: FontWeight.w600, fontFamily: "Poppins",),),
    ],
  );
}

buildSocialLoginButtons({required Size size}) {
  return SizedBox(
    width: size.width > 800 ? size.width * 0.5 : size.width * 0.8,
    height: size.width > 800 ? size.height * 0.2234 : size.width <= 400 ? size.height * 0.2 : size.height * 0.3,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Log In With", textAlign: TextAlign.center, style: TextStyle(fontSize: size.width > 800 ? size.width * 0.015 : size.width * 0.07, color: Colors.black, fontFamily: "Mulish", fontWeight: FontWeight.w600,),),
        const SizedBox(height: 15.0,),
        SizedBox(
          width: size.width > 800 ? size.width * 0.3 : size.width * 0.8,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildButtonContainer("assets/google_logo.png",size,),
              buildButtonContainer("assets/facebook_logo.png",size,),
              buildButtonContainer("assets/apple_logo.png",size,),
            ],
          ),
        ),
        const SizedBox(height: 15.0,),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: size.width > 800 ? size.width * 0.2 : size.width * 0.3,
              child: Divider(
                indent: size.width > 800 ? size.width * 0.03 : size.width * 0.0,
                color: size.width > 800 ? const Color.fromRGBO(123, 135, 148, 1,) : Colors.white,
              ),),
            const SizedBox(width: 10.0,),
            Text("OR", style: size.width > 800 ? TextStyle(color: const Color.fromRGBO(97, 110, 124, 1,), fontSize: size.width * 0.01, fontWeight: FontWeight.w400,) : TextStyle(color: Colors.white, fontSize: size.width * 0.04, fontWeight: FontWeight.w400,),),
            const SizedBox(width: 10.0,),
            SizedBox(
              width: size.width > 800 ? size.width * 0.2 : size.width * 0.3,
              child: Divider(
                endIndent: size.width > 800 ? size.width * 0.03 : size.width * 0.0,
                color: size.width > 800 ? const Color.fromRGBO(123, 135, 148, 1,) : Colors.white,
              ),),
          ],
        ),
      ],
    ),
  );
}

buildButtonContainer(String assetPath, Size size,) {
  return Container(
    width: size.width > 800 ? 80 : size.width <= 400 ? 65 : 70,
    height: size.width > 800 ? 80 : size.width <= 400 ? 65 : 70,
    decoration: BoxDecoration(
      border: Border.all(color: size.width > 800 ? const Color.fromRGBO(183, 183, 183, 1) : Colors.white, width: 1,),
      borderRadius: BorderRadius.circular(08.0),
    ),
    padding: const EdgeInsets.all(10.0),
    child: Image.asset(assetPath, width: size.width * 0.08,),
  );
}
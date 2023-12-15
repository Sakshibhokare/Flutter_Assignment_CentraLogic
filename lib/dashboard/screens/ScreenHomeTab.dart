import 'package:assignment_4th_flutter/dashboard/bloc/add_user/add_user_bloc.dart';
import 'package:assignment_4th_flutter/dashboard/bloc/add_user/add_user_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/add_user/add_user_event.dart';
import '../models/user_model.dart';

class ScreenHomeTab extends StatefulWidget {
  const ScreenHomeTab({super.key});

  @override
  State<ScreenHomeTab> createState() => _ScreenHomeTabState();
}

class _ScreenHomeTabState extends State<ScreenHomeTab> {
  final controllers = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  final List requiredDetails = [
    "Name",
    "Phone Number",
    "Email ID",
  ];

  List<UserModel> users = [];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddUserBloc(),
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: MediaQuery.of(context).size.width <= 400 ? MediaQuery.of(context).size.height * 0.06 : MediaQuery.of(context).size.height * 0.1,
          title: Text(
            "Welcome to CentraJob",
            style: TextStyle(
              fontSize: MediaQuery.of(context).size.width <= 400 ? MediaQuery.of(context).size.width * 0.05 : MediaQuery.of(context).size.width * 0.02,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontStyle: FontStyle.italic,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.amber,
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              BlocBuilder<AddUserBloc, AddUserState>(
                builder: (context, state) {
                  if (state is AddUserErrorState) {
                    return SizedBox(
                      height: 20,
                      child: Text(
                        state.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),


              buildAddUser(context),


              const SizedBox(height: 20,),


              Flexible(
                fit: FlexFit.tight,
                child: ListView.builder(
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    return Card(

                      child: ListTile(
                        title: Text(users[index].name),
                        subtitle: Text(users[index].emailId),
                        trailing: SizedBox(
                          width: MediaQuery.of(context).size.width <= 400 ? MediaQuery.of(context).size.width * 0.15 : MediaQuery.of(context).size.width * 0.097,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controllers[0].text = users[index].name;
                                  controllers[1].text = users[index].phoneNumber;
                                  controllers[2].text = users[index].emailId;
                                  users.removeAt(index);
                                  setState(() {});
                                },
                                child: Icon(Icons.edit, color: Colors.amber.shade300,),
                              ),
                              GestureDetector(
                                onTap: () {
                                  users.removeAt(index);
                                  setState(() {});
                                },
                                child: const Icon(Icons.delete, color: Colors.red,),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }

  buildAddUser(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.width <= 400 ? MediaQuery.of(context).size.height * 0.3 : MediaQuery.of(context).size.height * 0.13,
          child: getTextFields(),
        ),


        const SizedBox(height: 20,),

        ElevatedButton(onPressed: _addUser, style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(topRight: Radius.circular(45), bottomLeft: Radius.circular(45), topLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
            ),
          ),
          fixedSize: MaterialStateProperty.all(Size(MediaQuery.of(context).size.width * 0.3, MediaQuery.of(context).size.height * 0.05)),
          backgroundColor: MaterialStateProperty.all(Colors.amber.shade400),
        ), child: const Text("Add User", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500,),),),

      ],
    );
  }


  getTextFields() =>
      ListView.builder(
        scrollDirection: MediaQuery.of(context).size.width <= 400 ? Axis.vertical : Axis.horizontal,
        itemCount: requiredDetails.length,
        itemBuilder: (context, index) => Container(
          width: MediaQuery.of(context).size.width <= 400 ? MediaQuery.of(context).size.width * 0.9 : MediaQuery.of(context).size.width * 0.26,
          margin: EdgeInsets.only(top: MediaQuery.of(context).size.width <= 400 ? MediaQuery.of(context).size.height * 0.01 : 0.0, left: MediaQuery.of(context).size.width <= 400 ? 0.0 : MediaQuery.of(context).size.width * 0.01, right: MediaQuery.of(context).size.width <= 400 ? 0.0 : MediaQuery.of(context).size.width * 0.01,),
          child: TextField(
            controller: controllers[index],
            onChanged: (value) {
              if(requiredDetails[index] == "Email ID") {
                BlocProvider.of<AddUserBloc>(context).add(UserEmailIdChangedEvent(emailId: controllers[index].text,),);
              } else if(requiredDetails[index] == "Phone Number") {
                BlocProvider.of<AddUserBloc>(context).add(UserPhoneNumberChangedEvent(phoneNumber: controllers[index].text,),);
              }
            },
            decoration: InputDecoration(
              hintText: requiredDetails[index],
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15),
                  topRight: Radius.circular(05),
                  bottomLeft: Radius.circular(05),
                ),
              ),
            ),
          ),
        ),
      );



  void _addUser() {
    if(controllers[0].text.isNotEmpty && controllers[1].text.isNotEmpty && controllers[2].text.isNotEmpty) {
      users.add(UserModel(name: controllers[0].text, phoneNumber: controllers[1].text, emailId: controllers[2].text),);
      setState(() {});
      controllers[0].clear();
      controllers[1].clear();
      controllers[2].clear();
    } else {
      debugPrint("Error: Please fill all the details.");
    }
  }
}

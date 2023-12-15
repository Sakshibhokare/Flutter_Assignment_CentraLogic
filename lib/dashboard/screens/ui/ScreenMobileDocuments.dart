import 'package:assignment_4th_flutter/dashboard/bloc/documents/document_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../utils/ThemeColors.dart';
import '../../bloc/documents/document_bloc.dart';
import 'WidgetMobileListDocuments.dart';
import 'WidgetMobileTransactionDocuments.dart';

class ScreenMobileDocuments extends StatefulWidget {
  const ScreenMobileDocuments({super.key});

  @override
  State<ScreenMobileDocuments> createState() => _ScreenMobileDocumentsState();
}

class _ScreenMobileDocumentsState extends State<ScreenMobileDocuments> {

  final List<String> typesOfDocument = [
    "Joining Document",
    "Transaction Document",
    "Team Documents",
    "Tax Document",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// Fetch documents data at initial state
    BlocProvider.of<DocumentBloc>(context).add(
      DocumentsInitialFetchEvent(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// Remove button
        automaticallyImplyLeading: false,

        /// Set title
        title: Text(
          "Documents",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
            color: ThemeColors.fontPrimary,
          ),
        ),

        /// Set center title
        centerTitle: true,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        child: ListView.builder(
          itemBuilder: (context, index) => SizedBox(
            height: 60,
            child: ListTile(
              contentPadding: EdgeInsets.zero,
              /// Set onTap event to navigate to the document list screen
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    /// if the type of document is transaction document, then navigate to transaction document screen otherwise navigate to list document screen
                    builder: (context) => typesOfDocument[index] == "Transaction Document" ? WidgetMobileTransactionDocuments(typeOfDocument: typesOfDocument[index],) : WidgetMobileListDocuments(
                      typeOfDocument: typesOfDocument[index],
                    ),
                  ),
                );
              },
              /// Set border
              shape: const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Color.fromRGBO(
                    48,
                    48,
                    48,
                    0.05,
                  ),
                  width: 1,
                ),
              ),

              /// Set title
              title: Text(
                typesOfDocument[index],
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  color: ThemeColors.fontPrimary,
                ),
              ),

              /// Set trailing icon
              trailing: Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: ThemeColors.fontPrimary,
              ),
            ),
          ),
          itemCount: typesOfDocument.length,
        ),
      ),
    );
  }
}
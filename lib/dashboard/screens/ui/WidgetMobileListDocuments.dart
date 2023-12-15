import 'package:flutter/material.dart';

import '../../models/ModelDocuments.dart';
import 'ScreenDesktopDocuments.dart';

class WidgetMobileListDocuments extends StatelessWidget {
  const WidgetMobileListDocuments({
    super.key,
    required this.typeOfDocument,
  });

  final String typeOfDocument;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        /// Remove back button
        automaticallyImplyLeading: false,

        /// Set a custom back button
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.grey,
            size: 16,
          ),
        ),

        /// Set title
        title: Text(
          typeOfDocument,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),

        /// Set center title
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20,),
        child: buildOtherTabs(
          documents: getDocumentsToLoad(),
        ),
      ),
    );
  }


  /// Function to identify which documents to load based on the type of document
  getDocumentsToLoad() => switch (typeOfDocument) {
    "Joining Document"=> DocumentsData.joining,
    "Team Documents"=> DocumentsData.team,
    "Tax Document"=> DocumentsData.tax,
  // TODO: Handle this case.
    String() => null,
  };

}

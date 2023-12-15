import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:assignment_4th_flutter/dashboard/models/ModelDocuments.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

import '../../../utils/ThemeColors.dart';

class ScreenMobileViewTransaction extends StatelessWidget {
  const ScreenMobileViewTransaction({
    super.key,
    required this.transaction,
  });

  final Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final scaffoldMessengerContext = ScaffoldMessenger.of(context);

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
        title: const Text(
          "Transaction Document",
          textAlign: TextAlign.center,
          style: TextStyle(
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
        padding: const EdgeInsets.symmetric(
          vertical: 20.0,
          horizontal: 19.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// call to function to build the disabled text field to display the transaction address
            SizedBox(
              height: 62,
              child: getDisableTextField(
                label: "Transaction Address",
                value: TextEditingController(
                  text: transaction.address,
                ),
              ),
            ),

            /// Padding
            const SizedBox(
              height: 20,
            ),

            /// call to function to build the disabled text field to display the transaction id
            SizedBox(
              height: 62,
              child: getDisableTextField(
                label: "Transaction ID",
                value: TextEditingController(
                  text: "#${transaction.transactionId}",
                ),
              ),
            ),

            /// Padding
            const SizedBox(
              height: 20,
            ),

            /// call to function to build the list of documents
            getListOfDocuments(
              height: MediaQuery.of(context).size.height * 0.3,
              scaffoldMessengerContext: scaffoldMessengerContext,
            ),
          ],
        ),
      ),
    );
  }

  /// Function to build the disabled text field to display the transaction address and id
  getDisableTextField({
    required String label,
    required TextEditingController value,
  }) =>
      TextField(
        /// Set the textEditingController
        controller: value,

        /// Disable the text field
        enabled: false,

        /// Set the style of the text
        style: TextStyle(
          fontSize: 16,
          fontFamily: "Roboto",
          fontWeight: FontWeight.w400,
          color: ThemeColors.fontPrimaryDark,
        ),
        decoration: InputDecoration(
          /// Set label text
          label: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontFamily: "Roboto",
              fontWeight: FontWeight.w400,
              color: ThemeColors.fontPrimaryLight,
            ),
          ),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColors.fontPrimaryLight,
            ),
          ),
        ),
      );

  /// Function to build the list of documents
  getListOfDocuments({required double height, required scaffoldMessengerContext,}) => SizedBox(
    height: height,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// Text widget to display the Section title
        Text(
          "Document Name",
          style: TextStyle(
            fontSize: 12,
            fontFamily: "Roboto",
            fontWeight: FontWeight.w400,
            color: ThemeColors.fontPrimaryLight,
          ),
        ),

        /// Padding
        const SizedBox(
          height: 08,
        ),

        Expanded(
          child: ListView.separated(
            separatorBuilder: (context, index) => const SizedBox(
              height: 16,
            ),
            itemBuilder: (context, index) => ListTile(
              contentPadding: const EdgeInsets.all(0),
              /// Text widget to display the title of the transaction document
              title: Text(
                transaction.documents[index].title,
                style: TextStyle(
                  fontSize: 16,
                  fontFamily: "Roboto",
                  fontWeight: FontWeight.w400,
                  color: ThemeColors.fontPrimaryDark,
                ),
              ),
              /// IconButton widget to open the transaction document
              trailing: IconButton(
                onPressed: () async {
                  /// loading the pdf from the url using http get method
                  final res = await http.get(Uri.parse(transaction.documents[index].url));
                  /// getting the bytes from the response body
                  final bytes = res.bodyBytes;
                  /// getting the application directory
                  final dir = await getApplicationDocumentsDirectory();
                  /// creating a file with the name dummyPdf.pdf
                  final file = File("${dir.path}dummyPdf.pdf");
                  /// writing the bytes to the file
                  await file.writeAsBytes(bytes, flush: true);
                  /// Open the file
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          automaticallyImplyLeading: true,
                        ),
                        body: Container(
                          width: double.infinity,
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color.fromRGBO(
                                48,
                                48,
                                48,
                                0.05,
                              ),
                              width: 1,
                            ),
                          ),
                          child: PdfView(path: file.path,),),
                      ),
                    ),
                  );
                },
                icon: Icon(
                  Icons.remove_red_eye_outlined,
                  color: ThemeColors.iconPrimary,
                  size: 22,
                ),
              ),

            ),
            itemCount: transaction.documents.length,
          ),
        ),
      ],
    ),
  );
}

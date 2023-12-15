import 'package:assignment_4th_flutter/dashboard/models/ModelDocuments.dart';
import 'package:assignment_4th_flutter/utils/ThemeColors.dart';
import 'package:flutter/material.dart';

import 'ScreenMobileViewTransaction.dart';

class WidgetMobileTransactionDocuments extends StatelessWidget {
  const WidgetMobileTransactionDocuments({
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
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          /// card to display each document address
          itemBuilder: (context, index) => Card(
            elevation: 0,
            margin: const EdgeInsets.all(20.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListTile(
                contentPadding: const EdgeInsets.all(0),
                title:

                /// Text widget to display the address of the transaction document
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: Text(
                    DocumentsData.transactions[index].address,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: "Roboto",
                      fontWeight: FontWeight.w600,
                      color: ThemeColors.fontPrimary,
                    ),
                  ),
                ),

                subtitle:

                /// RichText widget to display the ID of the transaction document with two different colors
                RichText(
                  text: TextSpan(
                    children: [
                      /// TextSpan widget to display the text "Transaction ID: "
                      TextSpan(
                        text: "Transaction ID: ",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w300,
                          color: ThemeColors.fontPrimaryLight,
                        ),
                      ),

                      /// TextSpan widget to display the ID of the transaction document
                      TextSpan(
                        text:
                        "#${DocumentsData.transactions[index].transactionId}",
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: "Roboto",
                          fontWeight: FontWeight.w400,
                          color: ThemeColors.fontPrimaryDark,
                        ),
                      ),
                    ],
                  ),
                ),

                /// Trailing icon to open the transaction document
                trailing: IconButton(
                  onPressed: () {
                    /// Navigate to the transaction document screen
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => ScreenMobileViewTransaction(transaction: DocumentsData.transactions[index],),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.grey,
                    size: 16,
                  ),
                ),
              ),
            ),
          ),
          itemCount: DocumentsData.transactions.length,
        ),
      ),
    );
  }
}


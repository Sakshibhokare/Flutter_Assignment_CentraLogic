import 'dart:convert';

import 'package:assignment_4th_flutter/dashboard/bloc/documents/document_event.dart';
import 'package:assignment_4th_flutter/dashboard/bloc/documents/document_state.dart';
import 'package:assignment_4th_flutter/dashboard/models/ModelDocuments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DocumentBloc extends Bloc<DocumentsEvent, DocumentsState> {
  DocumentBloc()
      : super(
    DocumentsInitialState(),
  ) {
    on<DocumentsInitialFetchEvent>(
      documentsFetchEvent,
    );


    on<LoadTransactionDocumentsEvent>(
          (event, emit) {
        debugPrint('Transaction ID: ${event.transactionId}');
        debugPrint("Transaction Documents: ${DocumentsData.transactions[0].documents}");
        emit(
          ShowTransactionDocumentsState(
            transactionId: event.transactionId,
          ),
        );
      },
    );

    on<HideTransactionDocumentsEvent>(
          (event, emit) {
        emit(
          HideTransactionDocumentsState(
            transactionId: event.transactionId,
          ),
        );
      },
    );

  }

  void documentsFetchEvent(
      DocumentsInitialFetchEvent event, Emitter<DocumentsState> emit) async {
    String jsonString =
    await rootBundle.loadString('assets/json/documents.json');

    ModelDocuments documentsModel =
    ModelDocuments.fromJson(jsonDecode(jsonString));


    List<Value> values = documentsModel.value;


    DocumentsData.setDocumentsData(
      transactions: values[0].transaction,
      team: values[0].team,
      tax: values[0].tax,
      joining: values[0].joining,
    );
    emit(DocumentsFetchedState());

  }
}

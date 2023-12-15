import '../../models/ModelDocuments.dart';

abstract class DocumentsState {}

class DocumentsInitialState extends DocumentsState {}

class DocumentsFetchedState extends DocumentsState {}

class ShowTransactionDocumentsState extends DocumentsState {
  final int transactionId;

  ShowTransactionDocumentsState({required this.transactionId,});
}

class HideTransactionDocumentsState extends DocumentsState {
  final int transactionId;

  HideTransactionDocumentsState({required this.transactionId,});
}
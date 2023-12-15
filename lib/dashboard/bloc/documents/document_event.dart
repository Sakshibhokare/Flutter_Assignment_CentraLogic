abstract class DocumentsEvent {}

class DocumentsInitialFetchEvent extends DocumentsEvent {

}

class LoadTransactionDocumentsEvent extends DocumentsEvent {
  final int transactionId;

  LoadTransactionDocumentsEvent({required this.transactionId,});
}

class HideTransactionDocumentsEvent extends DocumentsEvent {
  final int transactionId;

  HideTransactionDocumentsEvent({required this.transactionId,});
}
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService{
  final CollectionReference orders =
  FirebaseFirestore.instance.collection('Wynajem');

  Future<void> saveOrdertoDatabase(String receipt) async{
    await orders.add({
      'data': DateTime.now(),
      'order': receipt,
   });
  }
}
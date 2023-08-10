import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:qr_google_play/models/barcode_model.dart';

class BarcodeDatabase{
  static CollectionReference<MyBarcode> getBarcodesCollection() {
    return FirebaseFirestore.instance
        .collection(MyBarcode.COLLECTION_NAME)
        .withConverter<MyBarcode>(
      fromFirestore: (snapshot, options) =>
          MyBarcode.fromJson(snapshot.data()!),
      toFirestore: (value, options) => value.toJson(),
    );
  }


  static Future<void> addBarcodeToFirebase(MyBarcode barcode) {
    var collection = getBarcodesCollection();
    var docRef = collection.doc();
    barcode.id = docRef.id;
    return docRef.set(barcode);
  }

  static Stream<QuerySnapshot<MyBarcode>> readBarcodesFormFirebase() {
    return getBarcodesCollection().snapshots();
  }

  static Future<void> deleteBarcode(String id) {
    return getBarcodesCollection().doc(id).delete();
  }

  static Future<void> updateStageInFirebase(MyBarcode barcode) {
    return getBarcodesCollection()
        .doc(barcode.id)
        .update(barcode.toJson());
  }

}
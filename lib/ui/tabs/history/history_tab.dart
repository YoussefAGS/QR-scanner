import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:qr_google_play/database_utils/barcode_utils.dart';
import 'package:qr_google_play/models/barcode_model.dart';
import 'package:qr_google_play/ui/tabs/history/history_item.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('History'.tr(),style: TextStyle(
          color: Colors.black87,
          fontFamily: "Poppins",
          fontSize: 25,
          fontWeight: FontWeight.w600,
        ),),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
      ),


      body: StreamBuilder<QuerySnapshot<MyBarcode>>(
        stream: BarcodeDatabase.readBarcodesFormFirebase(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
                child:
                Text('HomeView: ${snapshot.error.toString()}'));
          } else if (snapshot.hasData) {
            var barcodes =
            snapshot.data!.docs.map((e) => e.data()).toList();
            return ListView.builder(
              itemBuilder: (context, index) {
                return HistoryItem(barcodes[index]);
              },
              itemCount: barcodes.length,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

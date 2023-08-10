class MyBarcode {
  static const String COLLECTION_NAME = 'Users';
  String? id ;
  String barcodeType;
  String barcodeContent;
  String barcodeDate;
  MyBarcode({required this.id, required this.barcodeType, required this.barcodeContent,required this.barcodeDate});

  MyBarcode.fromJson(Map<String, dynamic> json)
      : this(
      id: json['id'],
    barcodeType: json['barcode Type'],
    barcodeContent: json['barcode Content'],
    barcodeDate: json['barcode Date'],
  );

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "barcode Type": barcodeType,
      "barcode Content": barcodeContent,
      "barcode Date": barcodeDate,
    };
  }
}
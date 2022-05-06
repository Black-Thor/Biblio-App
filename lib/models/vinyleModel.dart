class Discogs {
  final int id;
  final String? title;
  final String? coverImage;
  final String? country;
  final String? year;

  Discogs(
    this.id,
    this.title,
    this.coverImage,
    this.country,
    this.year,
  );
  factory Discogs.fromMap(Map<String, dynamic> json) {
    return Discogs(json['id'], json['title'], json['cover_image'],
        json['country'], json['year']);
  }
  factory Discogs.fromJson(Map<String, dynamic> json) {
    return Discogs(json['id'], json['title'], json['cover_image'],
        json['country'], json['year']);
  }
}

class Barcode {
  final int code;

  Barcode(
    this.code,
  );

  factory Barcode.fromDynamic(dynamic barcode) {
    return Barcode(barcode);
  }
}

class BarcodeCollection extends Iterable {
  final Iterable<Barcode> _barcodeCollection;

  BarcodeCollection(this._barcodeCollection);

  factory BarcodeCollection.fromDynamicList(Iterable<dynamic> barcodes) {
    return BarcodeCollection(barcodes.map(Barcode.fromDynamic));
  }

  @override
  String toString() {
    return _barcodeCollection.join(',');
  }

  @override
  Iterator get iterator {
    throw UnimplementedError();
  }
}

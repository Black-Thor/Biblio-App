class Discogs {
  final int id;
  final String? title;
  final String? coverImage;
  final String? country;
  final String? year;
  final List<dynamic>? genre;

  Discogs(
    this.id,
    this.title,
    this.coverImage,
    this.country,
    this.year,
    this.genre,
  );
  factory Discogs.fromMap(Map<String, dynamic> json) {
    return Discogs(json['id'], json['title'], json['cover_image'],
        json['country'], json['year'], json['genre']);
  }
  factory Discogs.fromJson(Map<String, dynamic> json) {
    return Discogs(json['id'], json['title'], json['cover_image'],
        json['country'], json['year'], json['genre']);
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

class Discogs {
  final int id;
  final String? title;
  final String? coverImage;
  final String? country;
  final String? year;
  final List<dynamic>? genre;
  final List<dynamic>? barcode;

  Discogs(this.id, this.title, this.coverImage, this.country, this.year,
      this.genre, this.barcode);
  factory Discogs.fromMap(Map<String, dynamic> json) {
    return Discogs(json['id'], json['title'], json['cover_image'],
        json['country'], json['year'], json['genre'], json['barcode']);
  }
  factory Discogs.fromJson(Map<String, dynamic> json) {
    return Discogs(json['id'], json['title'], json['cover_image'],
        json['country'], json['year'], json['genre'], json['barcode']);
  }
}

class VinylBarcode {
  final int code;

  VinylBarcode(
    this.code,
  );

  factory VinylBarcode.fromDynamic(dynamic barcode) {
    return VinylBarcode(barcode);
  }
}

class BarcodeCollection extends Iterable {
  final Iterable<VinylBarcode> _barcodeCollection;

  BarcodeCollection(this._barcodeCollection);

  factory BarcodeCollection.fromDynamicList(Iterable<dynamic> barcodes) {
    return BarcodeCollection(barcodes.map(VinylBarcode.fromDynamic));
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

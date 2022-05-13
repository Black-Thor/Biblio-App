class GoogleBooks {
  final String id;
  final VolumeInfo? volumeInfo;

  GoogleBooks(
    this.id,
    this.volumeInfo,
  );
  factory GoogleBooks.fromMap(Map<String, dynamic> json) {
    return GoogleBooks(json['etag'], json['volumeInfo']);
  }
  factory GoogleBooks.fromJson(Map<String, dynamic> json) {
    return GoogleBooks(json['etag'], VolumeInfo.fromJson(json['volumeInfo']));
  }
}

class VolumeInfo {
  final String? title;
  final List<dynamic>? authors;
  final String? publishedDate;
  final String? description;
  List<IndustryIdentifiers>? industryIdentifiers;

  VolumeInfo(
    this.title,
    this.authors,
    this.publishedDate,
    this.description,
    this.industryIdentifiers,
  );

  factory VolumeInfo.fromMap(Map<String, dynamic> json) {
    return VolumeInfo(json['title'], json['authors'], json['publishedDate'],
        json['description'], json['industryIdentifiers']);
  }

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    List<IndustryIdentifiers>? Identifier =
        (json["industryIdentifiers"] as List)
            .map((i) => IndustryIdentifiers.fromJson(i))
            .toList();

    return VolumeInfo(json['title'], json['authors'], json['publishedDate'],
        json['description'], Identifier);
  }
}

class IndustryIdentifiers {
  String? type;
  String? identifier;

  IndustryIdentifiers(this.type, this.identifier);

  factory IndustryIdentifiers.fromJson(Map<String, dynamic> json) {
    return IndustryIdentifiers(
      json['type'],
      json['identifier'],
    );
  }
}

class ImageLinks {
  final List<dynamic>? thumbnail;

  ImageLinks(this.thumbnail);

  factory ImageLinks.fromMap(Map<String, dynamic> json) {
    return ImageLinks(
      json['thumbnail'],
    );
  }
  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(
      json['thumbnail'],
    );
  }
}

class BookBarcode {
  final int code;

  BookBarcode(
    this.code,
  );

  factory BookBarcode.fromDynamic(dynamic barcode) {
    return BookBarcode(barcode);
  }
}

class BarcodeCollection extends Iterable {
  final Iterable<BookBarcode> _barcodeCollection;

  BarcodeCollection(this._barcodeCollection);

  factory BarcodeCollection.fromDynamicList(Iterable<dynamic> barcodes) {
    return BarcodeCollection(barcodes.map(BookBarcode.fromDynamic));
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

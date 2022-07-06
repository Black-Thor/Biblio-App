import 'package:bibliotrack/resource/convertion.dart';

class GoogleBooks {
  final String id;
  final VolumeInfo? volumeInfo;

  GoogleBooks(
    this.id,
    this.volumeInfo,
  );

  factory GoogleBooks.fromJson(Map<String, dynamic> json) {
    return GoogleBooks(json['etag'], VolumeInfo.fromJson(json['volumeInfo']));
  }

  factory GoogleBooks.fromDynamic(dynamic value) {
    return GoogleBooks.fromJson(value);
  }

  getISBN13() {
    return this.volumeInfo!.getISBN13();
  }
}

class VolumeInfo {
  final String? title;
  final List<dynamic>? authors;
  final String? publishedDate;
  final String? description;
  List<IndustryIdentifiers>? industryIdentifiers;
  final int? pageCount;

  VolumeInfo(
    this.title,
    this.authors,
    this.publishedDate,
    this.description,
    this.industryIdentifiers,
    this.pageCount,
  );

  factory VolumeInfo.fromJson(Map<String, dynamic> json) {
    List<IndustryIdentifiers>? Identifier =
        (json["industryIdentifiers"] as List)
            .map((i) => IndustryIdentifiers.fromJson(i))
            .toList();

    return VolumeInfo(
      json['title'],
      json['authors'],
      json['publishedDate'],
      json['description'],
      Identifier,
      json['pageCount'],
    );
  }

  getISBN13() {
    return this.industryIdentifiers!.last.identifier;
  }
}

class IndustryIdentifiers {
  String type;
  String identifier;

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

  factory ImageLinks.fromJson(Map<String, dynamic> json) {
    return ImageLinks(
      json['thumbnail'],
    );
  }
}

class BookBarcode {
  final String code;

  BookBarcode(
    this.code,
  );

  factory BookBarcode.fromString(String barcode) {
    return BookBarcode(barcode);
  }

  factory BookBarcode.fromDynamic(dynamic barcode) {
    return BookBarcode.fromString(barcode);
  }
}

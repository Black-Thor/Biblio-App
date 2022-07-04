class Discogs {
  final int id;
  final String? title;
  final String? coverImage;
  final String? country;
  final String? year;
  final List<dynamic>? genre;
  final List<dynamic>? barcode;
  final String catno;

  Discogs(
    this.id,
    this.title,
    this.coverImage,
    this.country,
    this.year,
    this.genre,
    this.barcode,
    this.catno,
  );

  factory Discogs.fromJson(Map<String, dynamic> json) {
    return Discogs(
      json['id'],
      json['title'],
      json['cover_image'],
      json['country'],
      json['year'],
      json['genre'],
      json['barcode'],
      json["catno"],
    );
  }

  factory Discogs.fromDynamic(dynamic value) {
    return Discogs.fromJson(value);
  }
}

class VinylBarcode {
  final String code;

  VinylBarcode(
    this.code,
  );

  factory VinylBarcode.fromString(String barcode) {
    return VinylBarcode(barcode);
  }

  factory VinylBarcode.fromDynamic(dynamic barcode) {
    return VinylBarcode.fromString(barcode);
  }
}

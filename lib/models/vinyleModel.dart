class Discogs {
  final int id;
  final String? title;
  final String? coverImage;
  final String? country;
  final String? year;

  Discogs(this.id, this.title, this.coverImage, this.country, this.year);
  factory Discogs.fromMap(Map<String, dynamic> json) {
    return Discogs(json['id'], json['title'], json['cover_image'],
        json['country'], json['year']);
  }
  factory Discogs.fromJson(Map<String, dynamic> json) {
    return Discogs(json['id'], json['title'], json['cover_image'],
        json['country'], json['year']);
  }
}

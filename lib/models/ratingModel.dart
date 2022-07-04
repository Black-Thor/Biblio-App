class UserRating {
  final List<int> Vinyls;
  final List<int> Books;
  //final double rating;

  UserRating(
    this.Vinyls,
    this.Books,
  );

  factory UserRating.fromJson(Map<String, dynamic> json) {
    return UserRating(
      json['Vinyls'],
      json['Books'],
    );
  }
}

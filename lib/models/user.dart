class User {
  //These are the values that this Demo model can store
  String uid;
  String username;
  String email;

  User({
    this.uid = '',
    required this.username,
    required this.email,
  });

  Map<String, dynamic> toJson() => {
        'uid': uid,
        'username': username,
        'email': email,
      };
}

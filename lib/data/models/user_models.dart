class UserModel {
  final String? fullname;
  final int? userId;
  final String? email;
  final String? picture;

  UserModel({
    this.fullname,
    this.userId,
    this.email,
    this.picture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['id'],
      fullname: json['full_name'],
      email: json['email'],
      picture: json['picture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': userId,
      'full_name': fullname,
      'email': email,
      'picture': picture,
    };
  }
}

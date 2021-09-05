class UsersModel {
  late String userName;
  late String email;
  late String phone;
  late String uId;
  late String coverImage;
  late String profileImage;
  late String bio;
  bool isEmailVerification = false;

  UsersModel({
    required this.userName,
    required this.email,
    required this.phone,
    required this.uId,
    required this.coverImage,
    required this.bio,
    required this.profileImage,
    this.isEmailVerification = false,
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    email = json['email'];
    phone = json['phone'];
    uId = json['uId'];
    coverImage = json['coverImage'];
    profileImage = json['profileImage'];
    bio = json['bio'];
    isEmailVerification = json['isEmailVerification'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'email': email,
      'phone': phone,
      'uId': uId,
      'profileImage': profileImage,
      'coverImage': coverImage,
      'bio': bio,
      'isEmailVerification': isEmailVerification,
    };
  }
}

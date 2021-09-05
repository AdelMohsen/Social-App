class AllUsersModel {
   String? userName;
   String? uId;
  String? text;
   String? photo;

  AllUsersModel({
    required this.userName,
    required this.uId,
    required this.text,
    required this.photo,
  });

  AllUsersModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    uId = json['uId'];
    text = json['text'];
    photo = json['profileImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'uId': uId,
      'text': text,
      'profileImage': photo,
    };
  }
}

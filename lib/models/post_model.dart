class PostsModel {
  late String userName;
  late String uId;
  late String profileImage;
  late String dataTime;
  late String text;
  late String postImage;

  PostsModel({
    required this.userName,
    required this.uId,
    required this.profileImage,
    required this.dataTime,
    required this.text,
    required this.postImage,
  });

  PostsModel.fromJson(Map<String, dynamic> json) {
    userName = json['userName'];
    uId = json['uId'];
    profileImage = json['profileImage'];
    dataTime = json['dataTime'];
    text = json['text'];
    postImage = json['postImage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'userName': userName,
      'uId': uId,
      'profileImage': profileImage,
      'dataTime': dataTime,
      'text': text,
      'postImage': postImage,
    };
  }
}

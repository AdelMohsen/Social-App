class MessageModel {
  String? dateTime;
  String? receiverId;
  String? senderId;
  String? text;

  MessageModel({
    required this.dateTime,
    required this.receiverId,
    required this.senderId,
    required this.text,
  });

  MessageModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'receiverId': receiverId,
      'senderId': senderId,
      'text': text,
    };
  }
}

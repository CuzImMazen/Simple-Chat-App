class Message {
  String text;
  DateTime createdAt;
  String email;
  Message({required this.text, required this.createdAt, required this.email});
  factory Message.fromJson(json) {
    return Message(
      text: json['Text'],
      createdAt: json['CreatedAt'].toDate(),
      email: json['Email'],
    );
  }
}

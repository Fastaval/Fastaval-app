class Messages {
  List<Message> messages = List.empty(growable: true);

  Messages({required this.messages});

  Messages.fromJson(dynamic json) {
    for (var activity in json) {
      messages.add(Message.fromJson(activity));
    }
  }
}

class Message {
  int sendTime;
  String en;
  String da;

  Message({required this.sendTime, required this.en, required this.da});

  Message.fromJson(dynamic json)
      : sendTime = json['send_time'],
        en = json['en'],
        da = json['da'];

  Map<String, dynamic> toJson() => {
        'send_time': sendTime,
        'en': en,
        'da': da,
      };
}

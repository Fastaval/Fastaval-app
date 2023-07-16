import 'session.dart';

class Activity {
  int? id;
  List<Session>? sessions;
  String? titleDa;
  String? textDa;
  String? descriptionDa;
  String? titleEn;
  String? textEn;
  String? descriptionEn;
  String? author;
  int? price;
  int? minPlayer;
  int? maxPlayer;
  int? gms;
  String? type;
  double? playHours;
  String? language;
  String? wordpressId;
  int? canSignUp;

  Activity(
      {this.id,
      this.author,
      this.canSignUp,
      this.descriptionDa,
      this.descriptionEn,
      this.gms,
      this.language,
      this.maxPlayer,
      this.minPlayer,
      this.playHours,
      this.price,
      this.sessions,
      this.textDa,
      this.textEn,
      this.titleDa,
      this.titleEn,
      this.type,
      this.wordpressId});

  Activity.fromJson(dynamic json) {
    id = json['aktivitet_id'];
    author = json['author'];
    canSignUp = json['can_sign_up'];
    descriptionDa = json['description_da'];
    descriptionEn = json['description_en'];
    gms = json['gms'];
    language = json['language'];
    maxPlayer = json['max_player'];
    minPlayer = json['min_player'];
    playHours = json['play_hours'].toDouble();
    price = json['price'];
    if (json['afviklinger'] != null) {
      sessions = <Session>[];
      json['afviklinger'].forEach((session) {
        sessions!.add(Session.fromJson(session));
      });
    }
    textDa = json['text_da'];
    textEn = json['text_en'];
    titleDa = json['title_da'];
    titleEn = json['title_en'];
    type = json['type'];
    wordpressId = json['wp_id'];
  }

  Map<String, dynamic> toJson() => {
        'aktivitet_id': id,
        'author': author,
        'can_sign_up': canSignUp,
        'description_da': descriptionDa,
        'description_en': descriptionEn,
        'gms': gms,
        'language': language,
        'max_player': maxPlayer,
        'min_player': minPlayer,
        'play_hours': playHours,
        'price': price,
        'afviklinger': sessions,
        'text_da': textDa,
        'text_en': textEn,
        'title_da': titleDa,
        'title_en': titleEn,
        'type': type,
        'wp_id': wordpressId
      };
}

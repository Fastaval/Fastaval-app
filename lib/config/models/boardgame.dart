class BoardGame {
  int? id;
  String? name;
  bool? available;
  bool? fastavalGame;
  int? bbgId;

  BoardGame({this.id, this.name, this.available, this.fastavalGame, this.bbgId});
  BoardGame.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    available = json['available'];
    fastavalGame = json['fastavalGame'];
    bbgId = json['bbgId'];
  }
  Map<String, dynamic> toJson() =>
      {'id': id, 'title_da': name, 'available': available, 'fastavalGame': fastavalGame, 'bggId': bbgId};
}

class BoardGames {
  List<BoardGame> games = List.empty(growable: true);

  BoardGames({required this.games});

  BoardGames.fromJson(dynamic json) {
    for (var game in json) {
      games.add(BoardGame.fromJson(game));
    }
  }
}

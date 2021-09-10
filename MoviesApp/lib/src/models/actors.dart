class Cast {
  List<Actor> actores = [];
  Cast.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;
    jsonList.forEach((element) {
      final actor = Actor.fromJsonMap(element);
      actores.add(actor);
    });
  }
}

class Actor {
  bool? adult;
  int? gender;
  int? id;

  String? name;
  String? originalName;
  double? popularity;
  String? profilePath;
  int? castId;
  String? character;
  String? creditId;
  int? order;
  String? job;

  Actor({
    this.adult,
    this.gender,
    this.id,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.job,
  });

  Actor.fromJsonMap(Map<String, dynamic> json) {
    adult = json['adult'];
    gender = json['gender'];
    id = json['id'].cast<int>();
    name = json['name'];
    originalName = json['original_name'];
    popularity = json['popularity'] / 1;
    profilePath = json['profile_path'];
    castId = json['cast_id'] / 1;
    character = json['character'];
    creditId = json['credit_id'];
    order = json['order'];
    job = json['job'];
  }

  getPoster() {
    if (profilePath == null) {
      return "https://www.slotcharter.net/wp-content/uploads/2020/02/no-avatar.png";
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}

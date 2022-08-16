class PictureModel {
  static final catModel = PictureModel();

  static List<Picture> items = [];
  factory PictureModel() => catModel;

  // Get Item by ID
  Picture getById(int id) =>
      items.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Picture getByPosition(int pos) => items[pos];
}

class Picture {
  int? id;
  String? copyright;
  String? date;
  String? explanation;
  String? hdurl;
  String? mediaType;
  String? serviceVersion;
  String? title;
  String? url;

  Picture(
      {this.id,
      this.copyright,
      this.date,
      this.explanation,
      this.hdurl,
      this.mediaType,
      this.serviceVersion,
      this.title,
      this.url});

  Picture.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    copyright = json['copyright'];
    date = json['date'];
    explanation = json['explanation'];
    hdurl = json['hdurl'];
    mediaType = json['media_type'];
    serviceVersion = json['service_version'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['copyright'] = copyright;
    data['date'] = date;
    data['explanation'] = explanation;
    data['hdurl'] = hdurl;
    data['media_type'] = mediaType;
    data['service_version'] = serviceVersion;
    data['title'] = title;
    data['url'] = url;
    return data;
  }

  getFullPosterImage() {
    if (url != null) {
      return url;
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }

  getFullBackdropPath() {
    if (url != null) {
      return url;
    }
    return 'https://i.stack.imgur.com/GNhxO.png';
  }
}

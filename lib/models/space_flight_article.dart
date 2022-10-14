class SpaceFlightArticle {
  int? id;
  String? title;
  String? url;
  String? imageUrl;
  String? newsSite;
  String? summary;
  String? publishedAt;
  String? updatedAt;
  bool? featured;
  List<dynamic>? launches;
  List<dynamic>? events;

  SpaceFlightArticle({
    this.id,
    this.title,
    this.url,
    this.imageUrl,
    this.newsSite,
    this.summary,
    this.publishedAt,
    this.updatedAt,
    this.featured,
    this.launches,
    this.events,
  });

  factory SpaceFlightArticle.fromJson(Map<String, dynamic> json) {
    return SpaceFlightArticle(
      id: json['id'],
      title: json['title'],
      url: json['url'],
      imageUrl: json['imageUrl'],
      newsSite: json['newsSite'],
      summary: json['summary'],
      publishedAt: json['publishedAt'],
      updatedAt: json['updatedAt'],
      featured: json['featured'],
      launches: json['launches'],
      events: json['events'],
    );
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['title'] = title;
    map['url'] = url;
    map['imageUrl'] = imageUrl;
    map['newsSite'] = newsSite;
    map['summary'] = summary;
    map['publishedAt'] = publishedAt;
    map['updatedAt'] = updatedAt;
    map['featured'] = featured;
    map['launches'] = launches;
    map['events'] = events;
    return map;
  }
}

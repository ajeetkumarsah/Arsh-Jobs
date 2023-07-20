class BlogModel {
  String? image, thumbnail, title, date, content, link;
  int? id;
  BlogModel(
      {this.id,
      this.title,
      this.date,
      this.image,
      this.content,
      this.link,
      this.thumbnail});

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'date': date,
      'image': image,
      'content': content,
      'link': link,
    };
  }

  static BlogModel fromMap(Map<String, dynamic> map) {
    String? image, thumbnail;
    if (map.containsKey('_embedded') &&
        map['_embedded'].containsKey('wp:featuredmedia')) {
      for (var d in map['_embedded']['wp:featuredmedia']) {
        if (d['type'] == 'attachment') {
          image = d['media_details']['sizes']['full']['source_url'];
          thumbnail = d['media_details']['sizes']['thumbnail']['source_url'];
        }
      }
    }
    return BlogModel(
        id: map['id'],
        date: map['date'],
        title: map['title']['rendered'],
        image: image,
        content: map['content']['rendered'],
        thumbnail: thumbnail,
        link: map['link']);
  }
}

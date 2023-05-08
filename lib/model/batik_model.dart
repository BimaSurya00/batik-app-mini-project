class BatikResponse {
  String? description;
  int? id;
  String? imageUrl;
  String? title;

  BatikResponse({this.description, this.id, this.imageUrl, this.title});

  BatikResponse.fromJson(Map<String, dynamic> json) {
    description = json['description'];
    id = json['id'];
    imageUrl = json['image_url'];
    title = json['title'];
  }
}


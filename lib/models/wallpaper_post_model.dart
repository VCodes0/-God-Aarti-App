class WallPaperPost {
  String? id;
  String? images;

  WallPaperPost({this.id, this.images});

  WallPaperPost.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    images = json["images"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["images"] = images;
    return data;
  }

  static List<WallPaperPost> getSingleWallPaper(List data) {
    return data.map((e) => WallPaperPost.fromJson(e)).toList();
  }
}

class RecAndTrendWallpaper {
  String? id;
  String? postImage;

  RecAndTrendWallpaper({this.id, this.postImage});

  RecAndTrendWallpaper.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    postImage = json["post_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["post_image"] = postImage;
    return data;
  }

  static List<RecAndTrendWallpaper> getRecWallpaper(List data) {
    return data.map((e) => RecAndTrendWallpaper.fromJson(e)).toList();
  }
}

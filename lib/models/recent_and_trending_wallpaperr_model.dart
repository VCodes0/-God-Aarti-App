class RecWallpaper {
  String? id;
  String? postImage;

  RecWallpaper({this.id, this.postImage});

  RecWallpaper.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    postImage = json["post_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["post_image"] = postImage;
    return data;
  }

  static List<RecWallpaper> getRecWallpaper(List data) {
    return data.map((e) => RecWallpaper.fromJson(e)).toList();
  }
}

class RecentlyPlayedModel {
  String? id;
  String? title;
  String? withoutBgImage;
  String? bgImage;
  String? audio;
  String? mainImage;

  RecentlyPlayedModel({
    this.id,
    this.title,
    this.withoutBgImage,
    this.bgImage,
    this.audio,
    this.mainImage,
  });

  RecentlyPlayedModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    title = json["title"];
    withoutBgImage = json["without_bg_image"];
    bgImage = json["bg_image"];
    audio = json["audio"];
    mainImage = json["main_image"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["id"] = id;
    data["title"] = title;
    data["without_bg_image"] = withoutBgImage;
    data["bg_image"] = bgImage;
    data["audio"] = audio;
    data["main_image"] = mainImage;
    return data;
  }

  static List<RecentlyPlayedModel> sendRecentlyPlayedModel(List data) {
    return data.map((e) => RecentlyPlayedModel.fromJson(e)).toList();
  }
}

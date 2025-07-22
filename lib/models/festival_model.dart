class Data {
  String? id;
  String? name;
  String? catImage;

  Data({this.id, this.name, this.catImage});

  Data.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    catImage = json["cat_image"];
  }

  Map<String, dynamic> toJson() {
    return {"id": id, "name": name, "cat_image": catImage};
  }

  static List<Data> getFestival(List data) {
    return data.map((e) => Data.fromJson(e)).toList();
  }
}

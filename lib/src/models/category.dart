import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  String? id;
  String? name;
  String? description;

  Category({
    this.id,
    this.name,
    this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
        description: json["description"],
      );

  // static List<Category> fromJsonList(List <dynamic> jsonList) {
  //   List<Category> toLists = [];
  //  jsonList.forEach((item) {
  //     Category category = Category.fromJson(item);
  //     toLists.add(category);
  //   });

  //   return toLists;
  // }

  static List<Category> fromJsonList(Map<String, dynamic> jsonList) {
    List<Category> toLists = [];

    if (jsonList.containsKey('data')) {
      List<dynamic> dataList = jsonList['data'];
      toLists = dataList.map((item) => Category.fromJson(item)).toList();
    }

    return toLists;
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}

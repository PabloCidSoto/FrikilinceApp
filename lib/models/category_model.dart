// To parse this JSON data, do
//
//     final categoryModel = categoryModelFromJson(jsonString);

import 'dart:convert';

List<CategoryModel> categoryModelFromJson(String str) => List<CategoryModel>.from(json.decode(str).map((x) => CategoryModel.fromJson(x)));

String categoryModelToJson(List<CategoryModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryModel {
    CategoryModel({
        this.id,
        this.url,
        this.category,
        this.position,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.categoryModelId,
    });

    String? id;
    String? url;
    String? category;
    int? position;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? categoryModelId;

    factory CategoryModel.fromJson(Map<String, dynamic> json) => CategoryModel(
        id: json["_id"],
        url: json["url"],
        category: json["category"],
        position: json["position"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        categoryModelId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "url": url,
        "category": category,
        "position": position,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "id": categoryModelId,
    };
}


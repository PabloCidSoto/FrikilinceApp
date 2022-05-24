// To parse this JSON data, do
//
//     final productModel = productModelFromJson(jsonString);

import 'dart:convert';

List<ProductModel> productModelFromJson(String str) => List<ProductModel>.from(json.decode(str).map((x) => ProductModel.fromJson(x)));

String productModelToJson(List<ProductModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProductModel {
    ProductModel({
        this.images,
        this.id,
        this.discount,
        this.summary,
        this.price,
        this.url,
        this.releaseDate,
        this.title,
        this.video,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.poster,
        this.productModelId,
    });

    List<Poster>? images;
    String? id;
    int? discount;
    String? summary;
    dynamic? price;
    String? url;
    DateTime? releaseDate;
    String? title;
    String? video;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    Poster? poster;
    String? productModelId;

    factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        images: List<Poster>.from(json["images"].map((x) => Poster.fromJson(x))),
        id: json["_id"],
        discount: json["discount"],
        summary: json["summary"],
        price: json["price"],
        url: json["url"],
        releaseDate: DateTime.parse(json["releaseDate"]),
        title: json["title"],
        video: json["video"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        poster: Poster.fromJson(json["poster"]),
        productModelId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "_id": id,
        "discount": discount,
        "summary": summary,
        "price": price,
        "url": url,
        "releaseDate": "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "title": title,
        "video": video,
        "__v": v,
        "poster": poster!.toJson(),
        "id": productModelId,
    };
}


class Poster {
    Poster({
        this.id,
        this.name,
        this.alternativeText,
        this.caption,
        this.hash,
        this.size,
        this.width,
        this.height,
        this.url,
        this.related,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.posterId,
    });

    String? id;
    String? name;
    String? alternativeText;
    String? caption;
    String? hash;
    double? size;
    int? width;
    int? height;
    String? url;
    List<String>? related;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? posterId;

    factory Poster.fromJson(Map<String, dynamic> json) => Poster(
        id: json["_id"],
        name: json["name"],
        alternativeText: json["alternativeText"],
        caption: json["caption"],
        hash: json["hash"],
        size: json["size"].toDouble(),
        width: json["width"],
        height: json["height"],
        url: json["url"],
        related: List<String>.from(json["related"].map((x) => x)),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        posterId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "alternativeText": alternativeText,
        "caption": caption,
        "hash": hash,
        "size": size,
        "width": width,
        "height": height,
        "url": url,
        "related": List<dynamic>.from(related!.map((x) => x)),
        "__v": v,
        "id": posterId,
    };
}








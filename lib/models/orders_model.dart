// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

List<OrdersModel> ordersModelFromJson(String str) => List<OrdersModel>.from(json.decode(str).map((x) => OrdersModel.fromJson(x)));

String ordersModelToJson(List<OrdersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
    OrdersModel({
        this.id,
        this.totalPayment,
        this.idPayment,
        this.addressShipping,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.product,
        this.ordersModelId,
    });

    String? id;
    int? totalPayment;
    String? idPayment;
    AddressShipping? addressShipping;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    Product? product;
    String? ordersModelId;

    factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
        id: json["_id"],
        totalPayment: json["totalPayment"],
        idPayment: json["idPayment"],
        addressShipping: AddressShipping.fromJson(json["addressShipping"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        product: Product.fromJson(json["product"]),
        ordersModelId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "totalPayment": totalPayment,
        "idPayment": idPayment,
        "addressShipping": addressShipping!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "product": product!.toJson(),
        "id": ordersModelId,
    };
}

class AddressShipping {
    AddressShipping({
        this.id,
        this.title,
        this.name,
        this.address,
        this.city,
        this.state,
        this.postalCode,
        this.phone,
        this.updatedAt,
        this.v,
        this.addressShippingId,
    });

    String? id;
    String? title;
    String? name;
    String? address;
    String? city;
    String? state;
    String? postalCode;
    String? phone;
    DateTime? updatedAt;
    int? v;
    String? addressShippingId;

    factory AddressShipping.fromJson(Map<String, dynamic> json) => AddressShipping(
        id: json["_id"],
        title: json["title"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postalCode"],
        phone: json["phone"],
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        addressShippingId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "title": title,
        "name": name,
        "address": address,
        "city": city,
        "state": state,
        "postalCode": postalCode,
        "phone": phone,
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "id": addressShippingId,
    };
}

class Product {
    Product({
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
        this.category,
        this.createdBy,
        this.poster,
        this.updatedBy,
        this.productId,
    });

    List<Poster>? images;
    String? id;
    int? discount;
    String? summary;
    int? price;
    String? url;
    DateTime? releaseDate;
    String? title;
    String? video;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? category;
    String? createdBy;
    Poster? poster;
    String? updatedBy;
    String? productId;

    factory Product.fromJson(Map<String, dynamic> json) => Product(
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
        category: json["category"],
        createdBy: json["created_by"],
        poster: Poster.fromJson(json["poster"]),
        updatedBy: json["updated_by"],
        productId: json["id"],
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
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "category": category,
        "created_by": createdBy,
        "poster": poster!.toJson(),
        "updated_by": updatedBy,
        "id": productId,
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
        this.formats,
        this.provider,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.createdBy,
        this.updatedBy,
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
    Formats? formats;
    String? provider;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? createdBy;
    String? updatedBy;
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
        formats: Formats.fromJson(json["formats"]),
        provider: json["provider"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
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
        "formats": formats!.toJson(),
        "provider": provider,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "created_by": createdBy,
        "updated_by": updatedBy,
        "id": posterId,
    };
}


class Formats {
    Formats({
        this.thumbnail,
        this.medium,
        this.small,
    });

    Medium? thumbnail;
    Medium? medium;
    Medium? small;

    factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        thumbnail: Medium.fromJson(json["thumbnail"]),
        medium: Medium.fromJson(json["medium"]),
        small: Medium.fromJson(json["small"]),
    );

    Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail!.toJson(),
        "medium": medium!.toJson(),
        "small": small!.toJson(),
    };
}

class Medium {
    Medium({
        this.name,
        this.hash,
        this.width,
        this.height,
        this.size,
        this.path,
        this.url,
    });

    String? name;
    String? hash;
    int? width;
    int? height;
    double? size;
    dynamic path;
    String? url;

    factory Medium.fromJson(Map<String, dynamic> json) => Medium(
        name: json["name"],
        hash: json["hash"],
        width: json["width"],
        height: json["height"],
        size: json["size"].toDouble(),
        path: json["path"],
        url: json["url"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "hash": hash,
        "width": width,
        "height": height,
        "size": size,
        "path": path,
        "url": url,
    };
}






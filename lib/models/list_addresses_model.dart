// To parse this JSON data, do
//
//     final listAddressesModel = listAddressesModelFromJson(jsonString);

import 'dart:convert';

List<ListAddressesModel> listAddressesModelFromJson(String str) => List<ListAddressesModel>.from(json.decode(str).map((x) => ListAddressesModel.fromJson(x)));

String listAddressesModelToJson(List<ListAddressesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ListAddressesModel {
    ListAddressesModel({
        this.id,
        this.title,
        this.name,
        this.address,
        this.city,
        this.state,
        this.postalCode,
        this.phone,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.listAddressesModelId,
    });

    String? id;
    String? title;
    String? name;
    String? address;
    String? city;
    String? state;
    String? postalCode;
    String? phone;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? listAddressesModelId;

    factory ListAddressesModel.fromJson(Map<String, dynamic> json) => ListAddressesModel(
        id: json["_id"],
        title: json["title"],
        name: json["name"],
        address: json["address"],
        city: json["city"],
        state: json["state"],
        postalCode: json["postalCode"],
        phone: json["phone"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        listAddressesModelId: json["id"],
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
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "id": listAddressesModelId,
    };
}


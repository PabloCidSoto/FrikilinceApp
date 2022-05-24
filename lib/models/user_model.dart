// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    UserModel({
        this.confirmed,
        this.blocked,
        this.id,
        this.name,
        this.lastname,
        this.username,
        this.email,
        this.provider,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.userModelId,
    });

    bool? confirmed;
    bool? blocked;
    String? id;
    String? name;
    String? lastname;
    String? username;
    String? email;
    String? provider;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? userModelId;

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        confirmed: json["confirmed"],
        blocked: json["blocked"],
        id: json["_id"],
        name: json["name"],
        lastname: json["lastname"],
        username: json["username"],
        email: json["email"],
        provider: json["provider"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        userModelId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "confirmed": confirmed,
        "blocked": blocked,
        "_id": id,
        "name": name,
        "lastname": lastname,
        "username": username,
        "email": email,
        "provider": provider,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "id": userModelId,
    };
}

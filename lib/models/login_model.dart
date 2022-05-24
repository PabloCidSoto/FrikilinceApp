// To parse this JSON data, do
//
//     final loginModel = loginModelFromJson(jsonString);

import 'dart:convert';

LoginModel loginModelFromJson(String str) => LoginModel.fromJson(json.decode(str));

String loginModelToJson(LoginModel data) => json.encode(data.toJson());

class LoginModel {
    LoginModel({
        this.jwt,
        this.user,
    });

    String? jwt;
    User? user;

    factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        jwt: json["jwt"],
        user: User.fromJson(json["user"]),
    );

    Map<String, dynamic> toJson() => {
        "jwt": jwt,
        "user": user!.toJson(),
    };
}

class User {
    User({
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
        this.role,
        this.userId,
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
    Role? role;
    String? userId;

    factory User.fromJson(Map<String, dynamic> json) => User(
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
        role: Role.fromJson(json["role"]),
        userId: json["id"],
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
        "role": role?.toJson(),
        "id": userId,
    };
}

class Role {
    Role({
        this.id,
        this.name,
        this.description,
        this.type,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.roleId,
    });

    String? id;
    String? name;
    String? description;
    String? type;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    String? roleId;

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        type: json["type"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        roleId: json["id"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "type": type,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "id": roleId,
    };
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:proyectofinal/constants/constants.dart';
import 'package:proyectofinal/models/login_model.dart';
import 'package:proyectofinal/models/user_model.dart';

class UserApi {
  
  Future<dynamic> iniciarSesion(email, password) async{
    var client = http.Client();
    var response = await client.post(
      Uri.parse('${Constants.basePath}/auth/local'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "identifier": email,
        "password": password
      })
    );
    if(response.statusCode == 200){
      var jsonString = response.body;
      return loginModelFromJson(jsonString);
    }
    return null;
  }

  Future<dynamic> updateNameApi(idUser, data, token) async{
    var client = http.Client();
    
    var response = await client.put(
      Uri.parse('${Constants.basePath}/users/$idUser'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(data)
    );
    if(response.statusCode == 200){
      var jsonString = response.body;
      print(jsonString);
      return userModelFromJson(jsonString);
    }
    return null;
  }

  Future<dynamic> updateEmailApi(idUser, data, token) async{
    var client = http.Client();
    
    var response = await client.put(
      Uri.parse('${Constants.basePath}/users/$idUser'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(data)
    );
    if(response.statusCode == 200){
      var jsonString = response.body;
      print(jsonString);
      return userModelFromJson(jsonString);
    }
    return null;
  }

  Future<dynamic> updatePasswordApi(idUser, data, token) async{
    var client = http.Client();
    
    var response = await client.put(
      Uri.parse('${Constants.basePath}/users/$idUser'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonEncode(data)
    );
    if(response.statusCode == 200){
      var jsonString = response.body;
      return userModelFromJson(jsonString);
    }
    return null;
  }
}
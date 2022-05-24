import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:proyectofinal/constants/constants.dart';
import 'package:proyectofinal/models/category_model.dart';

class CategoryApi {
  Future<dynamic> getCategory() async{
    var client = http.Client();
    var response = await client.get(
      Uri.parse('${Constants.basePath}/categories?_sort=position:asc'),
      headers: {
        "Content-Type": "application/json"
        }
    );
    if(response.statusCode == 200){
      var jsonString = response.body;
      return categoryModelFromJson(jsonString);
    }
    return null;
  }
}
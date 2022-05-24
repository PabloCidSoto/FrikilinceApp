import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:proyectofinal/constants/constants.dart';
import 'package:proyectofinal/models/product_model.dart';

class ProductApi {
  Future<dynamic> getProductsCategoryApi(category, limit)async{
    String limitItems = "_limit=$limit";
    String sortItem = "_sort=createdAt:desc";
    String url = "${Constants.basePath}/products?category.url=$category&$limitItems&$sortItem";
    var client = http.Client();
    var response = await client.get(
      Uri.parse(url),
      headers: {
        "Content-Type": "application/json",
        }
    );
    if(response.statusCode == 200){
      var jsonString = response.body;
      return productModelFromJson(jsonString);
    }
    return null;
  }
}

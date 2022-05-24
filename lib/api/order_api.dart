import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:proyectofinal/constants/constants.dart';
import 'package:proyectofinal/models/orders_model.dart';

class OrdersApi {
  Future<dynamic> getOrdersApi(idUser, token) async{
    var client = http.Client();
    var response = await client.get(
      Uri.parse('${Constants.basePath}/orders?_sort=createdAt:desc&user=$idUser'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
        }
    );
    if(response.statusCode == 200){
      var jsonString = response.body;
      return ordersModelFromJson(jsonString);
    }
    return null;
  }

  Future<List<OrdersModel>?> getOrderApi(idUser, token, idPayment) async{
    var client = http.Client();
    var response = await client.get(
      Uri.parse('${Constants.basePath}/orders?_sort=createdAt:desc&user=$idUser&idPayment=$idPayment'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
        }
    );
    if(response.statusCode == 200){
      var jsonString = response.body;
      return ordersModelFromJson(jsonString);
    }
    return null;
  }
}

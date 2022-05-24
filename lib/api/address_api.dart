import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:proyectofinal/constants/constants.dart';
import 'package:proyectofinal/models/list_addresses_model.dart';

class AddressApi {
  Future<dynamic> getAddressesApi(idUser, token) async{
    var client = http.Client();
    var response = await client.get(
      Uri.parse('${Constants.basePath}/addresses?user=$idUser'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
        }
    );
    if(response.statusCode == 200){
      var jsonString = response.body;
      return listAddressesModelFromJson(jsonString);
    }
    return null;
  }

  Future<dynamic> updateAddressApi(idAddress, token,data) async{
    var client = http.Client();
    var response = await client.put(
      Uri.parse('${Constants.basePath}/addresses/$idAddress'),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
        },
      body: jsonEncode(data)

    );
    if(response.statusCode == 200){
      var jsonString = "[${response.body}]";
      return listAddressesModelFromJson(jsonString);
    }
    inspect(response.body);
    return null;
  }
}
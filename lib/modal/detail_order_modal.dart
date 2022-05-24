import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:proyectofinal/models/orders_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/order_api.dart';

class ModalWithPageView extends StatelessWidget {
  String? idPayment = "";
  AddressShipping? address = AddressShipping();
  ModalWithPageView({ this.idPayment, this.address });
  OrdersApi _ordersApi = OrdersApi();


  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar:
            AppBar(leading: Container(), title: Text('Detalles del pedido'), backgroundColor: Color.fromRGBO(1, 161, 16, 1),),
        body: SafeArea(
          bottom: false,
          child: createDetail(),
        ),
      ),
    );
  }
  
  Future<List<OrdersModel>?> getDetailOrder()async{
    final localStorage = await SharedPreferences.getInstance();
    String token = localStorage.getString("token") ?? '';
    String idUser = localStorage.getString("idUser") ?? '';
    List<OrdersModel>? response = await _ordersApi.getOrderApi(idUser, token, idPayment);
    return response;
  }

  createDetail(){
    return FutureBuilder(
      future: getDetailOrder(),
      builder: (BuildContext context, AsyncSnapshot<List<OrdersModel>?> snapshot) {
        if( snapshot.hasError ){
          return Text('error en la petición');
        }else{
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
            return snapshot.data!.isNotEmpty ?                   
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView(
                  shrinkWrap: true,
                  controller: ModalScrollController.of(context),
                  children: ListTile.divideTiles(
                    context: context,
                    tiles: List.generate(
                        snapshot.data!.length,
                        (index) => ListTile(
                              title: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(snapshot.data![index].product!.title!),
                                  Text("\$${snapshot.data![index].product!.price!.toString()}"),
                                ],
                              ),
                            )),
                  ).toList(),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total: "),
                      Text("\$${snapshot.data![0].totalPayment}")
                    ],
                  ),
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Dirección de envío"),
                      Text("${address!.title}"),
                      Text("${address!.name}"),
                      Text("${address!.address}"),
                      Text("${address!.city}"),
                      Text("${address!.state}"),
                      Text("${address!.phone}"),
                    ],
                  ),
                ),
              ]
              ,
                      ),
            ): Text("No hay productos");
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }
}
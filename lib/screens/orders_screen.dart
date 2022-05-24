import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:proyectofinal/api/order_api.dart';
import 'package:proyectofinal/graphics/orders_graphic.dart';
import 'package:proyectofinal/modal/detail_order_modal.dart';
import 'package:proyectofinal/models/orders_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:charts_flutter/flutter.dart' as charts;


class OrdersScreen extends StatefulWidget {
  OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  
  OrdersApi _ordersApi = OrdersApi();
  GlobalKey containerKey = GlobalKey();  

  
  @override
  Widget build(BuildContext context) {
    
    
    return Scaffold(
      appBar: AppBar(title: Text("Pedidos"), backgroundColor: Color.fromRGBO(1, 161, 16, 1),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 12,),            
            FutureBuilder(
              future: getOrders(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if( snapshot.hasError ){
                  return Text('error en la petición');
                }else{
                  if(snapshot.connectionState == ConnectionState.done){                    
                    return snapshot.data;
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                }
              },
            ),
            
          ],
        ),
      ),
    );
  }

  getOrders()async{
    final localStorage = await SharedPreferences.getInstance();
    String token = localStorage.getString("token") ?? '';
    String idUser = localStorage.getString("idUser") ?? '';
    
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 2;
    final double itemWidth = size.width / 2;
    
    return FutureBuilder(
      future: _ordersApi.getOrdersApi(idUser, token),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if( snapshot.hasError ){
          return Text('error en la petición');
        }else{
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){       
            print(snapshot.data);             
            return snapshot.data.length == 0 ? Text("No tiene pedidos realizados")
            : Column(
                  children: [
                    Container(
                          height: 50,
                          width: 300,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(1, 161, 16, 1)!
                          ),
                          child: InkWell(
                            child: Center(
                              child: Text("Total de pedidos año actual", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ),
                            onTap: (){Navigator.pushNamed(context, "/graphic" , arguments: snapshot.data);},
                          ),
                        ),
                    
                GridView.count(
                  primary: false,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  childAspectRatio: (itemWidth / itemHeight),
                  children: List<Widget>.generate(snapshot.data.length, (index){
                    return product(snapshot.data[index]);
                  })
                    
        
                ),
              ],
            );
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }

  product(OrdersModel order){    
    return InkWell(
      onTap:() => showBarModalBottomSheet(
        expand: true,
        context: context,
        backgroundColor: Colors.transparent,
        builder: (context) => ModalWithPageView(idPayment: order.idPayment, address: order.addressShipping),
      ),  
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.green[100],
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.network(order.product!.poster!.formats!.small!.url! ),
            Text(order.product!.title ?? ''),
            Text(order.totalPayment.toString()),
            Text(order.createdAt.toString())
          ],
        ),
      ),
    );
  }

  
  
}

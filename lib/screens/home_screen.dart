import 'dart:developer';

import 'package:charts_flutter/flutter.dart';
import 'package:flutter/material.dart';
import 'package:proyectofinal/api/category_api.dart';
import 'package:proyectofinal/api/product_api.dart';
import 'package:proyectofinal/models/category_model.dart';
import 'package:proyectofinal/models/product_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/src/painting/basic_types.dart' as basic;
class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>{
  String _idUser = '';
  CategoryApi categoryApi = CategoryApi();
  ProductApi productApi = ProductApi();
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Inicio"), 
        backgroundColor: basic.Color.fromRGBO(1, 161, 16, 1)
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            FutureBuilder(
              future: getData(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if( snapshot.hasError ){
                    return Center(child: Text('Ocurrio un error en la petición'));
                  }else{
                    if(snapshot.connectionState == ConnectionState.done){  
                      return snapshot.data!;
                    }else{
                      return Center(child: CircularProgressIndicator());
                    }
                  }
              },
            ),
            ListTile(
              title: Text('Mi perfil'),
              subtitle: Text('Datos personales'),
              leading: Icon(Icons.monetization_on_outlined),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/profile');
              },
            ),
            ListTile(
              title: Text('Historial'),
              subtitle: Text('Historial de pedidos'),
              leading: Icon(Icons.monetization_on_outlined),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/orders');
              },
            ),
            ListTile(
              title: Text('Direcciones'),
              subtitle: Text('Sus direcciones guardadas'),
              leading: Icon(Icons.monetization_on_outlined),
              trailing: Icon(Icons.chevron_right),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, '/addresses');
              },
            ),
        ]),
      ),
      body:Column(
        children: [
          buildCategories(),      
        ],
      )
    );
  }

  Future<Widget> getData() async{
    final localStorage = await SharedPreferences.getInstance();
    return UserAccountsDrawerHeader(
      decoration: BoxDecoration(color: basic.Color.fromRGBO(1, 161, 16, 1)),
      accountName: Text(localStorage.getString('nombre') ?? "Error"),        
      accountEmail: Text(localStorage.getString('apellidos') ?? "Error"),
      currentAccountPicture: CircleAvatar(
        child: ClipRRect(borderRadius: BorderRadius.circular(75),child:Image.network('https://www.personality-insights.com/wp-content/uploads/2017/12/default-profile-pic-e1513291410505.jpg')),
      )

    );
  }

  
  buildCategories(){    
    return FutureBuilder(
      future: categoryApi.getCategory(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if( snapshot.hasError ){
          return Text('error en la petición');
        }else{
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){
            return snapshot.data.length == 0 ? Text("No hay categorías")
            : Expanded(              
              child: Column(
                children: List<Widget>.generate(snapshot.data.length, (index){
                  return Expanded(
                    child: Column(
                      children: [
                        Text(snapshot.data[index].category),
                        buildCardsProduct(snapshot.data[index].url, 5)
                      ],
                    ),
                  );
                
                })),
            );
              
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }
  

  buildCardsProduct(String category, int limit){
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight) / 1.5;
    final double itemWidth = size.width / 2;
    return FutureBuilder(
      future: productApi.getProductsCategoryApi(category, limit),
      builder: (BuildContext context, AsyncSnapshot snapshot) {      
        if( snapshot.hasError ){
          return Text('error en la petición');
        }else{
          if(snapshot.connectionState == ConnectionState.done && snapshot.hasData){       
            return snapshot.data.length == 0 ? Text("No hay productos")
            : Expanded(
              child: GridView.count(
                    primary: false,
                    padding: const EdgeInsets.all(20),
                    crossAxisSpacing: 5,
                    mainAxisSpacing: 5,
                    crossAxisCount: 1,
                    scrollDirection: basic.Axis.horizontal,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    childAspectRatio: (itemWidth / itemHeight),
                    children: List<Widget>.generate(snapshot.data.length, (index){
                      return product(snapshot.data[index]);
                    })
                      
                    
                  ),
            );
              
          }else{
            return Center(child: CircularProgressIndicator());
          }
        }
      },
    );
  }
  
  product(ProductModel product){    
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(product.poster!.url!), fit: BoxFit.cover)
      ), 
      child: Row(  
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Image.network(product.poster!.url! ),
          Expanded(child: Text(product.title ?? '', overflow: TextOverflow.ellipsis)),
          Text("${product.price.toString()}\$", overflow: TextOverflow.ellipsis)
        ],
      ),
    );
  }

  

  

}
import 'package:fluid_action_card/FluidActionCard/fluid_action_card.dart';
import 'package:flutter/material.dart';
import 'package:proyectofinal/api/address_api.dart';
import 'package:proyectofinal/models/list_addresses_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressesScreen extends StatefulWidget {
  AddressesScreen({Key? key}) : super(key: key);

  @override
  State<AddressesScreen> createState() => _AddressesScreenState();
}

class _AddressesScreenState extends State<AddressesScreen> {
  AddressApi _addressApi = AddressApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Direcciones"), backgroundColor: Color.fromRGBO(1, 161, 16, 1),),
      body: FutureBuilder(
        future: getAddresses(),
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
    );
  }
  
  Future getAddresses() async{
    final localStorage = await SharedPreferences.getInstance();
    String idUser = localStorage.getString("idUser") ?? '';
    String token = localStorage.getString("token") ?? '';
    return FutureBuilder(
      future: _addressApi.getAddressesApi(idUser, token),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if( snapshot.hasError ){
          return Text('error en la petición');
        }else{
          if(snapshot.connectionState == ConnectionState.done){                    
            return snapshot.data.length == 0 ? Text("No tiene direcciones guardadas")
            : GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: List<Widget>.generate(snapshot.data.length, (index){
                return address(snapshot.data[index]);
              })
                
        
            );
          }     
          else{
            return Center(child: CircularProgressIndicator());
          }
        }
      }
    );
  }

  Widget address(ListAddressesModel addressesModel){
    return InkWell(
      onTap: (){
        Navigator.pushNamed(
          context,
          '/formAddress',
          arguments: addressesModel
        );
      },  
      child: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.green.shade100,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(addressesModel.title ?? '', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),),
            Text(addressesModel.name ?? ''),
            Text(addressesModel.address ?? ''),
            Text(addressesModel.city ?? ''),
            Text(addressesModel.state ?? ''),
            Text(addressesModel.postalCode ?? ''),
            Text(addressesModel.phone ?? ''),
          ],
        ),
      ),
    );
  }
}
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:proyectofinal/api/address_api.dart';
import 'package:proyectofinal/models/list_addresses_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddressFormScreen extends StatefulWidget {
  AddressFormScreen({Key? key}) : super(key: key);

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {

  final TextEditingController _tituloController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _ciudadController = TextEditingController();
  final TextEditingController _estadoController = TextEditingController();
  final TextEditingController _codigoPostalController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();


  bool loading = false;

  AddressApi _addressApi = AddressApi();


  @override
  Widget build(BuildContext context) {
    final ListAddressesModel? address = ModalRoute.of(context)?.settings.arguments as ListAddressesModel;
    _tituloController.text = address?.title! ?? '';
    _nombreController.text = address?.name! ?? '';
    _direccionController.text = address?.address! ?? '';
    _ciudadController.text = address?.city! ?? '';
    _estadoController.text = address?.state! ?? '';
    _codigoPostalController.text = address?.postalCode! ?? '';
    _telefonoController.text = address?.phone! ?? '';

    bool update = true;
    (address != null) ? update = true : update = false;
    
    return Scaffold(
      appBar: AppBar(title: Text(address?.title! ?? 'Agregar dirección'), backgroundColor: Color.fromRGBO(1, 161, 16, 1),),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                      Text("Actualizar dirección", style: TextStyle(color: Colors.green, fontSize: 24),)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [BoxShadow(
                        color: Color.fromARGB(75, 106, 225, 27),
                        blurRadius: 20,
                        offset: Offset(0, 10)
                      )]
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                          ),
                          child: TextField(
                            controller: _tituloController,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                              hintText: "Titulo",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                          ),
                          child: TextField(
                            controller: _nombreController,
                            decoration: InputDecoration(
                              hintText: "Nombre",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
        
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                          ),
                          child: TextField(
                            controller: _direccionController,
                            decoration: InputDecoration(
                              hintText: "Dirección",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
        
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                          ),
                          child: TextField(
                            controller: _ciudadController,
                            decoration: InputDecoration(
                              hintText: "Ciudad",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
        
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                          ),
                          child: TextField(
                            controller: _estadoController,
                            decoration: InputDecoration(
                              hintText: "Estado",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
        
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                          ),
                          child: TextField(
                            controller: _codigoPostalController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Código Postal",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
        
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border(bottom: BorderSide(color: Colors.grey[200]!))
                          ),
                          child: TextField(
                            controller: _telefonoController,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "Teléfono",
                              hintStyle: TextStyle(color: Colors.grey),
                              border: InputBorder.none,
        
                            ),
                          ),
                        ),
                      ],
                    ),
                    
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 50,
                    width: 300,
                    margin: EdgeInsets.symmetric(horizontal: 50),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.green[900]
                    ),
                    child: InkWell(
                      child: !loading ? Center(
                        child: Text("Actualizar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                      ):Center(child: CircularProgressIndicator( color: Colors.white , )),
                      onTap: () => actionAddress(address!.id, update, address),
                    ),
                  ),
                  SizedBox(height: 50,)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  actionAddress(idAddress, bool update, address) async{
    final localStorage = await SharedPreferences.getInstance();
    String token = localStorage.getString("token") ?? '';


    if(token == ''){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vuelva a iniciar sesión, no se encuentra el id user")));
      return;
    }

    if(
      _tituloController.value.text == '' ||
      _nombreController.value.text == '' ||
      _direccionController.value.text == '' ||
      _ciudadController.value.text == '' ||
      _estadoController.value.text == '' ||
      _codigoPostalController.value.text == '' ||
      _telefonoController.value.text == ''
    ){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Algún campo está vacío")));
      return;
    }

    Map<String, dynamic> data = {
      "title": _tituloController.value.text,
      "name": _nombreController.value.text,
      "address": _direccionController.value.text,
      "city": _ciudadController.value.text,
      "state": _estadoController.value.text,
      "postalCode": _codigoPostalController.value.text,
      "phone": _telefonoController.value.text 
    };

    setState(() {
      loading = true;
    });
    if(update){

      List<ListAddressesModel?> response = await _addressApi.updateAddressApi(idAddress, token, data);
      ListAddressesModel? addressNew = response[0];
      if(response == null){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("error al actualizar la dirección")));
        setState(() {
          loading = false;
        });
      return;
      }
      address = addressNew;
      _tituloController.text = addressNew!.title!;
      _nombreController.text = addressNew.name!;
      _direccionController.text = addressNew.address!;
      _ciudadController.text = addressNew.city!;
      _estadoController.text = addressNew.state!;
      _codigoPostalController.text = addressNew.postalCode!;
      _telefonoController.text = addressNew.phone!;
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Datos actualizados")));
      setState(() {
          loading = false;
      });
      return;


    }else{
      //ListAddressesModel? res
      setState(() {
          loading = false;
      });
      return;
    } 
  }
}
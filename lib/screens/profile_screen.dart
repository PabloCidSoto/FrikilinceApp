import 'package:flutter/material.dart';
import 'package:proyectofinal/api/user_api.dart';
import 'package:proyectofinal/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserApi _userApi = UserApi();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _emailConfirmController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordcConfirmController = TextEditingController();
  
  String email = '';
  String idUser = '';
  String token= '';

  bool loadingNombre = false;
  bool loadingEmail = false;
  bool loadingPassword = false;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Perfil"), backgroundColor: Color.fromRGBO(1, 161, 16, 1),),
      body: SingleChildScrollView(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                future: getData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if( snapshot.hasError ){
                  return Text('error en la petición');
                }else{
                  if(snapshot.connectionState == ConnectionState.done){                    
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                                  Text("Cambiar nombre", style: TextStyle(color: Colors.green, fontSize: 24),)
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
                                        controller: _nombreController,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          hintText: "Nombre",
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
                                        controller: _apellidosController,
                                        decoration: InputDecoration(
                                          hintText: "Apellidos",
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
                                  child: !loadingNombre ? Center(
                                    child: Text("Actualizar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ):Center(child: CircularProgressIndicator( color: Colors.white , )),
                                  onTap: actualizarNombre,
                                ),
                              ),
                              SizedBox(height: 50,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Cambia tu email ($email)", style: TextStyle(color: Colors.green, fontSize: 24),)
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
                                        controller: _emailController,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          hintText: "Email",
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
                                        controller: _emailConfirmController,
                                        keyboardType: TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          hintText: "Confirmar Email" ,
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
                                  child: !loadingEmail ? Center(
                                    child: Text("Actualizar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ):Center(child: CircularProgressIndicator( color: Colors.white , )),
                                  onTap: actualizarCorreo,
                                ),
                              ),
                              SizedBox(height: 50,)
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Cambiar contraseña", style: TextStyle(color: Colors.green, fontSize: 24),)
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
                                        obscureText: true,
                                        controller: _passwordController,
                                        keyboardType: TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          hintText: "Nueva contraseña",
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
                                        obscureText: true,
                                        controller: _passwordcConfirmController,
                                        keyboardType: TextInputType.visiblePassword,
                                        decoration: InputDecoration(
                                          hintText: "Confirma la contraseña",
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
                                  child: !loadingPassword ? Center(
                                    child: Text("Actualizar", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                                  ):Center(child: CircularProgressIndicator( color: Colors.white , )),
                                  onTap: actualizarPassword,
                                ),
                              ),
                              SizedBox(height: 50,)
                            ],
                          ),
                        )
              ]
            );
                  }else{
                    return Center(child: CircularProgressIndicator());
                  }
                }
                  
            
                },
              ),
            ],
          ),
      )
    );
  }

  Future getData() async{
    final localStorage = await SharedPreferences.getInstance();
    _nombreController.text = localStorage.getString("nombre") ?? '';
    _apellidosController.text = localStorage.getString("apellidos") ?? '';
    email = localStorage.getString("email") ?? '';
    idUser = localStorage.getString("idUser") ?? '';
    token = localStorage.getString("token") ?? '';
    

  }

  actualizarNombre() async{
    final localStorage = await SharedPreferences.getInstance();

    if(_nombreController.value.text == '' || _apellidosController.value.text == ''){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Campos de nombre o apellido vacios")));
      return;
    }

    if(idUser == '' || token == ''){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vuelva a iniciar sesión, no se encuentra el id user")));
      return;
    }


    Map<String, dynamic> data = {
      "name": _nombreController.value.text,
      "lastname": _apellidosController.value.text
    };

    setState(() {
      loadingNombre = true;
    });

    UserModel? response = await _userApi.updateNameApi(idUser, data, token);
    
    if(response == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("error al actualizar nombre")));
      setState(() {
        loadingNombre = false;
      });
      return;
    }

    await localStorage.setString('nombre', response.name!);
    await localStorage.setString('apellidos', response.lastname!);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Datos actualizados")));
    
    setState(() {
      loadingNombre = false;
    });
  }

  actualizarCorreo() async{
    final localStorage = await SharedPreferences.getInstance();

    if(_emailController.value.text == '' || _emailConfirmController.value.text == ''){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Campos de email o confirmar email")));
      return;
    }

    if(idUser == '' || token == ''){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vuelva a iniciar sesión, no se encuentra el id user")));
      return;
    }

    if(_emailController.value.text != _emailConfirmController.value.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Los correos son distintos")));
      return;
    }


    Map<String, dynamic> data = {
      "email": _emailController.value.text
    };

    setState(() {
      loadingEmail = true;
    });

    UserModel? response = await _userApi.updateEmailApi(idUser, data, token);
    
    if(response == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("error al actualizar nombre")));
      setState(() {
        loadingEmail = false;
      });
      return;
    }

    await localStorage.setString('email', response.email!);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Datos actualizados")));

    
    setState(() {
      loadingEmail = false;
    });
  }

  actualizarPassword() async{

    if(_passwordController.value.text == '' || _passwordcConfirmController.value.text == ''){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Campos de contraseña o confirmar contraseña vacíos")));
      return;
    }

    if(idUser == '' || token == ''){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Vuelva a iniciar sesión, no se encuentra el id user")));
      return;
    }

    if(_passwordController.value.text != _passwordcConfirmController.value.text){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Las contraseñas son distintas")));
      return;
    }


    Map<String, dynamic> data = {
      "password": _passwordController.value.text
    };

    setState(() {
      loadingPassword = true;
    });

    UserModel? response = await _userApi.updatePasswordApi(idUser, data, token);
    
    if(response == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("error al actualizar contraseña")));
      setState(() {
        loadingPassword = false;
      });
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Datos actualizados")));

    
    setState(() {
      loadingPassword = false;
    });
  }
}
import 'package:flutter/material.dart';
import 'package:proyectofinal/api/user_api.dart';
import 'package:proyectofinal/models/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            colors: [
              Color.fromRGBO(1, 161, 16, 1),
              Color.fromRGBO(1, 161, 16, 1),
              Colors.green[400]!
            ]
          )
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 80,),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Login", style: TextStyle(color: Colors.white, fontSize: 40),),
                  SizedBox(height: 10,),
                  Text("Bienvenido", style: TextStyle(color: Colors.white, fontSize: 18),),
                ],
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.all(30),
                    child: Column(
                      children: <Widget>[
                        SizedBox(height: 60,),
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [BoxShadow(
                              color: Color.fromRGBO(1, 161, 16, 1)!,
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
                                  obscureText: true,
                                  controller: _passwordController,
                                  decoration: InputDecoration(
                                    hintText: "Contraseña",
                                    hintStyle: TextStyle(color: Colors.grey),
                                    border: InputBorder.none,

                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 40,),
                        Container(
                          height: 50,
                          width: 300,
                          margin: EdgeInsets.symmetric(horizontal: 50),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: Color.fromRGBO(1, 161, 16, 1)!
                          ),
                          child: InkWell(
                            child: !loading ? Center(
                              child: Text("Iniciar sesión", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                            ):Center(child: CircularProgressIndicator( color: Colors.white , )),
                            onTap: iniciarSesion,
                          ),
                        ),
                        SizedBox(height: 50,)
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  iniciarSesion() async {
    if(_emailController.value.text == '' || _passwordController.value.text == ''){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Favor de llenar los campos")));
      return;
    }

    setState(() {
      loading = true;
    });

    LoginModel? loginModel = await UserApi().iniciarSesion(_emailController.value.text, _passwordController.value.text);

    if(loginModel == null){
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Error al iniciar sesión")));
      setState(() {
        loading = false;
      });
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("inicio correcto")));
    Navigator.pushNamed(context, '/home');
    final localStorage = await SharedPreferences.getInstance();
    await localStorage.setString('token', loginModel.jwt!);
    await localStorage.setString('idUser', loginModel.user!.id!);
    await localStorage.setString('nombre', loginModel.user!.name!);
    await localStorage.setString('apellidos', loginModel.user!.lastname!);
    await localStorage.setString('email', loginModel.user!.email!);
    setState(() {
      loading = false;
    });

  }
}
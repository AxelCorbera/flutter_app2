import 'package:flutter/material.dart';
import 'package:flutter_app2/scripts/request.dart' as request;
import 'package:flutter_app2/scripts/album.dart' as album;

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _loading = false;
  String userName = '';
  String password = '';
  String _errorMessage = "";
  GlobalKey<FormState> _keyForm = GlobalKey();
  GlobalKey<ScaffoldState> _keyScaf = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyScaf,
        body: Form(
      key: _keyForm,
      child: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 70),
            decoration: BoxDecoration(
                gradient: LinearGradient(
              colors: [Colors.greenAccent, Colors.blueAccent],
            )),
            child: Column(
              children: [
                Image.asset(
                  'lib/assets/images/logoMorita2.png',
                  color: Colors.white,
                  height: 125,
                ),
                SizedBox(height: 20,),
                Center(
                    child: Text(
                      'Moritas Shop',
                      style: TextStyle(
                          fontSize: 25,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    )),
              ],
            ),
            height: 350,
          ),
          Transform.translate(
            offset: Offset(0, -50),
            child: (Center(
              child: SingleChildScrollView(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(left: 20, right: 20, top: 260),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35, vertical: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: "Email:"),
                          onSaved: (value) {
                            userName = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: InputDecoration(labelText: "Contraseña:"),
                          obscureText: true,
                          onSaved: (value) {
                            password = value!;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Este campo es obligatorio';
                            }
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton(
                          color: Theme.of(context).primaryColor,
                          textColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          onPressed: () {
                            _login(context);
                            _loading;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Iniciar sesion"),
                              if (_loading)
                                Container(
                                  height: 20,
                                  width: 20,
                                  margin: const EdgeInsets.only(left: 20),
                                  child: CircularProgressIndicator(color: Colors.white,),
                                )
                            ],
                          ),
                        ),
                        if (_errorMessage.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Text(
                              _errorMessage,
                              style: TextStyle(
                                  color: Colors.red, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('No estas registrado?'),
                            FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed('/Register');
                                },
                                textColor: Theme.of(context).primaryColor,
                                child: Text('Registrarse'))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )),
          )
        ],
      ),
    ));
  }

  void _login(BuildContext context) async{
    if (!_loading) {
      if(_keyForm.currentState!.validate()){
        _keyForm.currentState!.save();
        setState(() {
          _loading = true;
        });
        request.Album token= await request.IniciarSesion(userName, password);
        print('tokeN ' + token.id.toString());
        setState(() {
          if(token.id != '' && token.id != '-1'){
            _loading = false;
            _errorMessage = "";
            Navigator.of(context).pushNamed('/Home');
          }else if(token.id == '' && token.id != '-1'){
            _loading = false;
            _errorMessage = "Usuario y/o clave incorrecto";
          }else if(token.id != '' && token.id == '-1'){
            _loading = false;
            _mostrarMensaje('Error de conexion');
          }

        });
      }
    }else{
      setState(() {
        _loading = false;
        _errorMessage = "";
        print(userName + '>>' + password);
      });
    }
  }

  void _mostrarMensaje(String msg) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    _keyScaf.currentState!.showSnackBar(snackBar);
  }
}


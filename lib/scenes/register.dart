import 'package:flutter/material.dart';
import 'package:flutter_app2/scripts/request.dart' as request;
import 'package:flutter_app2/scripts/album.dart' as album;

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _passwordVisible = false;
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
                child: Image.asset(
                  'lib/assets/images/logoMorita2.png',
                  color: Colors.white,
                  height: 140,
                ),
              ),
              SizedBox(
                child: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                ),
              ),
              Transform.translate(
                offset: Offset(0, -150),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 70),
                  child: Center(
                      child: Text(
                    'Crear cuenta',
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              ),
              Transform.translate(
                offset: Offset(0, -40),
                child: (Center(
                  child: SingleChildScrollView(
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      margin:
                          const EdgeInsets.only(left: 20, right: 20, top: 260),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 35, vertical: 20),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            TextFormField(
                              decoration: InputDecoration(labelText: "Nombre:"),
                              onSaved: (value) {
                                userName = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                              },
                            ),
                            TextFormField(
                              decoration:
                                  InputDecoration(labelText: "Apellido:"),
                              onSaved: (value) {
                                userName = value!;
                              },
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Este campo es obligatorio';
                                }
                              },
                            ),
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
                            TextFormField(
                              decoration: InputDecoration(
                                labelText: "Contraseña:",
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    _passwordVisible
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  ),
                                  onPressed: () {
                                    // Update the state i.e. toogle the state of passwordVisible variable
                                    setState(() {
                                      _passwordVisible = !_passwordVisible;
                                    });
                                  },
                                ),
                              ),
                              obscureText: _passwordVisible,
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
                              height: 40,
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
                                  Text("Registrarme"),
                                  if (_loading)
                                    Container(
                                      height: 20,
                                      width: 20,
                                      margin: const EdgeInsets.only(left: 20),
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                      ),
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
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                FlatButton(
                                    onPressed: () {
                                      Navigator.of(context).pushNamed('/Login');
                                    },
                                    textColor: Theme.of(context).primaryColor,
                                    child: Text('Cancelar'))
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

  void _login(BuildContext context) async {
    if (!_loading) {
      if (_keyForm.currentState!.validate()) {
        _keyForm.currentState!.save();
        setState(() {
          _loading = true;
        });
        album.tokenIngreso token =
            await request.IniciarSesion(userName, password);
        print('tokeN ' + token.id.toString());
        setState(() {
          if (token.id != '' && token.id != '-1') {
            _loading = false;
            _errorMessage = "";
          } else if (token.id == '' && token.id != '-1') {
            _loading = false;
            _errorMessage = "Usuario y/o clave incorrecto";
          } else if (token.id != '' && token.id == '-1') {
            _loading = false;
            _mostrarMensaje('Error de conexion');
          }
        });
      }
    } else {
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

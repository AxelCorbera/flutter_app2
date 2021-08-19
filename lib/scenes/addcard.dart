import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/globals.dart' as globals;

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final _textFieldControllerNumber = TextEditingController();
  final _textFieldControllerName = TextEditingController();
  final _textFieldControllerExpire = TextEditingController();
  final _textFieldControllerSecCode = TextEditingController();
  GlobalKey<FormState> _keyForm = GlobalKey();
  String numero = "**** **** **** ****";
  String nombre = "NOMBRE APELLIDO";
  String vencimiento = "--/--";
  int caracteres = 0;
  int caracteres2 = 0;
  int caracteres3 = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Nueva tarjeta'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            SizedBox(
              height: 230,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                elevation: 5,
                //color: Colors.grey[300],
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      gradient: LinearGradient(
                          begin: Alignment.bottomLeft,
                          end: Alignment.topRight,
                          colors: [
                            Colors.orangeAccent,
                            Colors.deepOrangeAccent
                          ])),
                  child: Column(
                    children: <Widget>[
                      Row(children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(25),
                          alignment: Alignment.centerLeft,
                          width: 90,
                          height: 60,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [Colors.white, Colors.white])),
                        ),
                      ]),
                      SizedBox(
                        height: 10,
                      ),
                      Row(children: <Widget>[
                        SizedBox(
                          width: 23,
                        ),
                        Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              numero,
                              style:
                                  TextStyle(fontSize: 30, color: Colors.white),
                            ))
                      ]),
                      SizedBox(
                        height: 20,
                      ),
                      Row(children: <Widget>[
                        SizedBox(
                          width: 15,
                        ),
                        Padding(
                            padding: EdgeInsets.all(0),
                            child: Text(
                              nombre,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          vencimiento,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        )
                      ]),
                    ],
                  ),
                ),
              ),
            ),
            Form(
              key: _keyForm,
              child: Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(children: <Widget>[
                    TextFormField(
                      maxLength: 19,
                      controller: _textFieldControllerNumber,
                      decoration:
                          InputDecoration(labelText: "Numero de la tarjeta:"),
                      onChanged: (value) {
                        _keyForm.currentState!.save();
                      },
                      onSaved: (value) {
                        if (_textFieldControllerNumber.value.text.length < caracteres && _textFieldControllerNumber.value.text.length == 4 ||
                            _textFieldControllerNumber.value.text.length <
                                    caracteres &&
                                _textFieldControllerNumber.value.text.length ==
                                    9 ||
                            _textFieldControllerNumber.value.text.length <
                                    caracteres &&
                                _textFieldControllerNumber.value.text.length ==
                                    14) {
                        } else if (_textFieldControllerNumber
                                    .value.text.length ==
                                4 ||
                            _textFieldControllerNumber.value.text.length == 9 ||
                            _textFieldControllerNumber.value.text.length ==
                                14) {
                          _textFieldControllerNumber.text =
                              _textFieldControllerNumber.value.text + " ";
                          _textFieldControllerNumber
                            ..selection = TextSelection.fromPosition(
                                TextPosition(
                                    offset: _textFieldControllerNumber
                                        .text.length));
                        }
                        String a = "**** **** **** ****";
                        numero = a.replaceRange(
                            0,
                            _textFieldControllerNumber.value.text.length,
                            _textFieldControllerNumber.value.text);

                        setState(() {
                          caracteres =
                              _textFieldControllerNumber.value.text.length;
                          print(_textFieldControllerNumber.value.text);
                          print(numero);
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                      },
                    ),
                    TextFormField(
                      controller: _textFieldControllerName,
                      decoration:
                          InputDecoration(labelText: "Nombre del titular:"),
                      onChanged: (value) {
                        _keyForm.currentState!.save();
                      },
                      onSaved: (value) {
                        String a = "NOMBRE APELLIDO";
                        if(_textFieldControllerName.value.text.length>0) {
                          nombre =
                              _textFieldControllerName.value.text.toUpperCase();
                        }else{
                          nombre = a;
                        }

                        setState(() {
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                      },
                    ),
                    TextFormField(
                      maxLength: 5,
                      controller: _textFieldControllerExpire,
                      decoration: InputDecoration(labelText: "Vencimiento:"),
                      onChanged: (value) {
                        _keyForm.currentState!.save();
                      },
                      onSaved: (value) {
                        if (_textFieldControllerExpire.value.text.length < caracteres2 && _textFieldControllerExpire.value.text.length == 2 ) {
                        } else if (_textFieldControllerExpire
                                    .value.text.length ==
                                2) {
                          _textFieldControllerExpire.text =
                              _textFieldControllerExpire.value.text + "/";
                          _textFieldControllerExpire
                            ..selection = TextSelection.fromPosition(
                                TextPosition(
                                    offset: _textFieldControllerExpire
                                        .text.length));
                        }
                        String a = "--/--";
                        vencimiento = a.replaceRange(
                            0,
                            _textFieldControllerExpire.value.text.length,
                            _textFieldControllerExpire.value.text);

                        setState(() {
                          caracteres2 =
                              _textFieldControllerExpire.value.text.length;
                          print(_textFieldControllerExpire.value.text);
                          print(vencimiento);
                        });
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                      },
                    ),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

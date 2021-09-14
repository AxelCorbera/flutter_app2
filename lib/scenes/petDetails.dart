import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app2/scenes/pets.dart';
import 'package:flutter_app2/scripts/mercadopago/json/mascotas.dart';
import 'package:flutter_app2/globals.dart' as globals;
import 'package:flutter_app2/scripts/request.dart';

class PetDetails extends StatefulWidget {
  const PetDetails({Key? key, required this.argumentos}) : super(key: key);
  final MascotaSeleccionada argumentos;
  _PetDetailState createState() => _PetDetailState();
}

class _PetDetailState extends State<PetDetails> {
  Mascotas mascotas = new Mascotas(items: []);
  String menu = 'home';
  bool busqueda = true;
  List<MemoryImage> fotos = [];
  int carrito = globals.carrito.id.length;
  bool datos = true;

  @override
  Widget build(BuildContext context) {
    mascotas = widget.argumentos.mascotas;
    fotos = widget.argumentos.fotos;
    int seleccionado = widget.argumentos.seleccionado;
    print(mascotas.items[seleccionado].sexo);

    carrito = globals.carrito.id.length;
    return Scaffold(
      backgroundColor: mascotas.items[seleccionado].sexo=="MACHO"?Colors.cyan:Colors.pinkAccent,
      appBar: appbar(mascotas.items[seleccionado].nombre.toString() +
          " " +
          mascotas.items[seleccionado].apellido.toString()),
      body: ListView(
        children: [
          Column(children: <Widget>[
            Stack(children: _detalles(mascotas, seleccionado)),
            Column(children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        datos = true;
                        setState(() {});
                      },
                      child: Container(
                          // optional
                          padding: const EdgeInsets.all(5),
                          decoration: datos
                              ? BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2.0,
                                          color: Theme.of(context)
                                              .secondaryHeaderColor)))
                              : null,
                          child: Text(
                            'Datos',
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Text(
                      "|",
                      style: TextStyle(
                          color: Theme.of(context).secondaryHeaderColor,
                          fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () {
                        datos = false;
                        setState(() {});
                      },
                      child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: !datos
                              ? BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          width: 2.0,
                                          color: Theme.of(context)
                                              .secondaryHeaderColor)))
                              : null,
                          child: Text(
                            'Historial clinico',
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                  ],
                ),
              ),
            ]),
          ]),
          datos?_datos(seleccionado):_historial(seleccionado),
        ],
      ),
    );
  }

  AppBar appbar(String title) {
    return AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          RaisedButton(
            color: Theme.of(context).primaryColor,
            elevation: 1,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/Cart')
                  .then((value) => setState(() {}));
            },
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Colors.white,
                ),
                if (carrito > 0)
                  Center(
                    child: Container(
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Center(
                          child: Text(
                        carrito.toString(),
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )),
                    ),
                  ),
              ],
            ),
          )
        ]);
  }

  Widget _datos(int index) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Nacimiento",
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      mascotas.items[index].nacimiento.toString(),
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Santos lugares, Buenos Aires',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Pelaje",
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Gris y blanco',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' ',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Telefono",
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '11 3573 4301',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Direccion",
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'R. Peña 1709',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "",
                    style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "",
                    style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    '',
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _historial(int index) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "historias clinicas",
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' ',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _detalles(Mascotas mascotas, int index) {
    return <Widget>[
      Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(
            minHeight: 20,
            maxHeight: 350,
            minWidth: 20,
            maxWidth: double.infinity),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                    //color: Colors.red,
                    )),
            Expanded(
                flex: 1,
                child: Container(
                  //color: Colors.blue,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _puntos(mascotas, index),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Text(
                                        mascotas.items[index].nombre.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      mascotas.items[index].sexo=="MACHO"?Icon(
                                        Icons.male,
                                        color: Colors.grey,
                                      ):Icon(
                                        Icons.female,
                                        color: Colors.grey,
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      mascotas.items[index].especie.toString(),
                                      textAlign: TextAlign.start,
                                    )
                                  ]),
                              Column(
                                children: [
                                  Container(child: Text('')),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                      child: FlatButton.icon(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                          label: Text(''))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
      Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(maxHeight: 230, maxWidth: double.infinity),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            image: DecorationImage(
              image: fotos[index],
              fit: BoxFit.cover,
            )),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.white])),
        ),
      ),
    ];
  }

  List<Widget> _puntos(Mascotas mascotas, int index) {
    List<Widget> cant = [];
    Widget relleno = Flexible(
      flex: 5,
      child: SizedBox(
        width: 200,
        height: 20,
      ),
    );
    cant.add(relleno);
    int i = 0;
    mascotas.items.forEach((element) {
      Widget texto = index == i
          ? Flexible(
              flex: 1,
              child: Icon(
                Icons.circle,
                size: 8,
                color: Theme.of(context).primaryColor,
              ))
          : Flexible(
              flex: 1,
              child: Icon(
                Icons.circle,
                size: 8,
                color: Colors.grey,
              ));
      cant.add(texto);
      i++;
    });
    cant.add(relleno);
    return cant;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _consultarMascotas() async {
    if (globals.usuario!.id.toString() != "") {
      if (busqueda)
        //fotoMascotas = await BuscarFotoMascotas(globals.usuario!.id.toString());
        mascotas = await BuscarMascotas(globals.usuario!.id.toString());
      busqueda = false;
      setState(() {});
    } else {}
  }
}

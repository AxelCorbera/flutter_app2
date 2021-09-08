import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_app2/scripts/mercadopago/json/mascotas.dart';
import 'package:flutter_app2/globals.dart' as globals;
import 'package:flutter_app2/scripts/request.dart';

class Pets extends StatefulWidget {
  _PetsState createState() => _PetsState();
}

class _PetsState extends State<Pets> {
  Mascotas mascotas = new Mascotas(items: []);
  String menu = 'home';
  bool busqueda = true;
  List<bool> abrir = [];
  int carrito = globals.carrito.id.length;
  @override
  Widget build(BuildContext context) {
    _consultarMascotas();
    Uint8List bytes;
    // if (!request) {
    //   _buscaritems(widget.categoria, widget.marca, widget.busqueda as String);
    // }
    carrito = globals.carrito.id.length;
    return Scaffold(
      appBar: appbar("Mis mascotas"),
      body: !busqueda?Column(children: [
        Container(
          margin: EdgeInsets.all(10),
          color: Colors.transparent,
          child: _expansionPanel(mascotas),
          //dividerColor: Colors.grey,
        ),
      ]):
      Center(
        child: CircularProgressIndicator(),
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

  Widget _expansionPanel(Mascotas mascotas) {
    return ExpansionPanelList(
      elevation: 0,
      animationDuration: Duration(milliseconds: 1000),
      children: _listExpansion(mascotas),
      expansionCallback: (panelIndex, isExpanded) {
        abrir[panelIndex] = !abrir[panelIndex];
        print(abrir[panelIndex].toString() + " > " + panelIndex.toString());
        setState(() {});
      },
      //dividerColor: Colors.grey,
    );
  }

  List<ExpansionPanel> _listExpansion(Mascotas mascotas) {
    List<ExpansionPanel> l = <ExpansionPanel>[];
    int a = 0;
    for (var i in mascotas.items) {
      abrir.add(false);
      ExpansionPanel item = ExpansionPanel(
        //backgroundColor: Colors.transparent,
        headerBuilder: (context, isExpanded) {
          return ListTile(
            title: Text(
              i.nombre.toString(),
              style: TextStyle(color: Colors.black),
            ),
          );
        },
        body: Column(
          children: [
            if (i.especie.toString() != "")
              ListTile(
                title: Text("Especie: " + i.especie.toString(),
                    style: TextStyle(color: Colors.black)),
              ),
            if (i.sexo.toString() != "")
              ListTile(
                title: Text("Sexo: " + i.sexo.toString(),
                    style: TextStyle(color: Colors.black)),
              ),
            if (i.raza.toString() != "")
              ListTile(
                title: Text("Raza: " + i.raza.toString(),
                    style: TextStyle(color: Colors.black)),
              ),
            if (i.nombre.toString() != "")
              ListTile(
                title: Text("Nombre: " + i.nombre.toString(),
                    style: TextStyle(color: Colors.black)),
              ),
            if (i.apellido.toString() != "")
              ListTile(
                title: Text("Apellido: " + i.apellido.toString(),
                    style: TextStyle(color: Colors.black)),
              ),
            if (i.peso.toString() != "")
              ListTile(
                title: Text("Peso: " + i.peso.toString(),
                    style: TextStyle(color: Colors.black)),
              ),
            if (i.nacimiento.toString() != "")
              ListTile(
                title: Text("Fecha de nacimiento: " + i.nacimiento.toString(),
                    style: TextStyle(color: Colors.black)),
              ),
            if (i.observacion.toString() != "")
              ListTile(
                title: Text("Observacion: " + i.observacion.toString(),
                    style: TextStyle(color: Colors.black)),
              ),
            ButtonBar(
              children: <Widget>[
                FlatButton.icon(
                  onPressed: () {},
                  icon: Icon(
                    Icons.edit,
                    color: Theme.of(context).primaryColor,
                  ),
                  label: Text(""),
                ),FlatButton.icon(
                  onPressed: () {
                  },
                  icon: Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: Text(""),
                ),
              ],
            )
          ],
        ),
        isExpanded: abrir[a],
        canTapOnHeader: true,
      );
      a++;
      l.add(item);
    }

    return l;
  }

  @override
  void initState() {
    super.initState();
  }

  MemoryImage _imagen(String imagen) {
    var bytes = base64.decode(imagen);
    return new MemoryImage(bytes);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _consultarMascotas() async {
    if(busqueda)
    mascotas = await BuscarMascotas(globals.usuario!.id.toString());
    busqueda=false;
    setState(() {});
  }
}

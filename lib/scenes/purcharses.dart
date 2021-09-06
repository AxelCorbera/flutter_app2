import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_app2/scripts/mercadopago/json/baseDatos.dart';
import 'package:flutter_app2/scripts/request.dart';
import 'package:flutter_app2/globals.dart' as globals;

class Purchases extends StatefulWidget {

  @override
  _PurchasesState createState() => _PurchasesState();
}

class _PurchasesState extends State<Purchases> {
  String menu = 'home';
  bool busqueda = true;
  Compras compras = new Compras(id: [], fecha: [], cliente: [], productos: [], total: [], estado: [], tarjeta: [], idPago: [], documento: [], token: [], cuotas: [], montoCuota: [], totalCuota: [], detalle: [], telefono: []);
  int carrito = globals.carrito.id.length;
  @override
  Widget build(BuildContext context) {
    Uint8List bytes;

    // if (!request) {
    //   _buscaritems(widget.categoria, widget.marca, widget.busqueda as String);
    // }
    _buscarCompras();
    print("KKKKK "+busqueda.toString());
    carrito = globals.carrito.id.length;
    return Scaffold(
      appBar: appbar("Ultimas compras"),
      body: !busqueda ?
      ListView.builder(
        itemCount: compras.id!.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              // Navigator.of(context).pushNamed('/Items',
              //     arguments: argumentsItems(categoria, marcas[index], "")).then((value) => setState((){}));
            },
            child: Hero(
              tag: compras.id!.length,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.all(3),
                    child: Card(
                      color: Colors.white60,
                      semanticContainer: true,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Center(
                                child: Text(
                                  compras.id![index],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                  ),
                ],
              ),
            ),
          );
        })
      :Center(
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
            elevation: 0,
            onPressed: () {
              Navigator.of(context).pushNamed('/Cart').then((value) => setState((){}));
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

  void _buscarCompras() async{
    if(busqueda) {
      print("usuario>> " + globals.usuario!.id.toString());
      compras = await BuscarCompras(globals.usuario!.id.toString());
      busqueda = false;
      setState(() {});
    }
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
}
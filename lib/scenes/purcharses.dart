import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter_app2/arrows_icons_icons.dart';
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
  Compras compras = new Compras(
      id: [],
      fecha: [],
      cliente: [],
      productos: [],
      total: [],
      estado: [],
      tarjeta: [],
      pago: [],
      idPago: [],
      documento: [],
      token: [],
      cuotas: [],
      montoCuota: [],
      totalCuota: [],
      detalle: [],
      telefono: []);
  int carrito = globals.carrito.id.length;
  @override
  Widget build(BuildContext context) {
    Uint8List bytes;

    // if (!request) {
    //   _buscaritems(widget.categoria, widget.marca, widget.busqueda as String);
    // }
    _buscarCompras();
    print("KKKKK " + busqueda.toString());
    carrito = globals.carrito.id.length;
    return Scaffold(
      appBar: appbar("Ultimas compras"),
      body: !busqueda
          ? Stack(children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {},
                    child: Text("Todos",
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                  Text("|",
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                  FlatButton(
                    onPressed: () {},
                    child: Text("Aprobados",
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                  Text("|",
                      style: TextStyle(
                        color: Colors.grey,
                      )),
                  FlatButton(
                    onPressed: () {},
                    child: Text("Rechazados",
                        style: TextStyle(
                          color: Colors.grey,
                        )),
                  ),
                ],
              ),
              Transform(
                transform: Matrix4.translationValues(0, 50, 0),
                child: Container(
                  child: ListView.builder(
                      itemCount: compras.id!.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed('/PurchaseDetails',
                                    arguments: Compra(
                                        id: compras.id![index],
                                        fecha: compras.fecha![index],
                                        cliente: compras.cliente![index],
                                        productos: compras.productos![index],
                                        total: compras.total![index],
                                        pago: compras.pago![index],
                                        estado: compras.estado![index],
                                        tarjeta: compras.tarjeta![index],
                                        idPago: compras.idPago![index],
                                        documento: compras.documento![index],
                                        token: compras.token![index],
                                        cuotas: compras.cuotas![index],
                                        montoCuota: compras.montoCuota![index],
                                        totalCuota: compras.totalCuota![index],
                                        detalle: compras.detalle![index],
                                        telefono: compras.telefono![index]))
                                .then((value) => setState(() {}));
                          },
                          child: Hero(
                            tag: compras.id!.length,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.all(3),
                                  child: Card(
                                    margin: EdgeInsets.all(2),
                                    color: Colors.white60,
                                    semanticContainer: true,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      compras.estado![index] ==
                                                                  "approved" ||
                                                              compras.estado![
                                                                      index] ==
                                                                  "pagado"
                                                          ? Icon(
                                                              ArrowsIcons
                                                                  .arrow_up_right2,
                                                              color:
                                                                  Colors.green,
                                                              size: 20,
                                                            )
                                                          : Icon(
                                                              ArrowsIcons
                                                                  .arrow_down_left2,
                                                              color: Colors.red,
                                                              size: 20),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        "Compra " +
                                                            compras.id![index],
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        compras.estado![index],
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "\$" +
                                                            compras
                                                                .total![index],
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                      SizedBox(
                                                        height: 4,
                                                      ),
                                                      Text(
                                                        compras.fecha![index],
                                                        style: TextStyle(
                                                            color: Colors.grey,
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5)),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: new Divider(
                                    endIndent: 20,
                                    indent: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ),
            ])
          : Center(
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

  void _buscarCompras() async {
    if (busqueda) {
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

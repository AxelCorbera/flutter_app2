import 'package:flutter/material.dart';
import 'package:flutter_app2/globals.dart' as globals;

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  double total = 0;

  Widget build(BuildContext context) {
    total = Sumar(globals.carrito.precio);
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text("Mi Carrito"),
      ),
      body: Column(children: <Widget>[
        Center(
          child: Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Container(
                width: 375,
                height: 450,
                child: ListView.builder(
                    itemCount: globals.carrito.id.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: Text(globals.carrito.cantidad[index]),
                        title: Text(globals.carrito.marca[index].toString() +
                            " " +
                            globals.carrito.nombre[index].toString()),
                        trailing:
                            Text(globals.carrito.precio[index].toString()),
                      );
                    })),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Total: " + total.toString(),
            style: TextStyle(fontSize: 25,color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.navigate_next),
                  label: Text("Finalizar compra"))
            ],
          ),
        )
      ]),
    );
  }

  dynamic Sumar(List<dynamic> lista) {
    double total = 0;
    lista.forEach((p) {
      total = total + p;
    });
    return total;
  }
}

import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_app2/scripts/request.dart';

class Items extends StatefulWidget {
  const Items(
      {Key? key, required this.categoria, required this.marca, this.busqueda})
      : super(key: key);

  @override
  final String categoria;
  final String marca;
  final String? busqueda;

  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  String menu = 'home';
  bool request = false;
  Marcas items = Marcas(
      id: [],
      codigo: [],
      marca: [],
      nombre: [],
      cantidad: [],
      stock: [],
      precio: [],
      imagen: [],
      tamano: [],
      color: []);

  @override
  Widget build(BuildContext context) {
    Uint8List bytes;
    if (!request) {
      _buscaritems(widget.categoria, widget.marca, widget.busqueda as String);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.marca),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: GridView.count(
        // crossAxisCount is the number of columns
        crossAxisCount: 2,
        // This creates two columns with two items in each column
        children: List.generate(this.items.id.length, (index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('/Item',
                  arguments: Marca(
                      this.items.id[index],
                      this.items.codigo[index],
                      this.items.marca[index],
                      this.items.nombre[index],
                      this.items.cantidad[index],
                      this.items.stock[index],
                      this.items.precio[index],
                      this.items.imagen[index],
                      this.items.tamano![index],
                      this.items.color[index]));
            },
            child: Hero(
              tag: this.items.id[index],
              child: Container(
                margin: EdgeInsets.all(5),
                child: Card(
                  color: Colors.white60,
                  semanticContainer: true,
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          FadeInImage(
                            image: _imagen(items.imagen[index]),
                            height: 120,
                            placeholder:
                                AssetImage("lib/assets/images/loader.gif"),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: Text(
                              this.items.nombre[index],
                              style: TextStyle(
                                  fontSize: 12, fontWeight: FontWeight.bold),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              if (widget.categoria == 'alimentoPerro' ||
                                  widget.categoria == 'alimentoGato')
                                Text(
                                  this.items.cantidad[index] + " Kg",
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                ),
                              Text(
                                "\$ " + this.items.precio[index].toString(),
                                style: TextStyle(
                                    fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  elevation: 5.0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(Duration.zero, () {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Center(
                child: new Container(
              child: CircularProgressIndicator(color: Colors.blueAccent),
            ));
          });
    });
  }

  void _buscaritems(String categoria, String marca, String busqueda) async {
    Marcas resultadoMarca = await Buscaritems(categoria, marca, busqueda);
    request = true;
    setState(() {
      this.items = resultadoMarca as Marcas;
      Navigator.of(context).pop();
    });
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

class Marca {
  final String id;
  final String codigo;
  final String marca;
  final String nombre;
  final String cantidad;
  final String stock;
  final dynamic precio;
  final String imagen;
  final String tamano;
  final String color;

  Marca(this.id, this.codigo, this.marca, this.nombre, this.cantidad,
      this.stock, this.precio, this.imagen, this.tamano, this.color);
}

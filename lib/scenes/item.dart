import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_app2/Home.dart';
import 'package:flutter_app2/scenes/items.dart';
import 'package:flutter_app2/scripts/request.dart';
import 'package:flutter_app2/globals.dart' as globals;

class Item extends StatefulWidget {
  const Item({Key? key, required this.item}) : super(key: key);
  static const routeName = '/Item';
  final Marca item;

  @override
  _itemState createState() => _itemState();
}

class _itemState extends State<Item> with TickerProviderStateMixin {
  // late AnimationController controller;
  // bool isPlaying = false;
  int carrito = globals.carrito.id.length;
  final _scaffKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffKey,
      backgroundColor: Colors.white38,
      appBar: appbar("Producto"),
      body: Center(
        child: Hero(
          tag: widget.item.id,
          child: Card(
            margin: EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 25),
            color: Colors.grey[200],
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: cardConteiner(widget.item, context),
            ),
          ),
        ),
      ),
    );
  }

//   void toggleIcon()=> setState((){
// isPlaying = !isPlaying;
// isPlaying ? controller.forward() : controller.reverse();
//   });
  // ANIMATIONICON

  Widget cardConteiner(Marca item, BuildContext context) {
    AnimationController controller = AnimationController(
      vsync: this,
    );
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Center(
            child: FadeInImage(
              image: _imagen(item.imagen),
              height: 200,
              fit: BoxFit.fill,
              placeholder: AssetImage("lib/assets/images/loader.gif"),
              fadeInCurve: Curves.decelerate,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  item.nombre,
                  style: TextStyle(fontSize: 25),
                ),
              ),
              ListView(
                padding: const EdgeInsets.all(20.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  if (item.cantidad != "0")
                    Text("Producto de " +
                        item.cantidad +
                        " Kg.\n\n"
                            "~Consultar stock antes de comprar~"),
                ],
              ),
              Text('Precio: \$ ' + item.precio.toString(),
                  style: TextStyle(fontSize: 20)),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  RaisedButton.icon(
                      icon: Icon(Icons.chat),
                      label: Text(
                        'Consultar Stock',
                      ),
                      onPressed: () {}),
                  RaisedButton.icon(
                      icon: Icon(Icons.add_shopping_cart),
                      label: Text('Agregar al carrito'),
                      onPressed: () {
                        _showDialog(context);
                      }),
                ],
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
        ]);
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
              Navigator.of(context).pushNamed('/Cart');
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

  void _showDialog(BuildContext context) {
    GlobalKey keyText = GlobalKey<EditableTextState>();
    bool cant = false;
    final _textFieldController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('¿Cuantas deseas llevar?'),
            content: TextField(
              key: keyText,
              onChanged: (value) {
                if(value.length>0){
                  cant = true;
                }
              },
              controller: _textFieldController,
              decoration: InputDecoration(labelText: 'cantidad', hintText: "1"),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              ButtonBar(
                children: <Widget>[
                  RaisedButton.icon(
                      onPressed: cant?null:(){},
                      icon: Icon(Icons.done),
                      label: Text("Agregar")),
                ],
              )
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();

    // controller = AnimationController(
    //   vsync: this,
    //   duration: Duration(milliseconds: 1000),
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }

  MemoryImage _imagen(String imagen) {
    var bytes = base64.decode(imagen);
    return new MemoryImage(bytes);
  }

  void _agregarProducto(Marca item) {
    globals.carrito.id.add(widget.item.id);
    globals.carrito.codigo.add(widget.item.codigo);
    globals.carrito.marca.add(widget.item.marca);
    globals.carrito.nombre.add(widget.item.nombre);
    globals.carrito.cantidad.add(widget.item.cantidad);
    globals.carrito.stock.add(widget.item.stock);
    globals.carrito.precio.add(widget.item.precio);
    globals.carrito.imagen.add(widget.item.imagen);
    globals.carrito.tamano!.add(widget.item.tamano);
    globals.carrito.color.add(widget.item.color);
  }

  void _mostrarMensaje(String msg) {
    SnackBar snackBar = SnackBar(
      duration: Duration(seconds: 1),
      backgroundColor: Colors.greenAccent,
      content: Text(
        msg,
        style: TextStyle(color: Colors.black),
      ),
    );
    _scaffKey.currentState!.showSnackBar(snackBar);
  }
}

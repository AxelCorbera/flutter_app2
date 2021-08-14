import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app2/Home.dart';
import 'package:flutter_app2/scenes/items.dart';
import 'package:flutter_app2/scripts/request.dart';

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

  final _scaffKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffKey,
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text('Producto'),
      ),
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
                      onPressed: (){
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

  void _showDialog(BuildContext context) {
    final _textFieldController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Cuantas unidades?'),
            content: TextField(
              onChanged: (value) {},
              controller: _textFieldController,
              decoration: InputDecoration(labelText: '', hintText: "1"),
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              ButtonBar(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _mostrarMensaje('Producto añadido!');
                    },
                    child: Icon(Icons.done),
                  )
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

  void _mostrarMensaje(String msg) {
    SnackBar snackBar = SnackBar(
      backgroundColor: Colors.greenAccent,
      content: Text(msg,style: TextStyle(color: Colors.black),),
    );
    _scaffKey.currentState!.showSnackBar(snackBar);
  }
}

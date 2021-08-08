import 'package:flutter/material.dart';

class Item extends StatefulWidget {
  var imagen;
  @override
  _itemState createState() => _itemState();
  Item(var imagen){
    this.imagen = imagen;
  }
}

class _itemState extends State<Item> {

  final _scaffKey = GlobalKey<ScaffoldState>();
  Widget build(BuildContext context) {
    String url = ModalRoute.of(context)!.settings.arguments.toString();
    print(ModalRoute.of(context)!.settings.arguments.toString());
    return Scaffold(
      key: _scaffKey,
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Producto'),
      ),
      body: Center(
        child: Hero(
          tag: url,
          child: Card(
            margin: EdgeInsets.only(left: 15, right: 15, top: 25, bottom: 25),
            color: Colors.grey[200],
            elevation: 20,
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: cardConteiner(url, context),
            ),
          ),
        ),
      ),
    );
  }

  Widget cardConteiner(var url, BuildContext context) {
    print(url.toString());
    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Center(
            child: FadeInImage(
              image: AssetImage(url),
              width: 200,
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
                  'NOMBRE DEL PRODUCTO',
                  style: TextStyle(fontSize: 25),
                ),
              ),
              ListView(
                padding: const EdgeInsets.all(20.0),
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                children: <Widget>[
                  Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed"
                      " do eiusmod tempor incididunt ut labore et dolore magna "
                      "aliqua. Ut enim ad minim veniam, quis nostrud "
                      "exercitation ullamco laboris nisi ut aliquip ex ea "
                      "commodo consequat."
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed"
                      " do eiusmod tempor incididunt ut labore et dolore magna "
                      "aliqua. Ut enim ad minim veniam, quis nostrud "
                      "exercitation ullamco laboris nisi ut aliquip ex ea "
                      "commodo consequat."),
                ],
              ),
              Text('Precio: \$ 100,00', style: TextStyle(fontSize: 20)),
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
          )
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

  void _mostrarMensaje(String msg) {
    SnackBar snackBar = SnackBar(
      content: Text(msg),
    );
    _scaffKey.currentState!.showSnackBar(snackBar);
  }
}

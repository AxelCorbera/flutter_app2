import 'package:flutter/material.dart';
import 'package:flutter_app2/Home.dart';
import 'package:flutter_app2/scenes/category.dart';
import 'package:flutter_app2/scenes/items.dart';
import 'package:flutter_app2/scenes/shop.dart';
import 'package:flutter_app2/scenes/item.dart';
import 'package:flutter_app2/scenes/login.dart';
import 'package:flutter_app2/scenes/register.dart';
import 'package:flutter_app2/scenes/cart.dart';
import 'package:flutter_app2/Home.dart';
import 'package:flutter_app2/scenes/support.dart';
import 'package:flutter_app2/scenes/cards.dart';
import 'package:flutter_app2/scripts/request.dart';
import 'package:flutter_app2/globals.dart' as globals;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/Home',
      theme: ThemeData(
        fontFamily: 'Raleway',
        brightness: Brightness.light,
        primarySwatch: Colors.blue,
        accentColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(builder: (BuildContext context) {
          switch (settings.name) {
            case "/Home":
              return Home();
            case "/Shop":
              return Shop();
            case "/Login":
              return Login();
            case "/Cart":
              return Cart();
            case "/Item":
              final args = settings.arguments as Marca;
              return Item(item: args);
            case "/Items":
              argumentsItems args = settings.arguments as argumentsItems;
              return Items(
                  categoria: args.categoria,
                  marca: args.marca,
                  busqueda: args.busqueda);
            case "/Category":
              final args = settings.arguments as argumentsHome;
              return Category(categoria: args.icono);
            case "/Register":
              return Register();
            case "/Support":
              return Support();
            case "/Cards":
              return Cards();
            default:
              return Login();
          }
        });
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  MyHomePage();
  int i = 0;

  final _keyScaff = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        key: _keyScaff,
        appBar: AppBar(
          title: new Text('myapp'),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: () {}),
            IconButton(icon: Icon(Icons.remove), onPressed: () {}),
          ],
        ),
        body: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    ListTile(
                      leading: Icon(Icons.arrow_drop_down_circle),
                      title: const Text('Card title 1'),
                      subtitle: Text(
                        'Secondary Text',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Greyhound divisively hello coldly wonderfully marginally far upon excluding.',
                        style: TextStyle(color: Colors.black.withOpacity(0.6)),
                      ),
                    ),
                    ButtonBar(
                      alignment: MainAxisAlignment.start,
                      children: [
                        FlatButton(
                          textColor: const Color(0xFF6200EE),
                          onPressed: () => _accion(context),
                          child: const Text('MENSAJE'),
                        ),
                        FlatButton(
                          textColor: const Color(0xFF6200EE),
                          onPressed: () {
                            // Perform some action
                          },
                          child: const Text('ACTION 2'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }));
  }

  void _accion(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: Text('Desea eliminar?'),
          children: <Widget>[
            ListTile(
              title: Text('Eliminar'),
              leading: Icon(Icons.delete),
              onTap: () => {_mostrarMensaje(), Navigator.pop(context)},
            )
          ],
        );
      },
    );
  }

  void _mostrarMensaje() {
    SnackBar snackBar = SnackBar(
      content: Text('Elemento Eliminado'),
    );
    _keyScaff.currentState!.showSnackBar(snackBar);
  }
}

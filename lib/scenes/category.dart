import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app2/scripts/request.dart';

import '../Home.dart';

class Category extends StatefulWidget {
  const Category({Key? key, required this.categoria}) : super(key: key);
  final String categoria;

  @override
  _categoryState createState() => _categoryState();
}

class _categoryState extends State<Category> {
  List<String> marca = <String>[];
  bool contenido = false;
  GlobalKey<ScaffoldState> _keyScaf = GlobalKey();
  @override
  Widget build(BuildContext context) {
    String categoria = widget.categoria;
    return _scaff(context, categoria, marca);
  }

  @override
  void initState() {
    if(widget.categoria != "Alimentos") {
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
    this.contenido = false;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> listaCategorias = <String>[];

  //  TERMINAR ACAAAAAAA

  void buscar(BuildContext context, String categoria) async {
    listaCategorias = await BuscarCategoria(categoria);
    setState(() {
      this.marca = listaCategorias;
      if (listaCategorias.length > 0) contenido = true;
      Navigator.of(context).pop();
    });
  }

  static Route<Object?> _dialogBuilder(BuildContext context) {
    return DialogRoute<void>(
      context: context,
      builder: (BuildContext context) =>
          const AlertDialog(title: Text('Material Alert!')),
    );
  }

  Widget _scaff(BuildContext context, String categoria, List<String> marcas) {
    @override
    List<String> categoriasNombres = [
      'Alimento perro',
      'Alimento gato',
      'cereales'
    ];
    List<String> categoriasIconos = [
      'lib/assets/icons/dogFood.png',
      'lib/assets/icons/catFood.png',
      'lib/assets/icons/dog-food-pet.png'
    ];
    if (categoria == "Alimentos") {
      return Scaffold(
        key: _keyScaf,
        appBar: AppBar(
          title: Text(categoria),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: GridView.count(
          // crossAxisCount is the number of columns
          crossAxisCount: 2,
          // This creates two columns with two items in each column
          children: List.generate(categoriasNombres.length, (index) {
            return InkWell(
              onTap: () {
                String categ = "";
                if (categoriasNombres[index] == "Alimento perro") {
                  categ = "alimentoPerro";
                } else if (categoriasNombres[index] == "Alimento gato") {
                  categ = "alimentoGato";
                } else {
                  categ = "cereales";
                }
                Navigator.of(context)
                    .pushNamed('/Category', arguments: argumentsHome(categ));
                // print('envia ' + categoriasNombres[index].toString());
              },
              child: Hero(
                tag: categoriasNombres[index],
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.all(5),
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
                              FadeInImage(
                                image: AssetImage(categoriasIconos[index]),
                                height: 120,
                                placeholder:
                                    AssetImage("lib/assets/images/loader.gif"),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Text(
                                  categoriasNombres[index],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
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
                ]),
              ),
            );
          }),
        ),
      );
    } else {
      // CUANDO NO ES ALIMENTO
      if (marcas.length == 0) buscar(context, categoria);
      return Scaffold(
        appBar: AppBar(
          title: Text(categoria),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView.builder(
            itemCount: marcas.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/Items', arguments: argumentsItems(categoria, marcas[index], ""));
                },
                child: Hero(
                  tag: marcas[index],
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
                                      marcas[index],
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
            }),
      );
    }
  }
}

class argumentsItems{
  final String categoria;
  final String marca;
  final String? busqueda;

  argumentsItems(this.categoria, this.marca, this.busqueda);
}


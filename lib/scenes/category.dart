import 'package:flutter/material.dart';
import 'package:flutter_app2/scripts/request.dart';

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
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  List<String> listaCategorias = <String>[];

  void buscar(BuildContext context, String categoria) async {
    listaCategorias = await BuscarCategoria(categoria);
    setState(() {
      this.marca = listaCategorias;
      if (listaCategorias.length > 0) contenido = true;
    });
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
                // Navigator.of(context).pushNamed(
                // '/Categoria', arguments: argumentsHome(categoriasIconos[index]));
                // print('envia ' + categoriasNombres[index].toString());
              },
              child: Hero(
                tag: categoriasNombres[index],
                child: Container(
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
                                    fontSize: 20, fontWeight: FontWeight.bold),
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
              ),
            );
          }),
        ),
      );
    } else {
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
                  // Navigator.of(context).pushNamed(
                  // '/Categoria', arguments: argumentsHome(categoriasIconos[index]));
                  // print('envia ' + categoriasNombres[index].toString());
                },
                child: Hero(
                  tag: marcas[index],
                  child: Column(
                    children: [
                      if (!contenido)
                        Center(
                          child: Container(
                            height: 50,
                            width: 50,
                            margin: const EdgeInsets.only(left: 20),
                            child: CircularProgressIndicator(
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
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

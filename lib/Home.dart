import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class argumentsHome{

  final String icono;

  argumentsHome(this.icono);
}

class _HomeState extends State<Home> {
  String menu = 'home';
  List<String> categoriasNombres = ['Alimentos', 'Golosinas', 'Juguetes',
    'Ropa', 'Accesorios', 'Higiene', 'Piedras', 'Pipetas'];
  List<String> categoriasIconos = ['lib/assets/icons/dog-food-pet.png',
    'lib/assets/icons/snack.png',
    'lib/assets/icons/toy.png',
    'lib/assets/icons/clothes.png',
    'lib/assets/icons/leash.png',
    'lib/assets/icons/shampoo.png',
    'lib/assets/icons/urinary.png',
    'lib/assets/icons/pipette.png'];

  @override
  Widget build(BuildContext context) {
    String urlImage = 'lib/assets/icons/dog-food-pet.png';
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: Theme
            .of(context)
            .primaryColor,
      ),
      body: GridView.count(
        // crossAxisCount is the number of columns
        crossAxisCount: 2,
        // This creates two columns with two items in each column
        children: List.generate(categoriasNombres.length, (index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).pushNamed(
                  '/Item', arguments: argumentsHome(categoriasIconos[index]));
              print('envia ' + categoriasIconos[index].toString());
            },
            child: Hero(
              tag: categoriasIconos[index],
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
                            image: AssetImage(
                                categoriasIconos[index]),
                            height: 120,
                            placeholder:
                            AssetImage("lib/assets/images/loader.gif"),
                          ),
                          SizedBox(height: 10,),
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
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme
                        .of(context)
                        .primaryColor,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Image(
                        image: AssetImage('lib/assets/images/logoMorita2.png'),
                        width: 100,
                        height: 100,
                      ),
                      Text(
                        'Moritas Shop',
                        style: TextStyle(color: Colors.white, fontSize: 25),
                      )
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
              title: Text('Shop'),
              leading: Icon(
                Icons.shop,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              onTap: () {
                _menu(context, 'shop');
              },
            ),
            ListTile(
              title: Text('Mis mascotas'),
              leading: Icon(
                Icons.pets,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              onTap: () {
                _menu(context, 'mis mascotas');
              },
            ),
            ListTile(
              title: Text('Ultimas compras'),
              leading: Icon(
                Icons.monetization_on,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              onTap: () {
                _menu(context, 'ultimas compras');
              },
            ),
            ListTile(
              title: Text('Mis tarjetas'),
              leading: Icon(
                Icons.credit_card,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              onTap: () {
                _menu(context, 'mis tarjetas');
              },
            ),
            ListTile(
              title: Text('Soporte'),
              leading: Icon(
                Icons.support,
                color: Theme
                    .of(context)
                    .primaryColor,
              ),
              onTap: () {
                _menu(context, 'support');
              },
            ),
            ListTile(
              title: Text('Cerrar sesion'),
              leading: Icon(
                Icons.close,
                color: Colors.red,
              ),
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
            )
          ],
        ),
      ),
    );
  }


  void _menu(BuildContext context, String pantalla) {
    Navigator.pop(context);
    setState(() {
      menu = pantalla;
    });
    if (pantalla == 'shop') {
      Navigator.of(context).pushNamed('/Shop');
    }
    print(pantalla);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
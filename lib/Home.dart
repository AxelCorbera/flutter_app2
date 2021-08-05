import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String menu = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inicio'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            final urlImage = 'https://picsum.photos/id/$index/410/300';
            return InkWell(
              onTap: (){
                Navigator.of(context).pushNamed('/Item', arguments: urlImage);
              },
              child: Hero(
                tag: urlImage,
                child: Card(
                  color: Colors.grey[300],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        FadeInImage(
                          image: AssetImage(
                              'https://picsum.photos/id/$index/400/300'),
                          placeholder:
                          AssetImage("lib/assets/images/loader.gif"),
                        ),
                        Text(
                          'imagen',
                          style: TextStyle(
                              fontSize: 25, fontStyle: FontStyle.italic),
                        ),
                        Text(
                          'descripcion imagen',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                        Text(
                          '\$ 100.00',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  elevation: 2.0,
                ),
              ),
            );
          }),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Theme.of(context).primaryColor,
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
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                _menu(context, 'shop');
              },
            ),
            ListTile(
              title: Text('Mis mascotas'),
              leading: Icon(
                Icons.pets,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                _menu(context, 'mis mascotas');
              },
            ),
            ListTile(
              title: Text('Ultimas compras'),
              leading: Icon(
                Icons.monetization_on,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                _menu(context, 'ultimas compras');
              },
            ),
            ListTile(
              title: Text('Mis tarjetas'),
              leading: Icon(
                Icons.credit_card,
                color: Theme.of(context).primaryColor,
              ),
              onTap: () {
                _menu(context, 'mis tarjetas');
              },
            ),
            ListTile(
              title: Text('Soporte'),
              leading: Icon(
                Icons.support,
                color: Theme.of(context).primaryColor,
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
                _menu(context, 'CONFIGURACION');
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

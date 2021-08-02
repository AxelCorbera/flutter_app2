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
        backgroundColor: Colors.blue[900],
      ),
      body: Center(child: Text(menu)),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                DrawerHeader(
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.blueGrey,
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
              leading: Icon(Icons.shop, color: Colors.blueGrey,),
              onTap: () {
                _menu(context, 'shop');
              },
            ),
            ListTile(
              title: Text('Mis mascotas'),
              leading: Icon(Icons.pets, color: Colors.blueGrey,),
              onTap: () {
                _menu(context, 'mis mascotas');
              },
            ),
            ListTile(
              title: Text('Ultimas compras'),
              leading: Icon(Icons.monetization_on, color: Colors.blueGrey,),
              onTap: () {
                _menu(context, 'ultimas compras');
              },
            ),
            ListTile(
              title: Text('Mis tarjetas'),
              leading: Icon(Icons.credit_card,  color: Colors.blueGrey,),
              onTap: () {
                _menu(context, 'mis tarjetas');
              },
            ),
            ListTile(
              title: Text('Soporte'),
              leading: Icon(Icons.support, color: Colors.blueGrey,),
              onTap: () {
                _menu(context, 'support');
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
    if(pantalla == 'shop'){
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

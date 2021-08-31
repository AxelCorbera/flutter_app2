import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app2/globals.dart' as globals;

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (globals.cards > 0) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Mis tarjetas'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView.builder(
            itemCount: globals.cards,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    //Navigator.of(context).pushNamed('/Item', arguments: urlImage);
                  },
                  child: Hero(
                      tag: '',
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 230,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 5,
                            //color: Colors.grey[300],
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [Colors.black, Colors.black54])),
                              child: Column(
                                children: <Widget>[
                                  Row(children: <Widget>[
                                    Container(
                                      margin: EdgeInsets.all(25),
                                      alignment: Alignment.centerLeft,
                                      width: 90,
                                      height: 60,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              colors: [
                                                Colors.white,
                                                Colors.white
                                              ])),
                                    ),
                                  ]),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(children: <Widget>[
                                    SizedBox(
                                      width: 23,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Text(
                                          '**** **** **** ****',
                                          style: TextStyle(
                                              fontSize: 50,
                                              color: Colors.white),
                                        ))
                                  ]),
                                  Row(children: <Widget>[
                                    SizedBox(
                                      width: 15,
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(0),
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      '01/25',
                                      style: TextStyle(
                                          fontSize: 18, color: Colors.white),
                                    )
                                  ]),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )));
            }),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Mis tarjetas'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed('/AddCard');
                  },
                  child: Hero(
                      tag: '',
                      child: Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: SizedBox(
                          height: 230,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            elevation: 5,
                            //color: Colors.grey[300],
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                  gradient: LinearGradient(
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                      colors: [Colors.grey, Colors.black54])),
                              child: Center(
                                child: Column(children: <Widget>[
                                  SizedBox(height: 30,),
                                  Text(
                                    "Añadir nueva tarjeta",
                                    style: TextStyle(
                                        fontSize: 30, color: Colors.white),
                                  ),
                                  Text(
                                    "+",
                                    style: TextStyle(
                                        fontSize: 100, color: Colors.white38),
                                  )
                                ]),
                              ),
                            ),
                          ),
                        ),
                      )));
            }),
      );
    }
  }
}

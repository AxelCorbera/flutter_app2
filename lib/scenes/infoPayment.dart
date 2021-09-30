import 'package:flutter/material.dart';
import 'package:flutter_app2/globals.dart' as globals;
import 'package:flutter_app2/scenes/components/direccion.dart';

class InfoPayment extends StatefulWidget {
  @override
  _InfoPaymentState createState() => _InfoPaymentState();
}

class _InfoPaymentState extends State<InfoPayment> {
  bool efectivo = false;
  bool tarjeta = false;
  double total = 0;
  String domicilio = '';
  Direcciones dir = new Direcciones();

  Widget build(BuildContext context) {
    total = Sumar(globals.carrito.precio, globals.carrito.cantidad);
    return Scaffold(
      backgroundColor: Colors.white38,
      appBar: AppBar(
        title: Text("Checkuot"),
      ),
      body: Column(children: <Widget>[
        Center(
          child: Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Domicilio:'),
                  RaisedButton(
                    onPressed: () {
                      _direccion(context, '', '', '', '');
                    },
                    child: Text('Seleccionar domicilio'),
                  ),
                  Text(domicilio),
                ],
              ),
            ),
          ),
        ),
        Center(
          child: Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Forma de pago:'),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            efectivo = true;
                            tarjeta = false;
                            setState(() {

                            });
                          },
                          child: Text('Efectivo'),
                          color: efectivo?Colors.green:null,
                        ),
                        RaisedButton(
                          onPressed: () {
                            efectivo = false;
                            tarjeta = true;
                            setState(() {

                            });
                          },
                          child: Text('Tarjeta credito/debito'),
                          color: tarjeta?Colors.green:null,
                        ),
                      ],
                    ),
                  ),
                  tarjeta?Text('Visa terminada en XXXX'):efectivo?Text('Pago en efectivo'):Text('Seleccionar forma de pago')
                ],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            "Total: " + total.toString(),
            style: TextStyle(
                fontSize: 25, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.navigate_next),
                  label: Text("Continuar"))
            ],
          ),
        )
      ]),
    );
  }

  void _direccion(
      BuildContext context, String prov, String muni, String loc, String dire) {
    String calle = '';
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              content: SingleChildScrollView(
            child: Form(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  DropdownButtonFormField(
                    value: prov != '' ? prov : null,
                    onTap: () {},
                    onSaved: (value) {},
                    onChanged: (value) {
                      Navigator.pop(context);
                      _direccion(context, value.toString(), '', '', '');
                    },
                    hint: Text(
                      'Provincia',
                    ),
                    isExpanded: true,
                    items: [
                      "BUENOS AIRES",
                      "CAPITAL FEDERAL",
                      "CATAMARCA",
                      "CHACO",
                      "CHUBUT",
                      "CORDOBA",
                      "CORRIENTES",
                      "ENTRE RIOS",
                      "FORMOSA",
                      "JUJUY",
                      "LA PAMPA",
                      "LA RIOJA",
                      "MENDOZA",
                      "MISIONES",
                      "NEUQUEN",
                      "RIO NEGRO",
                      "SALTA",
                      "SAN JUAN",
                      "SAN LUIS",
                      "SANTA CRUZ",
                      "SANTA FE",
                      "SANTIAGO DEL ESTERO",
                      "TIERRA DEL FUEGO",
                      "TUCUMAN",
                    ].map((String val) {
                      return DropdownMenuItem(
                        value: val,
                        child: Text(
                          val,
                        ),
                      );
                    }).toList(),
                  ),
                  prov != ''
                      ? DropdownButtonFormField(
                          value: muni != '' ? muni : null,
                          onTap: () {},
                          onSaved: (value) {},
                          onChanged: (value) {
                            Navigator.pop(context);
                            _direccion(context, prov, value.toString(), '', '');
                          },
                          hint: Text(
                            'Municipio',
                          ),
                          isExpanded: true,
                          items: dir.ListaMunicipio(prov).map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val,
                              ),
                            );
                          }).toList(),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  muni != ''
                      ? DropdownButtonFormField(
                          value: loc != '' ? loc : null,
                          onTap: () {},
                          onSaved: (value) {},
                          onChanged: (value) {
                            Navigator.pop(context);
                            _direccion(
                                context, prov, muni, value.toString(), '');
                          },
                          hint: Text(
                            'Localidad',
                          ),
                          isExpanded: true,
                          items: dir.ListaLocalidades(prov, muni)
                              .map((String val) {
                            return DropdownMenuItem(
                              value: val,
                              child: Text(
                                val,
                              ),
                            );
                          }).toList(),
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  loc != ''
                      ? TextFormField(
                          initialValue: dire != '' ? dire : null,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: "Direccion: ",
                          ),
                          onSaved: (value) {},
                          onChanged: (value) {
                            calle = value.toString().toUpperCase();
                          },
                        )
                      : SizedBox(
                          height: 0,
                        ),
                  loc != ''
                      ? ButtonBar(
                          children: [
                            RaisedButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text('Cancelar'),
                            ),
                            RaisedButton(
                              onPressed: () {
                                domicilio =
                                    '$calle, $loc, $muni';
                                Navigator.pop(context);
                                setState(() {

                                });
                              },
                              child: Text('Aceptar'),
                            ),
                          ],
                        )
                      : SizedBox(
                          height: 0,
                        ),
                ],
              ),
            ),
          ));
        });
  }

  dynamic Sumar(List<dynamic> lista, List<String> lista2) {
    double total = 0;
    lista.forEach((p) {
      int i = lista.indexOf(p);
      var t = p * int.parse(lista2[i]);
      total = total + t;
    });
    return total;
  }
}

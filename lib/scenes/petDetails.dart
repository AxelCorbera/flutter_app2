import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app2/scenes/pets.dart';
import 'package:flutter_app2/scripts/mercadopago/json/mascotas.dart';
import 'package:flutter_app2/globals.dart' as globals;
import 'package:flutter_app2/scripts/request.dart';
import 'package:image_picker/image_picker.dart';
//import "package:intl/intl.dart" show DateFormat;

class PetDetails extends StatefulWidget {
  const PetDetails({Key? key, required this.argumentos}) : super(key: key);
  final MascotaSeleccionada argumentos;
  _PetDetailState createState() => _PetDetailState();
}

class _PetDetailState extends State<PetDetails> {
  Mascotas mascotas = new Mascotas(items: []);
  String menu = 'home';
  bool busqueda = true;
  List<MemoryImage> fotos = [];
  int carrito = globals.carrito.id.length;
  bool datos = true;
  bool editar = false;
  XFile imageFile = new XFile('');

  GlobalKey<FormState> _keyForm = GlobalKey();
  String date = "";
  DateTime selectedDate = DateTime.now();

  String nombre = '';
  String apellido = '';
  String sexo = '';
  String raza = '';
  String peso = "";
  DateTime nacimiento = DateTime.now();
  String alarmas = "";
  String observacion = "";
  String lugar = "";
  String telefono = "";
  String domicilio = "";
  String pelaje = "";
  String especie = "";

  File file = File('');
  bool nueva =false;

  @override
  Widget build(BuildContext context) {
    mascotas = widget.argumentos.mascotas;
    fotos = widget.argumentos.fotos;
    int seleccionado = widget.argumentos.seleccionado;
    nacimiento =
        DateTime.parse(mascotas.items[seleccionado].nacimiento.toString());
    print(mascotas.items[seleccionado].sexo);
    print('mascota seleccionada: $seleccionado');
    carrito = globals.carrito.id.length;
    return Scaffold(
      backgroundColor: mascotas.items[seleccionado].sexo == "MACHO"
          ? Colors.cyan
          : Colors.pinkAccent,
      appBar: appbar(mascotas.items[seleccionado].nombre.toString() +
          " " +
          mascotas.items[seleccionado].apellido.toString()),
      body: ListView(
        children: [
          Column(children: <Widget>[
            Stack(children: _detalles(mascotas, seleccionado)),
            Column(children: <Widget>[
              !editar
                  ? Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              datos = true;
                              setState(() {});
                            },
                            child: Container(
                                // optional
                                padding: const EdgeInsets.all(5),
                                decoration: datos
                                    ? BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2.0,
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor)))
                                    : null,
                                child: Text(
                                  'Datos',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          Text(
                            "|",
                            style: TextStyle(
                                color: Theme.of(context).secondaryHeaderColor,
                                fontWeight: FontWeight.bold),
                          ),
                          GestureDetector(
                            onTap: () {
                              datos = false;
                              setState(() {});
                            },
                            child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: !datos
                                    ? BoxDecoration(
                                        border: Border(
                                            bottom: BorderSide(
                                                width: 2.0,
                                                color: Theme.of(context)
                                                    .secondaryHeaderColor)))
                                    : null,
                                child: Text(
                                  'Historial clinico',
                                  style: TextStyle(
                                      color: Theme.of(context)
                                          .secondaryHeaderColor,
                                      fontWeight: FontWeight.bold),
                                )),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      height: 10,
                    ),
            ]),
          ]),
          editar
              ? _form(seleccionado)
              : datos
                  ? _datos(seleccionado)
                  : _historial(seleccionado),
        ],
      ),
    );
  }

  AppBar appbar(String title) {
    return AppBar(
        title: Text(title),
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          RaisedButton(
            color: Theme.of(context).primaryColor,
            elevation: 1,
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/Cart')
                  .then((value) => setState(() {}));
            },
            child: Row(
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 30,
                  color: Colors.white,
                ),
                if (carrito > 0)
                  Center(
                    child: Container(
                      width: 25,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: Center(
                          child: Text(
                        carrito.toString(),
                        style: TextStyle(fontSize: 22, color: Colors.white),
                      )),
                    ),
                  ),
              ],
            ),
          )
        ]);
  }

  Widget _form(int index) {
    return Form(
      key: _keyForm,
      child: Container(
        padding: EdgeInsets.all(15),
        //color: Colors.white,
        constraints: BoxConstraints(
          minWidth: double.infinity,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(5),
        child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: mascotas.items[index].nombre,
                      decoration: InputDecoration(
                        labelText: "Nombre: *",
                      ),
                      onSaved: (value) {
                        nombre = value.toString();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: mascotas.items[index].apellido,
                      decoration: InputDecoration(
                        labelText: "Apellido:",
                      ),
                      onSaved: (value) {
                        apellido = value.toString();
                      },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Este campo es obligatorio';
                      //   }
                      // },
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: mascotas.items[index].especie,
                      decoration: InputDecoration(
                        labelText: "Especie: *",
                      ),
                      onSaved: (value) {
                        especie = value.toString();
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Este campo es obligatorio';
                        }
                      },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: mascotas.items[index].raza,
                      decoration: InputDecoration(
                        labelText: "Raza:",
                      ),
                      onSaved: (value) {
                        raza = value.toString();
                      },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Este campo es obligatorio';
                      //   }
                      // },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                initialValue: mascotas.items[index].pelaje,
                decoration: InputDecoration(
                  labelText: "Pelaje:",
                ),
                onSaved: (value) {
                  pelaje = value.toString();
                },
                // validator: (value) {
                //   if (value!.isEmpty) {
                //     return 'Este campo es obligatorio';
                //   }
                // },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: mascotas.items[index].peso,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: "Peso:",
                      ),
                      onSaved: (value) {
                        peso = value.toString();
                      },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Este campo es obligatorio';
                      //   }
                      // },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField(
                      value: 'HEMBRA',
                      onTap: () {},
                      onSaved: (value) {
                        sexo = value.toString();
                      },
                      onChanged: (value) {},
                      hint: Text(
                        'Sexo',
                      ),
                      isExpanded: true,
                      items: [
                        'HEMBRA',
                        'MACHO',
                      ].map((String val) {
                        return DropdownMenuItem(
                          value: val,
                          child: Text(
                            val,
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  flex: 7,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Fecha de nacimiento:",
                        style: TextStyle(color: Colors.grey[700], fontSize: 17),
                      ),
                      FlatButton(
                        onPressed: () {
                          _selectDate(context, index);
                        },
                        child: Text(
                          "${nacimiento.day}/${nacimiento.month}/${nacimiento.year}",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      //Text("${selectedDate.day}/${selectedDate.month}/${selectedDate.year}")
                    ],
                  ),
                ),
                Flexible(
                  flex: 5,
                  child: TextFormField(
                    initialValue: mascotas.items[index].lugar,
                    decoration: InputDecoration(
                      labelText: "Lugar:",
                    ),
                    onSaved: (value) {
                      lugar = value.toString();
                    },
                    // validator: (value) {
                    //   if (value!.isEmpty) {
                    //     return 'Este campo es obligatorio';
                    //   }
                    // },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: mascotas.items[index].telefono,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        labelText: "Telefono:",
                      ),
                      onSaved: (value) {
                        telefono = value.toString();
                      },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Este campo es obligatorio';
                      //   }
                      // },
                    ),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: mascotas.items[index].domicilio,
                      decoration: InputDecoration(
                        labelText: "Domicilio:",
                      ),
                      onSaved: (value) {
                        domicilio = value.toString();
                      },
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'Este campo es obligatorio';
                      //   }
                      // },
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(8),
              child: RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () {
                  if (_keyForm.currentState!.validate()) {
                    _actualizarMascota(context, index);
                  }
                },
                child: Text(
                  'Editar',
                  style:
                      TextStyle(color: Theme.of(context).secondaryHeaderColor),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _datos(int index) {
    return Container(
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Nacimiento",
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                _nacimiento(mascotas.items[index].nacimiento.toString()),
                SizedBox(
                  height: 10,
                ),
                Text(
                  mascotas.items[index].lugar.toString(),
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                new Divider(
                  height: 20,
                  color: Colors.black,
                ),
                Text(
                  "Telefono",
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  mascotas.items[index].telefono.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Pelaje",
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  mascotas.items[index].pelaje.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' ',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
                new Divider(
                  height: 20,
                  color: Colors.black,
                ),
                Text(
                  "Direccion",
                  style: TextStyle(
                      fontSize: 13,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  mascotas.items[index].domicilio.toString(),
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _nacimiento(String nac) {
    DateTime date = DateTime.parse(nac);
    return Text(
      date.day.toString() +
          '/' +
          date.month.toString() +
          '/' +
          date.year.toString(),
      style: TextStyle(
          fontSize: 15, color: Colors.black, fontWeight: FontWeight.bold),
    );
  }

  Widget _historial(int index) {
    return Column(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "historias clinicas",
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 150,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "",
                      style: TextStyle(
                          fontSize: 13,
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '',
                      style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      ' ',
                      style: TextStyle(
                          fontSize: 10,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<Widget> _detalles(Mascotas mascotas, int index) {
    return <Widget>[
      Container(
        alignment: Alignment.center,
        constraints: BoxConstraints(
            minHeight: 20,
            maxHeight: 350,
            minWidth: 20,
            maxWidth: double.infinity),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.white,
        ),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 2,
                child: Container(
                    //color: Colors.red,
                    )),
            Expanded(
                flex: 1,
                child: Container(
                  //color: Colors.blue,
                  child: Center(
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: _puntos(mascotas, index),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Column(
                                  //mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(children: <Widget>[
                                      Text(
                                        mascotas.items[index].nombre.toString(),
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 22,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      mascotas.items[index].sexo == "MACHO"
                                          ? Icon(
                                              Icons.male,
                                              color: Colors.grey,
                                            )
                                          : Icon(
                                              Icons.female,
                                              color: Colors.grey,
                                            ),
                                    ]),
                                    SizedBox(
                                      height: 12,
                                    ),
                                    Text(
                                      mascotas.items[index].especie.toString() +
                                          ' - ' +
                                          _calcularEdad(mascotas
                                              .items[index].nacimiento
                                              .toString()) +
                                          ' año(s)',
                                      textAlign: TextAlign.start,
                                    )
                                  ]),
                              Column(
                                children: [
                                  Container(child: Text('')),
                                ],
                              ),
                              Column(
                                children: [
                                  Container(
                                      child: FlatButton.icon(
                                          onPressed: () {
                                            editar = !editar;
                                            if(!editar)
                                              nueva=false;
                                            setState(() {});
                                          },
                                          icon: !editar
                                              ? Icon(
                                                  Icons.edit,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                )
                                              : Icon(
                                                  Icons.cancel,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                ),
                                          label: Text(''))),
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
      fotos.length > index
          ? Container(
              alignment: Alignment.center,
              constraints:
                  BoxConstraints(maxHeight: 230, maxWidth: double.infinity),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                //file!=''?FileImage(file):fotos[index]
                image: nueva
                    ? DecorationImage(
                        image: FileImage(file),
                        fit: BoxFit.cover,
                      )
                    : DecorationImage(
                        image: fotos[index],
                        fit: BoxFit.cover,
                      ),
              ),
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white,
                    gradient: LinearGradient(
                        begin: Alignment.center,
                        end: Alignment.bottomCenter,
                        colors: [Colors.transparent, Colors.white])),
              ),
            )
          : nueva?Container(
        alignment: Alignment.center,
        constraints:
        BoxConstraints(maxHeight: 230, maxWidth: double.infinity),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          //file!=''?FileImage(file):fotos[index]
          image: DecorationImage(
            image: FileImage(file),
            fit: BoxFit.cover,
          ),),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              gradient: LinearGradient(
                  begin: Alignment.center,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.white])),
        ),
      ): Container(
              alignment: Alignment.center,
              constraints:
                  BoxConstraints(maxHeight: 230, maxWidth: double.infinity),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
              ),
              child: Icon(
                Icons.pets,
                size: 90,
                color: Colors.grey,
              ),
            ),
      Container(
          alignment: Alignment.bottomRight,
          constraints:
              BoxConstraints(maxHeight: 230, maxWidth: double.infinity),
          decoration: BoxDecoration(
              //shape: BoxShape.rectangle,
              ),
          child: editar?_nuevaFoto(context):null),
    ];
  }

  List<Widget> _puntos(Mascotas mascotas, int index) {
    List<Widget> cant = [];
    Widget relleno = Flexible(
      flex: 5,
      child: SizedBox(
        width: 200,
        height: 20,
      ),
    );
    cant.add(relleno);
    int i = 0;
    mascotas.items.forEach((element) {
      Widget texto = index == i
          ? Flexible(
              flex: 1,
              child: Icon(
                Icons.circle,
                size: 8,
                color: Theme.of(context).primaryColor,
              ))
          : Flexible(
              flex: 1,
              child: Icon(
                Icons.circle,
                size: 8,
                color: Colors.grey,
              ));
      cant.add(texto);
      i++;
    });
    cant.add(relleno);
    return cant;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  _selectDate(BuildContext context, int index) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: DateTime.parse(mascotas.items[index].nacimiento.toString()),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    nacimiento = DateTime.parse(mascotas.items[index].nacimiento.toString());
    if (selected != null && selected != selectedDate)
      setState(() {
        nacimiento = selected;
        selectedDate = selected;
      });
  }

  String _calcularEdad(String nac) {
    DateTime nacimiento = DateTime.parse(nac);
    DateTime ahora = DateTime.now();
    var cuenta = ahora.difference(nacimiento).inDays;
    double diferencia = cuenta / 365;
    if (diferencia.toString().length > 1) {
      return diferencia.toStringAsPrecision(2);
    } else {
      return diferencia.toString();
    }
  }

  Future<void> _actualizarMascota(BuildContext context, int index) async {
    _keyForm.currentState!.save();
    mascotas.items[index].nombre = nombre;
    mascotas.items[index].apellido = apellido;
    mascotas.items[index].sexo = sexo;
    mascotas.items[index].raza = raza;
    mascotas.items[index].peso = peso;
    mascotas.items[index].nacimiento = nacimiento.toString();
    mascotas.items[index].alarmas = alarmas;
    mascotas.items[index].observacion = observacion;
    mascotas.items[index].lugar = lugar;
    mascotas.items[index].telefono = telefono;
    mascotas.items[index].domicilio = domicilio;
    mascotas.items[index].pelaje = pelaje;
    mascotas.items[index].especie = especie;

    cargando(context);
    print('mascotas a actualizad (id) : ' +
        globals.usuario!.id.toString() +
        ' / ' +
        mascotas.toJson().toString());
    String s = await actualizarMascotas(
        globals.usuario!.id.toString(), mascotasToJson(mascotas));
    String s2 = '';
    print('>>> ' + _imagen(imageFile));
    if (_imagen(imageFile).length > 0)
      s2 = await ActualizarFoto(globals.usuario!.id.toString(),
          mascotas.items[index].id.toString(), mascotas.items[index].nombre.toString(), _imagen(imageFile));
    print(s2 + ' <><> ' + _imagen(imageFile));
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  String _imagen(XFile image) {
    File i = File(image.path);

      List<int> imageBytes = i.readAsBytesSync();
      var bytes = base64.encode(imageBytes);
      return bytes;

  }

  void cargando(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CircularProgressIndicator(),
                ),
                SizedBox(
                  height: 20,
                ),
                Text("Editando informacion"),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          );
        });
  }

  Widget _nuevaFoto(BuildContext context) {
    return IconButton(
      alignment: Alignment.bottomRight,
      icon: Icon(Icons.camera_alt),
      onPressed: () {
        _showPickerOpcions(context);
      },
      iconSize: 75,
      color: Theme.of(context).secondaryHeaderColor,
    );
  }

  void _showPickerOpcions(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            children: [
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Camara"),
                onTap: () {
                  Navigator.pop(context);
                  _showPickImage(context, ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.image),
                title: Text("Galeria"),
                onTap: () {
                  Navigator.pop(context);
                  _showPickImage(context, ImageSource.gallery);
                },
              )
            ],
          );
        });
  }

  void _showPickImage(BuildContext context, source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      file = File(image.path);
      imageFile = image;
      nueva = true;
      print(_imagen(image));
      print('hay foto');
    }
    else
      {
        nueva = false;
        file= File('');
        imageFile = XFile('');
        print('NO hay foto');
      }
    setState(() {});
  }
}

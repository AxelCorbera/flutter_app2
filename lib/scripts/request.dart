import 'dart:convert';
import 'package:http/http.dart' as http;

class Album {
  final String id;
  final String token;

  Album({required this.id, required this.token});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      token: json['token'],
    );
  }
}

class Categorias {
  final List<String> cate;

  Categorias({required this.cate});

  factory Categorias.fromJson(Map<String, dynamic> json) {

    var streetsFromJson  = json['marca'];
    //print(streetsFromJson.runtimeType);
    List<String> streetsList = new List<String>.from(streetsFromJson);

    return new Categorias(
      cate: streetsList,
    );
  }
}

Future<Album> IniciarSesion(String email, String clave)async{
  Map map = new Map<String, dynamic>();
  map['email'] = email;
  map['clave'] = clave;

  final response = await http.post(
    Uri.parse('http://wh534614.ispot.cc/mypetshop/flutter/consultaToken.php?'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: map,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    print(jsonDecode(response.body));
    return Album.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

Future<List<String>> BuscarCategoria(String categoria)async{
  List<String> lista;
  Map map = new Map<String, dynamic>();
  print(categoria);
  map['categoria'] = categoria.toLowerCase();

  final response = await http.post(
    Uri.parse('http://wh534614.ispot.cc/mypetshop/buscarMarcas.php?'),
    headers: <String, String>{
      'Content-Type': 'application/x-www-form-urlencoded; charset=UTF-8',
    },
    body: map,
  );
  print(response.statusCode);
  if (response.statusCode == 200) {
    // If the server did return a 200 CREATED response,
    // then parse the JSON.
    print('respuesta ' + jsonDecode(response.body).toString());
    return Categorias.fromJson(jsonDecode(response.body)).cate;
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
//http://wh534614.ispot.cc/mypetshop/buscarMarcas.php?categoria=
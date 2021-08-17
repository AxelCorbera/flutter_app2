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

class Marcas {
  final List<String> id;
  final List<String> codigo;
  final List<String> marca;
  final List<String> nombre;
  final List<String> cantidad;
  final List<String> stock;
  final List<dynamic> precio;
  final List<String> imagen;
  final List<String>? tamano;
  final List<String> color;

  Marcas({required this.id,
    required this.codigo,
    required this.marca,
    required this.nombre,
    required this.cantidad,
    required this.stock,
    required this.precio,
    required this.imagen,
    required this.tamano,
    required this.color,});

  factory Marcas.fromJson(Map<dynamic, dynamic> json) {

    var idJson  = json['id'];
    var codigoJson  = json['codigo'];
    var marcaJson  = json['marca'];
    var nombreJson  = json['nombre'];
    var cantidadJson  = json['cantidad'];
    var stockJson  = json['stock'];
    var precioJson  = json['precio'];
    var imagenJson  = json['imagen'];
    var tamanoJson  = json['tamano'];
    var colorJson  = json['color'];

    //print(streetsFromJson.runtimeType);
    List<String> idList = new List<String>.from(idJson);
    List<String> codigoList = new List<String>.from(codigoJson);
    List<String> marcaList = new List<String>.from(marcaJson);
    List<String> nombreList = new List<String>.from(nombreJson);
    List<String> cantidadList = new List<String>.from(cantidadJson);
    List<String> stockList = new List<String>.from(stockJson);
    List<dynamic> precioList = new List<dynamic>.from(precioJson);
    List<String> imagenList = new List<String>.from(imagenJson);
    if(tamanoJson == "null"){print('ES NULL: ' + tamanoJson.toString());}else{{print('NO ES NULL: ' + tamanoJson.toString());}}
    List<String>? tamanoList = new List<String>.from(tamanoJson);
    List<String> colorList = new List<String>.from(colorJson);

    return new Marcas(
      id: idList,
      codigo: codigoList,
      marca: marcaList,
      nombre: nombreList,
      cantidad: cantidadList,
      stock: stockList,
      precio: precioList,
      imagen: imagenList,
      tamano: tamanoList,
      color: colorList,
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

Future<String> Registrarse(String name, String lastName, String email, String password)async{
  Map map = new Map<String, dynamic>();
  map['name'] = name;
  map['lastname'] = lastName;
  map['email'] = email;
  map['password'] = password;

  final response = await http.post(
    Uri.parse('http://wh534614.ispot.cc/mypetshop/flutter/crearUsuario.php?'),
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
    return response.body;
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
  if(categoria != "alimentoPerro" && categoria != "alimentoGato"){
  map['categoria'] = categoria.toLowerCase();
  }else{
    map['categoria'] = categoria;
  }

  final response = await http.post(
    Uri.parse('http://wh534614.ispot.cc/mypetshop/flutter/buscarMarca.php?'),
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

Future<Marcas> Buscaritems(String categoria, String marca, String busqueda)async{
  Map map = new Map<String, dynamic>();
  print(categoria);
  if(categoria != "alimentoPerro" && categoria != "alimentoGato"){
    map['categoria'] = categoria.toLowerCase();
    map['marca'] = marca;
  }else{
    map['categoria'] = categoria;
    map['marca'] = marca;
  }

  final response = await http.post(
    Uri.parse('http://wh534614.ispot.cc/mypetshop/flutter/consultaItems.php?'),
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
    return Marcas.fromJson(jsonDecode(response.body));
  } else {
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_app2/scripts/album.dart' as album;

Future<album.tokenIngreso> IniciarSesion(String email, String clave) async {
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
    try {
      return album.tokenIngreso.fromJson(jsonDecode(response.body));
    } catch (Exception) {
      album.tokenIngreso a = new album.tokenIngreso(id: '', token: '');
      return a;

    }
  } else {
    album.tokenIngreso a = new album.tokenIngreso(id: '-1', token: '');
    return a;
    // If the server did not return a 201 CREATED response,
    // then throw an exception.
    throw Exception('Failed to create album.');
  }
}

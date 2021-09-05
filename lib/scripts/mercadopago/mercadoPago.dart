import 'dart:convert';

import 'package:flutter_app2/globals.dart' as globals;
import 'package:mercadopago_sdk/mercadopago_sdk.dart';
import 'package:flutter_app2/scripts/mercadopago/cardTokenJson.dart' as Mp;

Future<String> CardToken() async {
  String publicKey = "APP_USR-741bbd2f-ab0c-436b-aad5-40e7fbe47ca1";
  var mp = MP.fromAccessToken(globals.accessToken);

  Map identification = new Map<String, dynamic>();
  identification["type"] = "DNI";
  identification["number"] = "12345678";
  Map cardholder = new Map<String, dynamic>();
  cardholder["name"] = "APRO";
  cardholder["identification"] = identification;
  Map jsonData = new Map<String, dynamic>();
  jsonData["card_number"] = "4509953566233704";
  jsonData["security_code"] = "123";
  jsonData["expiration_month"] = "11";
  jsonData["expiration_year"] = "2025";
  jsonData["cardholder"] = cardholder;
  Map key = new Map<String,String>();
  key["public_key"] = publicKey;


  final result = await mp.post("/v1/card_tokens/",data: jsonData as Map<String,dynamic>,params: key as Map<String,String>);
  try{
    print(result);
    return result.toString();
  }
  catch(Exception){
    print(Exception);
    Mp.CardTokenJson r = new Mp.CardTokenJson();
    r.status = 0;
    print(r.status);
    return r.status.toString();
  }
}
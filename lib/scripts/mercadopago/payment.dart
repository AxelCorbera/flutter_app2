// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

import 'package:flutter_app2/scenes/checkout.dart';

Payment paymentFromJson(String str) => Payment.fromJson(json.decode(str));

String paymentToJson(Payment data) => json.encode(data.toJson());

class Payment {
  Payment({
    this.additionalInfo,
    this.description,
    this.externalReference,
    this.installments,
    this.metadata,
    this.order,
    this.payer,
    this.paymentMethodId,
    this.transactionAmount,
  });

  AdditionalInfo? additionalInfo;
  int? application_fee;
  bool? binary_mode;

  /////QUEDE ACAAAAAA!!!

  String? description;
  String? externalReference;
  int? installments;
  Metadata? metadata;
  Order? order;
  PaymentPayer? payer;
  String? paymentMethodId;
  double? transactionAmount;

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    additionalInfo: AdditionalInfo.fromJson(json["additional_info"]),
    description: json["description"],
    externalReference: json["external_reference"],
    installments: json["installments"],
    metadata: Metadata.fromJson(json["metadata"]),
    order: Order.fromJson(json["order"]),
    payer: PaymentPayer.fromJson(json["payer"]),
    paymentMethodId: json["payment_method_id"],
    transactionAmount: json["transaction_amount"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "additional_info": additionalInfo!.toJson(),
    "description": description,
    "external_reference": externalReference,
    "installments": installments,
    "metadata": metadata!.toJson(),
    "order": order!.toJson(),
    "payer": payer!.toJson(),
    "payment_method_id": paymentMethodId,
    "transaction_amount": transactionAmount,
  };
}

class AdditionalInfo {
  AdditionalInfo({
    this.ip_adress,
    this.items,
    this.payer,
    this.shipments,
    this.barcode,
  });
  String? ip_adress;
  List<Item>? items;
  AdditionalInfoPayer? payer;
  Shipments? shipments;
  Barcode? barcode;

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
    ip_adress: json["ip_adress"],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    payer: AdditionalInfoPayer.fromJson(json["payer"]),
    shipments: Shipments.fromJson(json["shipments"]),
    barcode: Barcode.fromJson(json["barcode"]),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "payer": payer!.toJson(),
    "shipments": shipments!.toJson(),
    "barcode": barcode!.toJson(),
  };
}

class Barcode {
  Barcode(this.type,
      this.content,
      this.width,
      this.height);

  String? type;
  String? content;
  int? width;
  int? height;

  factory Barcode.fromJson(Map<String, dynamic> json) => Barcode(
      json['type'],
      json['content'],
      json['width'],
      json['height']);

  Map<String, dynamic> toJson() => {
    "type":type,
  };
}

class Metadata {
  Metadata();

  factory Metadata.fromJson(Map<String, dynamic> json) => Metadata(
  );

  Map<String, dynamic> toJson() => {
  };
}

class Item {
  Item({
    this.id,
    this.title,
    this.description,
    this.pictureUrl,
    this.categoryId,
    this.quantity,
    this.unitPrice,
  });

  String? id;
  String? title;
  String? description;
  String? pictureUrl;
  String? categoryId;
  int? quantity;
  double? unitPrice;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    pictureUrl: json["picture_url"],
    categoryId: json["category_id"],
    quantity: json["quantity"],
    unitPrice: json["unit_price"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "picture_url": pictureUrl,
    "category_id": categoryId,
    "quantity": quantity,
    "unit_price": unitPrice,
  };
}

class AdditionalInfoPayer {
  AdditionalInfoPayer({
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.registration_date,
  });

  String? firstName;
  String? lastName;
  Phone? phone;
  Metadata? address;
  String? registration_date;

  factory AdditionalInfoPayer.fromJson(Map<String, dynamic> json) => AdditionalInfoPayer(
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: Phone.fromJson(json["phone"]),
    address: Metadata.fromJson(json["address"]),
    registration_date: json["registration_date"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone!.toJson(),
    "address": address!.toJson(),
    "registration_date": registration_date,
  };
}

class Address {
  String? zip_code;
  String? street_name;
  int? street_number;

  Address(this.zip_code,this.street_name,this.street_number);

  factory Address.fromJson(Map<String, dynamic> json) => Address(
      json['zip_code'],
      json['street_name'],
      json['street_number']);

  Map<String, dynamic> toJson() => {
    "zip_code":zip_code,
    "street_name":street_name,
    "street_number":street_number
  };
}

class Phone {
  Phone({
    this.areaCode,
    this.number,
  });

  int? areaCode;
  String? number;

  factory Phone.fromJson(Map<String, dynamic> json) => Phone(
    areaCode: json["area_code"],
    number: json["number"],
  );

  Map<String, dynamic> toJson() => {
    "area_code": areaCode,
    "number": number,
  };
}

class Shipments {
  Shipments({
    this.receiverAddress,
  });

  ReceiverAddress? receiverAddress;

  factory Shipments.fromJson(Map<String, dynamic> json) => Shipments(
    receiverAddress: ReceiverAddress.fromJson(json["receiver_address"]),
  );

  Map<String, dynamic> toJson() => {
    "receiver_address": receiverAddress!.toJson(),
  };
}

class ReceiverAddress {
  ReceiverAddress({
    this.zipCode,
    this.stateName,
    this.cityName,
    this.streetName,
    this.streetNumber,
    this.floor,
    this.apartament
  });

  String? zipCode;
  String? stateName;
  String? cityName;
  String? streetName;
  int? streetNumber;
  String? floor;
  String? apartament;

  factory ReceiverAddress.fromJson(Map<String, dynamic> json) => ReceiverAddress(
    zipCode: json["zip_code"],
    stateName: json["state_name"],
    cityName: json["city_name"],
    streetName: json["street_name"],
    streetNumber: json["street_number"],
    floor: json["floor"],
    apartament: json["apartament"],
  );

  Map<String, dynamic> toJson() => {
    "zip_code": zipCode,
    "state_name": stateName,
    "city_name": cityName,
    "street_name": streetName,
    "street_number": streetNumber,
    "floor": floor,
    "apartament": apartament,
  };
}

class Order {
  Order({
    this.type,
    this.id
  });

  String? type;
  int? id;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    type: json["type"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "id": id,
  };
}

class PaymentPayer {
  PaymentPayer({
    this.entityType,
    this.type,
    this.identification,
  });

  String? entityType;
  String? type;
  Metadata? identification;

  factory PaymentPayer.fromJson(Map<String, dynamic> json) => PaymentPayer(
    entityType: json["entity_type"],
    type: json["type"],
    identification: Metadata.fromJson(json["identification"]),
  );

  Map<String, dynamic> toJson() => {
    "entity_type": entityType,
    "type": type,
    "identification": identification!.toJson(),
  };
}

// To parse this JSON data, do
//
//     final payment = paymentFromJson(jsonString);

import 'dart:convert';

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
    this.items,
    this.payer,
    this.shipments,
    this.barcode,
  });

  List<Item>? items;
  AdditionalInfoPayer? payer;
  Shipments? shipments;
  Metadata? barcode;

  factory AdditionalInfo.fromJson(Map<String, dynamic> json) => AdditionalInfo(
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    payer: AdditionalInfoPayer.fromJson(json["payer"]),
    shipments: Shipments.fromJson(json["shipments"]),
    barcode: Metadata.fromJson(json["barcode"]),
  );

  Map<String, dynamic> toJson() => {
    "items": List<dynamic>.from(items!.map((x) => x.toJson())),
    "payer": payer!.toJson(),
    "shipments": shipments!.toJson(),
    "barcode": barcode!.toJson(),
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
  });

  String? firstName;
  String? lastName;
  Phone? phone;
  Metadata? address;

  factory AdditionalInfoPayer.fromJson(Map<String, dynamic> json) => AdditionalInfoPayer(
    firstName: json["first_name"],
    lastName: json["last_name"],
    phone: Phone.fromJson(json["phone"]),
    address: Metadata.fromJson(json["address"]),
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "phone": phone!.toJson(),
    "address": address!.toJson(),
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
  });

  String? zipCode;
  String? stateName;
  String? cityName;
  String? streetName;
  int? streetNumber;

  factory ReceiverAddress.fromJson(Map<String, dynamic> json) => ReceiverAddress(
    zipCode: json["zip_code"],
    stateName: json["state_name"],
    cityName: json["city_name"],
    streetName: json["street_name"],
    streetNumber: json["street_number"],
  );

  Map<String, dynamic> toJson() => {
    "zip_code": zipCode,
    "state_name": stateName,
    "city_name": cityName,
    "street_name": streetName,
    "street_number": streetNumber,
  };
}

class Order {
  Order({
    this.type,
  });

  String? type;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
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

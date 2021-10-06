import 'package:flutter/material.dart';
import 'package:flutter_app2/globals.dart' as globals;
import 'package:flutter_app2/scenes/addcard.dart';
import 'package:flutter_app2/scenes/infoPayment.dart';
import 'package:flutter_app2/scripts/mercadopago/json/cardsJson.dart' as card;
import 'package:flutter_app2/scripts/mercadopago/payment.dart';
import 'package:flutter_app2/scripts/request.dart' as request;
import 'package:flutter_app2/scripts/mercadopago/responsePayment.dart' as response;

class Checkout extends StatefulWidget {
  const Checkout(
      {Key? key,
      required this.tarjeta,
      required this.total,
      required this.domicilio,
      required this.cuota})
      : super(key: key);

  final TarjetaPago tarjeta;
  final double total;
  final Domicilio domicilio;
  final String cuota;
  @override
  _CheckoutState createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {
  String telefono = '';
  GlobalKey<FormState> _keyform = GlobalKey();
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text("Checkout"),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Card(
            elevation: 5,
            margin: EdgeInsets.all(10),
            child: Container(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Center(
                      child: Text(
                        '¡Ultimo paso!',
                        style: TextStyle(
                            //color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.grey[200],
                    margin: EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Text(
                              'Direccion:',
                              style: TextStyle(
                                  //color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Text(widget.domicilio.calle + ' ' +
                                widget.domicilio.numero.toString() + ' ' +
                                widget.domicilio.piso + ' ' +
                                widget.domicilio.departamento + ', ' +
                                widget.domicilio.localidad + ' ' +
                                widget.domicilio.municipio),
                          ),
                        ),
                        new Divider(),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Text(
                              'Forma de pago:',
                              style: TextStyle(
                                  //color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: widget.tarjeta.datosTarj.numeros!=null?
                            Column(
                              children: [
                                ListTile(
                                  leading: Icon(Icons.payment),
                                  title: Text(widget.tarjeta.cuotasTarj.paymentMethodId
                                      .toString() +
                                      " terminada en " +
                                      widget.tarjeta.datosTarj.numeros
                                          .toString()
                                          .substring(12, 16)),
                                ),
                                widget.cuota != '1'?
                                _cuotasMonto():SizedBox(),
                              ],
                            )
                              :
                            ListTile(
                              leading: Icon(Icons.payments_outlined),
                              title: Text('Efectivo'),
                            ),
                          ),
                        ),
                        new Divider(),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Container(
                            child: Text(
                              'Telefono: *',
                              style: TextStyle(
                                  //color: Colors.black,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                        Center(
                          child: Container(
                            width: 300,
                            child: Form(
                              key: _keyform,
                              child: TextFormField(
                                keyboardType: TextInputType.number,
                                onChanged: (value){
                                  telefono = value;
                                },
                                validator: (value) {
                                  if (value.toString().isEmpty)
                                    return 'El campo es obligatorio';
                                },
                              ),
                            ),
                          ),
                        ),
                        new Divider(),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Envio:',
                            style: TextStyle(
                                //color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            '¡Envio gratis!',
                            style: TextStyle(
                              //color: Colors.black,
                              fontSize: 20,
                              //fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total:',
                            style: TextStyle(
                                //color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),_total()
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          RaisedButton.icon(
            color: Colors.green[300],
            onPressed: () {
              if(_keyform.currentState!.validate()){
                _pagar();
              }
            },
            icon: Icon(Icons.payment),
            label: Text(
              "Pagar",
              style: TextStyle(
                //color: Colors.black,
                fontSize: 20,
                //fontWeight: FontWeight.bold
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _total(){
    if(widget.cuota!='1'){
      int index = 0;
      for(int i =0; i< widget.tarjeta.cuotasTarj.payerCosts!.length;i++){
        if(widget.tarjeta.cuotasTarj.payerCosts![i].installments.toString()==
        widget.cuota){
          index = i;
        }
      }
      String number = widget.tarjeta.cuotasTarj.payerCosts![index].totalAmount!.toStringAsFixed(2);
      double t = double.parse(number);
      return Text(
        '\$ ' + t.toString(),
        style: TextStyle(
          //color: Colors.black,
          fontSize: 20,
          //fontWeight: FontWeight.bold
        ),
      );
    }else {
      return Text(
        '\$ ' + widget.total.toString(),
        style: TextStyle(
          //color: Colors.black,
          fontSize: 20,
          //fontWeight: FontWeight.bold
        ),
      );
    }
  }

  Widget _cuotasMonto(){
      int index = 0;
      for(int i =0; i< widget.tarjeta.cuotasTarj.payerCosts!.length;i++){
        if(widget.tarjeta.cuotasTarj.payerCosts![i].installments.toString()==
            widget.cuota){
          index = i;
        }
      }
      return Text(
        widget.tarjeta.cuotasTarj.payerCosts![index].installments.toString()+
            ' cuotas de \$ ' + widget.tarjeta.cuotasTarj.payerCosts![index].installmentAmount.toString(),

      );

  }

  void _cargando() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(content: Center(
            child: CircularProgressIndicator(

            ),
          ));
        });
  }

  void _pagar() async{
    print(widget.tarjeta.idTarjeta);

    Payment pago = new Payment();
    pago.additionalInfo = AdditionalInfo();
    pago.additionalInfo!.items = [];
    Item item = new Item(id: 'PR0001',
    title: 'Moritas PetShop',
    //pictureUrl: '',
    categoryId: 'Pets',
    quantity: 1,
    unitPrice: widget.total);
    pago.additionalInfo!.items!.add(item);
    pago.additionalInfo!.payer = new AdditionalInfoPayer();
    pago.additionalInfo!.payer!.firstName = globals.usuario!.nombre.toString();
    pago.additionalInfo!.payer!.lastName = globals.usuario!.apellido.toString();
    pago.additionalInfo!.payer!.phone = new Phone();
    pago.additionalInfo!.payer!.phone!.areaCode = 11;
    pago.additionalInfo!.payer!.phone!.number = telefono;
    pago.additionalInfo!.payer!.address = new Address();
    pago.additionalInfo!.shipments = new Shipments();
    pago.additionalInfo!.shipments!.receiverAddress = new ReceiverAddress();
    pago.additionalInfo!.shipments!.receiverAddress!.zipCode = '';
    pago.additionalInfo!.shipments!.receiverAddress!.stateName = widget.domicilio.provincia;
    pago.additionalInfo!.shipments!.receiverAddress!.cityName = widget.domicilio.localidad;
    pago.additionalInfo!.shipments!.receiverAddress!.streetName = widget.domicilio.calle;
    pago.additionalInfo!.shipments!.receiverAddress!.streetNumber = widget.domicilio.numero;
    pago.additionalInfo!.shipments!.receiverAddress!.floor = widget.domicilio.piso;
    pago.additionalInfo!.shipments!.receiverAddress!.apartment = widget.domicilio.departamento;
    // pago.additionalInfo!.barcode = new Barcode();
    // pago.additionalInfo!.barcode!.content = '';
    // pago.additionalInfo!.barcode!.type = '';
    // pago.additionalInfo!.barcode!.width = 0;
    // pago.additionalInfo!.barcode!.height = 0;
    pago.application_fee = 1;
    pago.binary_mode = false;
    //pago.callback_url = 'https://app-till.com/index.php/contact/';
    pago.campaign_id = 0;
    pago.capture = true;
    //pago.coupon_amount = 10;
    //pago.coupon_code = '';
    //pago.date_of_expiration = '2021-07-10T14:47:58.000Z';
    pago.description = 'Pago por productos';
    pago.differential_pricing_id = 0;
    pago.externalReference = 'Moritas Petshop';
    pago.installments = int.parse(widget.cuota);
    //pago.issuer_id = null;
    pago.metadata = new Metadata();
    //pago.notification_url = 'https://app-till.com/index.php/contact/';
    pago.order = new Order();
    pago.order!.type = 'mercadopago';
    pago.order!.id = 1;
    pago.payer = PaymentPayer();
    pago.payer!.entityType = 'individual';
    pago.payer!.type = 'customer';
    pago.payer!.id = globals.usuario!.idcustomer;
    pago.payer!.email = globals.usuario!.correo;
    pago.payer!.identification = new Identification();
    pago.payer!.identification!.type = widget.tarjeta.datosTarj.docTipo;
    pago.payer!.identification!.number = widget.tarjeta.datosTarj.docNum;
    pago.payer!.first_name = globals.usuario!.nombre;
    pago.payer!.last_name = globals.usuario!.apellido;
    pago.paymentMethodId = widget.tarjeta.cuotasTarj.paymentMethodId;
    pago.statement_descriptor = 'Moritas Petshop';
    pago.token = widget.tarjeta.idTarjeta;
    pago.transactionAmount = widget.total;

    _cargando();

    try {
      response.ResponsePayment resp = await request.CrearPago(pago);
      print(resp);
      Navigator.pop(context);
    }catch(Exception){
      print(Exception);
      Navigator.pop(context);
    }

  }
}


class ArgumentosCheckout {
  final TarjetaPago tarjeta;
  final double total;
  final Domicilio domicilio;
  final String cuotas;
  ArgumentosCheckout(this.tarjeta, this.total, this.domicilio, this.cuotas);
}

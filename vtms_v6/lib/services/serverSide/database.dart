import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'dart:convert';
import 'package:vtms_v6/services/serverSide/authentication.dart';

final String ngrokURL = receiveUrl();

class ShipmentDetails{

// Get user-entered details from AddShipment screen -> Push to ConfirmationScreen
  Future newShipment(String userID,  TextEditingController supplier, TextEditingController customer,
                                     TextEditingController vaccine,  TextEditingController driver,
                                     TextEditingController dispatch, TextEditingController arrival,
                                     TextEditingController comments, BuildContext context) async {
    
    String uSupplier  = supplier.text;  String uCustomer = customer.text;
    String uVials     = vaccine.text;   String uDriver   = driver.text;
    String uDispatchT = dispatch.text;  String uArrivalT = arrival.text;
    String uComments  = comments.text;
    for (int i=0;i<20;i++){
      var k = Uuid();
      var lol = k.v4().substring(0, 8).toUpperCase();
      print(lol);
    }
    // generate ShipmentID
    var genUID = Uuid();
    var genShipment = genUID.v4().substring(0, 8).toUpperCase(); // Randomized Shipment ID [8 Digits]

    for (int i=0;i<20;i++){
      var k = Uuid();
      var lol = k.v4().substring(0, 8).toUpperCase();
      print(lol);
    }

    return Navigator.pushReplacementNamed(context, '/confirmPage', arguments: {
      'supplier': uSupplier   ?? 'null',
      'customer': uCustomer   ?? 'null',
      'vaccine':  uVials      ?? 'null',
      'dispatch': uDispatchT  ?? 'Not Set',
      'arrival':  uArrivalT   ?? 'Not Set',
      'driver':   uDriver     ?? 'null',
      'comments': uComments   ?? 'null',
      'uid':      userID      ?? 'null',
      'sid':      genShipment ?? 'null',
    });
  }


  // Enter shipment details into database
  Future shipmentEntry(String uid,      String supplier, String customer, String genID,    String comments,
                       String dispatch, String status,   String vials,    String driver,   String arrival,  BuildContext context) async {

    // Enter into DB
    var url = ngrokURL + "add_shipment.php";
    var response = await http.post(Uri.parse(url), 
    body: {
      "supplier":   supplier,
      "customer":   customer,
      "dispatch":   dispatch,
      "arrival":    arrival,
      "vialCount":  vials,
      "driver":     driver,
      "comments":   comments,
      "status":     status,
      "UID":        uid,
      "SID":        genID,
    });

    var data = json.decode(response.body);
    if(data == "Error"){
    showDialog(context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: Text("Shipment ID Already Exists", textScaleFactor: 1.2),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Fail'),
            onPressed: () { 
              Navigator.of(context).pop();
               })
        ]));
    }else{
      showDialog(context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: Text("Successful Shipment Entry", textScaleFactor: 1.2),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('OK'),
            onPressed: () { 
              Navigator.popUntil(context, ModalRoute.withName('/loggedIn'));
               })
        ]));
    }
  }

}
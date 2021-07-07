import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customBtn.dart';
import 'package:vtms_v6/components/customContainer.dart';
import 'package:vtms_v6/services/serverSide/MQTT.dart';
import 'package:vtms_v6/services/serverSide/database.dart';

class LoaderTwo extends StatefulWidget {

  @override
  _LoaderTwoState createState() => _LoaderTwoState();
}

class _LoaderTwoState extends State<LoaderTwo> {
  final MQTTwrapper _publishData = MQTTwrapper();
  bool loading = false;
  Map data = {};
  String sid, uid, supplier, customer, vials, dispatch, arrival, driver, comments, status, qr; 

  @override
  Widget build(BuildContext context) {
    data = data.isNotEmpty ? data : ModalRoute.of(context).settings.arguments;
    uid       = data['uid'];
    sid       = data['sid'];  // auto generated shipment ID
    vials     = data['vaccine'];   // vial count
    supplier  = data['supplier'];
    customer  = data['customer'];
    dispatch  = data['dispatch'];  // dispatch time 
    arrival   = data['arrival'];  // arrival time 
    driver    = data['driver'];    //driver name
    comments  = data['comments'];
    status    = data['status'];
    qr        = data['QR'];

    return Scaffold(
      body: CustomContainer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('QR Code Captured', style: TextStyle(fontSize: 20, fontFamily: 'inconsolata', color: cyan200)),
            Text('Finalise Shipment Entry', style: TextStyle(fontSize: 22, fontFamily: 'inconsolata', color: cyan200)),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ButtonExtra(text: 'CANCEL',
                  color: pageBackground,
                  textColor: red600,
                  bHeight: 40,
                  bWidth: 100,
                  fontSize: 16,
                  borderColor: red900,
                  onPressed: () => Navigator.popUntil(context, ModalRoute.withName('/loggedIn')),
                ),
                SizedBox(width: 15),
                ButtonExtra(text: 'YES',
                  color: pageBackground,
                  textColor: btnGreen2,
                  fontSize: 16,
                  bHeight: 40,
                  bWidth: 100,
                  borderColor: btnGreen1,
                  onPressed: () => setState(() { shipmentQR(uid, supplier, customer, sid, comments, dispatch, status, vials, driver, arrival, qr, context); }),
                ), 
              ],
            ),
          ],
        )
      ),
    );
  }

 Future shipmentQR(String uid,      String supplier, String customer, String genID,    String comments,
                    String dispatch, String status,   String vials,    String driver,   String arrival, String qrCode, BuildContext context) async {
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
    if (data == "Success"){
      var url = ngrokURL + "link_shipment.php";
      var response = await http.post(Uri.parse(url), 
      body: {
        "MMD":        qrCode,
        "SID":        genID,
      });
      // Publish MMD ID and SID to appropriate MQTT feed
     // _publishData.updateMQTT(genID, qrCode);

      showDialog(context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: Text("Succesfull Shipment Link", textScaleFactor: 1.2),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Return'),
            onPressed: () { 
              Navigator.popUntil(context, ModalRoute.withName('/loggedIn'));
               })
        ]));

    }else{
      showDialog(context: context,
      builder: (_) => new CupertinoAlertDialog(
        content: Text("Unexpected Error", textScaleFactor: 1.2),
        actions: [
          // ignore: deprecated_member_use
          FlatButton(
            child: Text('Return'),
            onPressed: () { 
              Navigator.popUntil(context, ModalRoute.withName('/loggedIn'));
               })
        ]));   
    }
  }

}

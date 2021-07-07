import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customContainer.dart';



class ShipmentByQR extends StatefulWidget {

  @override
  _ShipmentByQRState createState() => _ShipmentByQRState();
}

class _ShipmentByQRState extends State<ShipmentByQR> {
  Map data = {};
  String sid, uid, supplier, customer, vials, dispatch, arrival, driver, comments, status; 
  bool result = false, scanRes;
  var qrdata;
  Future<bool> x;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController controller;
  Barcode barcode;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Future<void> reassemble() async {
    super.reassemble();
    if (Platform.isAndroid){
      await controller.pauseCamera();
    }
    controller.resumeCamera();
  }
  
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

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: appBarColor,
        title: Text("QR Scanner", style: customtxtStyle),
      ),
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(bottom: 15, child: buildResult()),
          Positioned(top: 10, child: buildControlButtons())
        ],
      )
    );
  }
  Widget buildQrView(BuildContext context) => QRView(
    key: qrKey,
    onQRViewCreated: _onQRViewCreated,
    overlay: QrScannerOverlayShape(
      borderWidth: 10,
      borderLength: 20,
      borderRadius: 10,
      borderColor: red900,
      cutOutSize: MediaQuery.of(context).size.width*0.8,
    ),
  );
  
  Widget buildResult() => Container(
    padding: EdgeInsets.all(10),
    decoration: BoxDecoration(color: Colors.white24),
    child: Text(
      barcode != null ? 'Scanned Result: ${barcode.code}' : 'Computing..',
      maxLines: 3,
    ),
  );

  Widget buildControlButtons() => Container(
    padding: EdgeInsets.symmetric(horizontal: 10),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: Colors.white24,
    ),
    child: Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          icon: Icon(Icons.highlight_remove_outlined, size: 35),
          onPressed: () {  Navigator.of(context).pop(); },
        ),
      ],
    ),
  );

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);
    controller.scannedDataStream.listen((scanData) async {
      setState(() => this.barcode = scanData);
      controller.pauseCamera();
      qrdata = scanData.code.toString().toUpperCase();

        if (scanData != null) {
          controller.pauseCamera();
          Navigator.pushReplacementNamed(context, '/qrLoader', 
            arguments: {
              'supplier': supplier        ?? 'null',
              'customer': customer        ?? 'null',
              'vaccine':  vials           ?? 'null',
              'dispatch': dispatch        ?? 'Not Set',
              'arrival':  arrival         ?? 'Not Set',
              'driver':   driver          ?? 'null',
              'comments': comments        ?? 'null',
              'uid':      uid             ?? 'null',
              'sid':      sid             ?? 'null',
              'status':   status          ?? 'null',
              'QR':       qrdata          ?? 'null',
              });
            }
          controller.resumeCamera();
          });    
      }

  }


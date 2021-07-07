import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customContainer.dart';
import 'package:vtms_v6/services/serverSide/authentication.dart';
import 'package:http/http.dart' as http;

// ignore: camel_case_types
class QR_Scan extends StatefulWidget {

  @override
  _QR_ScanState createState() => _QR_ScanState();
}

// ignore: camel_case_types
class _QR_ScanState extends State<QR_Scan> {
  bool result = false, scanRes;
  var qrdata;
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

    void _onQRViewCreated(QRViewController controller) {
      setState(() => this.controller = controller);

      controller.scannedDataStream.listen((scanData) async {
        setState(() => this.barcode = scanData);
        controller.pauseCamera();
        qrdata = scanData.code.toString();
          if (scanData != null) {
            var url = ngrokURL + "mmd_search.php";
            var response = await http.post(Uri.parse(url), body: { "MMD": qrdata.toUpperCase() });
            var user = json.decode(response.body);
            if(user == "Success"){
              Navigator.pushNamedAndRemoveUntil(context, '/searched', (route) => false, arguments: {"MMD": qrdata.toUpperCase() });

            }else if(user == "Error"){
              showDialog(context: context,
                builder: (_) => new CupertinoAlertDialog(
                  content: Text("Scanned MMD Does Not Exist", textScaleFactor: 1.2),
                  actions: [
                    // ignore: deprecated_member_use
                    FlatButton(
                      child: Text('Retry'),
                      onPressed: () { 
                        Navigator.popUntil(context, ModalRoute.withName('/preQR'));
                        //Navigator.of(context).pop();
                        //Navigator.pushNamedAndRemoveUntil(context, '/preQR', (route) => false);
                        })
                  ]));
            }
          }
   
      controller.resumeCamera();
    });

  }

}
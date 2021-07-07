import 'dart:io';
import 'package:flutter/material.dart';
import 'package:vtms_v6/models/admin/add_shipment.dart';
import 'package:vtms_v6/models/admin/confirmation.dart';
import 'package:vtms_v6/models/admin/logged_in.dart';
import 'package:vtms_v6/models/admin/parm_view.dart';
import 'package:vtms_v6/models/admin/preLogin.dart';
import 'package:vtms_v6/models/guest/searched_parm.dart';
import 'package:vtms_v6/models/shared/QR_Loader.dart';
import 'package:vtms_v6/models/shared/QR_shipment.dart';
import 'package:vtms_v6/models/shared/register.dart';
import 'package:vtms_v6/screens/QR_screen/QR_scan.dart';
import 'package:vtms_v6/screens/QR_screen/body.dart';
import 'package:vtms_v6/screens/mainFrame.dart';
import 'package:vtms_v6/screens/settings_screen/settings.dart';
import 'package:vtms_v6/screens/start_screen/start.dart';
import 'package:vtms_v6/services/loader.dart';

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}

void main() => runApp(VTMS());

class VTMS extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    HttpOverrides.global = new MyHttpOverrides();
    return WillPopScope(
      onWillPop: () async => false,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(canvasColor: Colors.transparent),
        home: MainFrame(),
        routes: {
          '/userReg':     (context) => RegisterUser(),
          '/loggedIn':    (context) => LoggedIn(),
          '/mainFrame':   (context) => MainFrame(),
          '/startPage':   (context) => Start(),
          '/addShipment': (context) => AddShipment(),
          '/confirmPage': (context) => Confirmation(),
          '/loader':      (context) => Loader(),
          '/QR':          (context) => QR_Scan(),
          '/viewParm':    (context) => DbParameters(),
          '/settings':    (context) => Settings(),
          '/searched':    (context) => SearchedParm(),
          '/preScan':     (context) => PreQR(),
          '/preLogin':    (context) => SelectSID(),
          '/shipmentQR':  (context) => ShipmentByQR(),
          '/qrLoader':    (context) => LoaderTwo(),
          '/preQR':       (context) => PreQR()
        },
      ),
    );
  }
}
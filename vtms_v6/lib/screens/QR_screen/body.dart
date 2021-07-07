import 'package:flutter/material.dart';
import 'package:vtms_v6/components/colorConstants.dart';
import 'package:vtms_v6/components/customBtn.dart';
import 'package:vtms_v6/components/customContainer.dart';

class PreQR extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("QR Scanner", style: customtxtStyle),
      ),
      
    body: CustomContainer(
      child: Column(
          children: [
            SizedBox(height: 25),
            Text('Click the Scan Button and face device camera to the QR Code', 
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 17, letterSpacing: 1.5, color: lightOrange, fontFamily: 'inconsolata')),
            SizedBox(height: 15),
            Container(height: 300, width: 300,
              decoration: BoxDecoration(shape: BoxShape.rectangle,
                image: DecorationImage(
                image: AssetImage('lib/assets/qr_icon2.png'),
                fit: BoxFit.fill 
            ) ) ),
            FormatButton(text: 'Start Scan',
              color: btnBlue2,
              fontSize: 16,
              buttonWidth: 0.4,
              onPressed: () { Navigator.pushReplacementNamed(context, '/QR'); },
            ),
            
          ],
        ),
        
        
      ),
    );
  }
}